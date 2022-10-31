class Calendar {
  final DateTime date;
  final bool isSchedule;

  Calendar({
    required this.date,
    required this.isSchedule,
  });

  bool isToday() => date == DateTime.now();
}
