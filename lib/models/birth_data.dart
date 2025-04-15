class BirthData {
  final String? name;
  final String gender;
  final DateTime date;
  final int? hour;
  final int? minute;

  BirthData({
    this.name,
    required this.gender,
    required this.date,
    this.hour,
    this.minute,
  });

  @override
  String toString() {
    final timeStr = (hour != null && minute != null)
        ? '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}'
        : '未知时间';
    return '姓名: $name, 性别: $gender, 日期: $date, 时间: $timeStr';
  }
}
