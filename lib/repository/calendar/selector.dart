import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/utils/create_calendar_list.dart';

final targetYearProvider = StateProvider<int>((ref) => DateTime.now().year);
final targetMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

final calendarListProvider = Provider<List<List<Calendar>>>((ref) {
  final year = ref.watch(targetYearProvider);
  final month = ref.watch(targetMonthProvider);

  return createCalendarList(year, month);
});
