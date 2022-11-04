import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/utils/create_calendar_list.dart';

/// カレンダーの選択された年月
final selectedYearAndMonthInCalendarProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

/// 選択されたカレンダーセルの日付
final selectedDateInCalendarProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

/// 選択された日付のカレンダーデータ
final targetCalenderCellProvider = StateProvider<Calendar>((ref) {
  final targetDate = ref.watch(selectedDateInCalendarProvider);

  return Calendar(
    date: targetDate,
    enabled: false,
    // schedules: scheduleNotifier.fetch(targetDate),
  );
});

/// 今月のカレンダーデータ
final thisMonthCalendeProvider = Provider<List<Calendar>>((ref) {
  final selectedMonth = ref.watch(selectedYearAndMonthInCalendarProvider);

  return createCalendarList(
    selectedMonth.year,
    selectedMonth.month,
  );
});
