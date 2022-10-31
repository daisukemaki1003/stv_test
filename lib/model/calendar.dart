import 'package:stv_test/model/schedule.dart';

class Calendar {
  final DateTime date;
  final bool enabled;

  Calendar({
    required this.date,
    required this.enabled,
  });

  bool isToday() => date == DateTime.now();
}
