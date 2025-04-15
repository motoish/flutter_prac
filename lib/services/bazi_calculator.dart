import 'package:flutter_prac/models/bazi_chart.dart';
import 'package:flutter_prac/models/birth_data.dart';
import 'package:flutter_prac/services/solar_term_service.dart';

final List<String> tianGan = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
final List<String> diZhi = [
  '子',
  '丑',
  '寅',
  '卯',
  '辰',
  '巳',
  '午',
  '未',
  '申',
  '酉',
  '戌',
  '亥',
];
final solarTermService = SolarTermService();

/// 节气名 → 八字命理月份（1-12）
final Map<String, int> jieqiToLunarMonth = {
  '立春': 1,
  '惊蛰': 2,
  '清明': 3,
  '立夏': 4,
  '芒种': 5,
  '小暑': 6,
  '立秋': 7,
  '白露': 8,
  '寒露': 9,
  '立冬': 10,
  '大雪': 11,
  '小寒': 12,
};

Future<BaZiChart> calculateBaZi(BirthData data) async {
  final year = data.date.year;
  final month = data.date.month;
  final day = data.date.day;

  final adjustedYear = await solarTermService.isBeforeLiChun(data.date)
      ? data.date.year - 1
      : data.date.year;

  final yearIndex = (adjustedYear - 4) % 60;
  final yearGan = tianGan[yearIndex % 10];
  final yearZhi = diZhi[yearIndex % 12];

  final currentJieqi = await solarTermService.getLastSolarTermBefore(data.date);
  int lunarMonth = 1;
  if (currentJieqi != null) {
    lunarMonth = jieqiToLunarMonth[currentJieqi.name] ?? 1;
  }

  final monthIndex = (lunarMonth - 1) % 12;
  final monthGan = tianGan[(yearIndex * 2 + lunarMonth) % 10];
  final monthZhi = diZhi[monthIndex];

  final dayNum =
      DateTime(year, month, day).difference(DateTime(1900, 1, 1)).inDays;
  final dayGan = tianGan[(dayNum + 10) % 10];
  final dayZhi = diZhi[(dayNum + 12) % 12];

  GanZhi? hourPillar;
  if (data.hour != null) {
    final index = ((data.hour! + 1) ~/ 2) % 12;
    final hourZhi = diZhi[index];
    final hourGan = tianGan[(dayNum * 2 + index) % 10];
    hourPillar = GanZhi(hourGan, hourZhi);
  }

  return BaZiChart(
    year: GanZhi(yearGan, yearZhi),
    month: GanZhi(monthGan, monthZhi),
    day: GanZhi(dayGan, dayZhi),
    hour: hourPillar,
  );
}
