import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/calendar/state.dart';
import 'package:stv_test/repository/schedule/state.dart';
import 'package:stv_test/view/calender_cell_list/calender_cell_list_component.dart';

class CalendarCellListContainer extends ConsumerWidget {
  const CalendarCellListContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択中の日付
    final selectedDateInCalendar =
        ref.watch(selectedDateInCalendarProvider.state);

    /// 選択中の月のカレンダー日付リスト
    final calendar = ref.watch(calendarNotifierProvider);
    final calendarNotifier = ref.watch(calendarNotifierProvider.notifier);

    /// スケジュールリスト
    final scheduleNotifier = ref.watch(scheduleNotifierProvider);

    /// スケジュールの取得を待機
    return scheduleNotifier.when(
      error: (error, stacktrace) => Text(error.toString()),
      loading: CircularProgressIndicator.new,
      data: (data) {
        /// スケジュールセット
        calendarNotifier.setSchedule(data);
        return CalendarCellListComponent(
          calendar: calendar,
          calendarCellOnTap: (date) {
            selectedDateInCalendar.state = date;
          },
        );
      },
    );
  }
}
