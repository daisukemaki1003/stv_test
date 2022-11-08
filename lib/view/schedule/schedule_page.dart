import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/schedule/selector.dart';
import 'package:stv_test/repository/schedule/state.dart';
import 'package:stv_test/constraints/named_route.dart';
import 'package:stv_test/view/schedule/schedule_component.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage(this.selectedCalenderCell, {super.key});

  final Calendar selectedCalenderCell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択中の日付
    final targetDate = ref.watch(selectedDateInCalendarProvider.state);

    /// 選択するスケジュールを格納
    final targetSchedule = ref.watch(targetScheduleProvider.state);

    /// 新規作成時の日時
    final targetNewScheduleDate =
        ref.watch(targetNewScheduleDateProvider.state);

    /// スケジュールリスト
    final scheduleNotifierState = ref.watch(scheduleNotifierProvider);

    return SchedulePageComponent(
      selectedDate: targetDate.state,
      createSchedule: (date) {
        targetNewScheduleDate.state = date;
        context.push(createSchedulePath);
      },
      updateSchedule: (value) {
        targetSchedule.state = value;
        context.push(editSchedulePath);
      },
      fetchSchedule: (date) {
        final schedules = scheduleNotifierState.value;
        if (schedules == null) return [];
        return schedules.where((e) {
          return date.difference(e.from).inDays == 0 && date.day == e.from.day;
        }).toList();
      },
      initParams: () => targetSchedule.state = null,
    );
  }
}
