class Calendar {
  final DateTime date;
  final bool enabled;

  Calendar({
    required this.date,
    required this.enabled,
  });

  bool isToday() => date == DateTime.now();
}
