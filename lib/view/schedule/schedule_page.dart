import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/schedule/selector.dart';
import 'package:stv_test/routing/named_route.dart';
import 'package:stv_test/view/schedule/schedule_component.dart';

final currentPageIndexProvider = StateProvider<int>(((ref) => 999));

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択中の日付
    final targetDate = ref.watch(selectedDateInCalendarProvider.state);

    /// 選択中のカレンダーセルデータ
    final targetCalenderCell = ref.watch(targetCalenderCellProvider.state);

    /// 選択するスケジュールを格納
    final targetSchedule = ref.watch(targetScheduleProvider.state);

    /// 新規作成時の日時
    final targetNewScheduleDate =
        ref.watch(targetNewScheduleDateProvider.state);

    /// スケジュールページインデックス
    final currentPageIndex = ref.watch(currentPageIndexProvider.state);

    /// スケジュールカードをスワイプ
    changeDate(StateController<DateTime> state, int pageIndex) {
      final isNext = currentPageIndex.state < pageIndex;
      currentPageIndex.state = pageIndex;
      state.state = state.state.add(Duration(days: isNext ? 1 : -1));
    }

    return SchedulePageComponent(
      calendarCell: targetCalenderCell.state,
      createSchedule: (value) {
        targetNewScheduleDate.state = value;
        context.push(createSchedulePath);
      },
      updateSchedule: (value) {
        targetSchedule.state = value;
        context.push(editSchedulePath);
      },
      swipe: (pageIndex) => changeDate(targetDate, pageIndex),
      // onNextDay: () => swipe(targetDate, true),
      // onPrevDay: () => swipe(targetDate, false),
    );
  }
}
