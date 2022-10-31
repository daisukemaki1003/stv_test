import 'package:stv_test/model/schedule.dart';

class Calendar {
  final DateTime date;
  final bool enabled;
  final List<Schedule> schedules;

  Calendar({
    required this.date,
    required this.enabled,
    required this.schedules,
  });

  bool isToday() => date == DateTime.now();
}
