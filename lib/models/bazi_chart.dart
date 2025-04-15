class GanZhi {
  final String gan;
  final String zhi;

  GanZhi(this.gan, this.zhi);

  @override
  String toString() => '$gan$zhi';
}

class BaZiChart {
  final GanZhi year;
  final GanZhi month;
  final GanZhi day;
  final GanZhi? hour;

  BaZiChart({
    required this.year,
    required this.month,
    required this.day,
    this.hour,
  });

  @override
  String toString() {
    return '年柱: $year, 月柱: $month, 日柱: $day, 时柱: ${hour ?? '未知'}';
  }
}
