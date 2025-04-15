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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          color: color,
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
      final ganColor = colorForWuXing(ganToWuXing[gan]!);
      final zhiColor = colorForWuXing(zhiToWuXing[zhi]!);
      final ganWuXing = getWuXingName(ganToWuXing[gan]!);
      final zhiWuXing = getWuXingName(zhiToWuXing[zhi]!);

      final ss = i == 2 ? '日主' : getShiShen(riGan, gan);

      ganRow.add(_buildCell(gan, color: ganColor));
      zhiRow.add(_buildCell(zhi, color: zhiColor));
      wuXingRow.add(_buildCell('($ganWuXing/$zhiWuXing)',
          color: Colors.grey[600], fontSize: 13));
      shiShenRow.add(_buildCell(ss, color: Colors.grey[700]));
    }

    final dateStr = DateFormat('yyyy-MM-dd HH:mm').format(birthDate);
    final lunar = Lunar.fromDate(birthDate);
    final lunarStr =
        '${lunar.getYearInChinese()}年${lunar.getMonthInChinese()}月${lunar.getDayInChinese()}日 ${lunar.getTimeZhi()}时';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Text(
                '${name != null && name!.isNotEmpty ? '$name ・ ' : ''}$gender ・ 出生时间：$dateStr',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
