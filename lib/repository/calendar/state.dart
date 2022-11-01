import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/utils/create_calendar_list.dart';

/// プロバイダー
final calendarNotifierProvider =
    StateNotifierProvider<CalendarNotifier, List<Calendar>>((ref) {
  return CalendarNotifier(ref)..initialize();
});

/// ステート
class CalendarNotifier extends StateNotifier<List<Calendar>> {
  CalendarNotifier(this.ref) : super(List.empty());

  final Ref ref;

  Future<void> initialize() async {
    await fetchList();
  }

  fetchList() async {
    // final calendarList = ref.watch(calendarListProvider);
    final year = ref.watch(targetYearProvider);
    final month = ref.watch(targetMonthProvider);

    state = createCalendarList(year, month);
    // state = calendarList;
  }

  setSchedule(List<ScheduleData> schedules) {
    final days = state;
    for (var day in days) {
      final results =
          schedules.where((element) => day.isThatDay(element.from)).toList();
      if (results.isNotEmpty) day.schedules.addAll(results);
    }
    state = days;
  }
}
