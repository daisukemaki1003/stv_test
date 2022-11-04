import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/schedule/state.dart';
import 'package:stv_test/utils/create_calendar_list.dart';
import 'package:stv_test/view/calender_cell_list/calender_cell_list_component.dart';

class CalendarCellListContainer extends ConsumerWidget {
  const CalendarCellListContainer(this.selectedDate, {super.key});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択したカレンダーの日付
    final selectedDateInCalendar =
        ref.watch(selectedDateInCalendarProvider.state);

    /// スケジュールリスト
    final scheduleNotifierState = ref.watch(scheduleNotifierProvider);
    final scheduleNotifier = ref.watch(scheduleNotifierProvider.notifier);

    /// スケジュールの取得を待機
    return scheduleNotifierState.when(
      error: (error, stacktrace) => Text(error.toString()),
      loading: CircularProgressIndicator.new,
      data: (data) {
        return CalendarCellListComponent(
          calendar: createCalendarList(selectedDate.year, selectedDate.month),
          checkScheduleExist: scheduleNotifier.exist,
          calendarCellOnTap: (date) {
            final now = DateTime.now();
            selectedDateInCalendar.state = DateTime(
              date.year,
              date.month,
              date.day,
              now.hour,
              now.minute,
            );
          },
        );
      },
    );
  }
}
