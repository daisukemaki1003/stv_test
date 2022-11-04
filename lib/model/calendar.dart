import 'package:stv_test/data_source/schedule.dart';

class Calendar {
  final DateTime date;
  final bool enabled;

  Calendar({
    required this.date,
    required this.enabled,
  });

  bool isThatDay(DateTime thatDay) =>
      date.difference(thatDay).inDays == 0 && date.day == thatDay.day;

  Calendar copy({
    DateTime? date,
    bool? enabled,
    List<ScheduleData>? schedules,
  }) =>
      Calendar(
        date: date ?? this.date,
        enabled: enabled ?? this.enabled,
      );
}
