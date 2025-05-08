class BirthData {
  final String? name;
  final String gender;
  final DateTime date;

  BirthData({
    this.name,
    required this.gender,
    required this.date,
  });

  @override
  String toString() {
    final timeStr =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return '姓名: $name, 性别: $gender, 日期: $date, 时间: $timeStr';
  }
}
