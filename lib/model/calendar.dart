import 'package:stv_test/data_source/schedule.dart';

class Calendar {
  final DateTime date;
  final bool enabled;
  final List<ScheduleData> schedules;

  Calendar({
    required this.date,
    required this.enabled,
    required this.schedules,
  });

  bool isThatDay(DateTime thatDay) =>
      date.difference(thatDay).inDays == 0 && date.day == thatDay.day;
}
