import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:flutter_prac/models/bazi_chart.dart';
import 'package:flutter_prac/services/shishen_service.dart';
import 'package:flutter_prac/services/wuxing_service.dart';

class BaZiResultCard extends StatelessWidget {
  final BaZiChart chart;
  final DateTime birthDate;
  final String? name;
  final String gender;

  const BaZiResultCard({
    super.key,
    required this.chart,
    required this.birthDate,
    this.name,
    required this.gender,
  });

  Widget _buildCell(String text,
      {Color? color, FontWeight? weight, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: weight ?? FontWeight.normal,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildRow(List<Widget> children) {
    return TableRow(children: children);
  }

  String getShiChen(DateTime dt) {
    final hour = dt.hour;
    final minute = dt.minute;
    final totalMinutes = hour * 60 + minute;
    const zhis = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
    final index = ((totalMinutes + 60) ~/ 120) % 12;
    return zhis[index];
  }

  @override
  Widget build(BuildContext context) {
    final riGan = chart.day.gan;

    final pillars = [chart.year, chart.month, chart.day, chart.hour];
    final labels = ['年柱', '月柱', '日柱', '时柱'];

    final ganRow = <Widget>[];
    final zhiRow = <Widget>[];
    final shiShenRow = <Widget>[];
    final wuXingRow = <Widget>[];

    for (var i = 0; i < 4; i++) {
      final pillar = pillars[i];
      if (pillar == null) {
        ganRow.add(_buildCell('—'));
        zhiRow.add(_buildCell('—'));
        wuXingRow.add(_buildCell('—'));
        shiShenRow.add(_buildCell('—'));
        continue;
      }

      final gan = pillar.gan;
      final zhi = pillar.zhi;
      final ganXing = ganToWuXing[gan]!;
      final zhiXing = zhiToWuXing[zhi]!;
      final ganColor = colorForWuXing(ganXing);
      final zhiColor = colorForWuXing(zhiXing);

      final ganWuXing = getWuXingName(ganXing);
      final zhiWuXing = getWuXingName(zhiXing);
      final ss = i == 2 ? '日主' : getShiShen(riGan, gan);

      ganRow.add(_buildCell(gan, color: ganColor, weight: FontWeight.bold));
      zhiRow.add(_buildCell(zhi, color: zhiColor));
      wuXingRow.add(
        _buildCell('$ganWuXing / $zhiWuXing',
            color: Colors.brown[600], fontSize: 13),
      );
      shiShenRow.add(
        _buildCell(ss, color: Colors.blueGrey[700], fontSize: 14),
      );
    }

    final dateStr = DateFormat('yyyy-MM-dd HH:mm').format(birthDate);
    final lunar = Lunar.fromDate(birthDate);
    final lunarStr =
        '${lunar.getYearInChinese()}年${lunar.getMonthInChinese()}月${lunar.getDayInChinese()}日 ${getShiChen(birthDate)}时';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              Text(
                '${name != null && name!.isNotEmpty ? '$name ・ ' : ''}$gender ・ 出生时间：$dateStr',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                '农历：$lunarStr',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
              },
              children: [
                _buildRow(labels
                    .map((e) => _buildCell(e, weight: FontWeight.bold))
                    .toList()),
                _buildRow(ganRow),
                _buildRow(zhiRow),
                _buildRow(wuXingRow),
                _buildRow(shiShenRow),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
