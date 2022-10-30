class Schedule {
  final int id;
  final String name;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  final String comment;

  Schedule({
    required this.id,
    required this.name,
    required this.from,
    required this.to,
    required this.isAllDay,
    required this.comment,
  });

  toJson() {}
  copy({int? id}) {}
  static fromJson(Map json) {}
}
