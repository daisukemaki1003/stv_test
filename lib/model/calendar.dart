class Calendar {
  final DateTime date;
  final bool enabled;

  Calendar({
    required this.date,
    required this.enabled,
  });

  // bool isToday() => date == DateTime.now();
  bool isToday() =>
      date.difference(DateTime.now()).inDays == 0 &&
      date.day == DateTime.now().day;
}
