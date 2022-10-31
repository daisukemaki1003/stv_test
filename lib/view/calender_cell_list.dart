import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/calendar/state.dart';
import 'package:stv_test/utils/create_calendar_list.dart';
import 'package:stv_test/view/schedule.dart';

class CalendarCellListContainer extends ConsumerWidget {
  const CalendarCellListContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択中の日付
    final targetDate = ref.watch(targetDateProvider.state);

    /// 選択中の月のカレンダーリスト
    final calendarList = ref.watch(calendarNotifierProvider);

    return calendarList.map(
        error: (_) => const Center(child: Text('On Error')),
        loading: (_) => const CircularProgressIndicator(),
        data: (data) {
          /// 週ごとのデータに加工
          final calendarListweekly = to2Dim(data.value);
          return Column(
            children: calendarListweekly.map((calendarListItem) {
              /// 週ごとのカレンダーセルを表示
              return weekRow(
                context: context,
                calendarList: calendarListItem,
                onTap: (DateTime date) {
                  targetDate.state = date;
                },
              );
            }).toList(),
          );
        });
  }

  Widget weekRow({
    required BuildContext context,

    /// 表示するカレンダーリスト
    required List<Calendar> calendarList,

    /// カレンダーのセルをタップ時の関数
    required Function(DateTime) onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: calendarList.map((calendarListItem) {
          return _dateCell(
            context: context,
            calendar: calendarListItem,
            onTap: onTap,
          );
        }).toList(),
      ),
    );
  }

  Widget _dateCell({
    required BuildContext context,

    /// カレンダーデータ
    required Calendar calendar,

    /// カレンダーのセルをタップ時の関数
    required Function(DateTime) onTap,
  }) {
    /// 曜日に応じたテキストカラー
    final Color calendarCellTextColor;
    if (!calendar.enabled) {
      calendarCellTextColor = Colors.black12;
    } else if (calendar.isToday()) {
      calendarCellTextColor = Colors.white;
    } else if (calendar.date.weekday == DateTime.saturday) {
      calendarCellTextColor = saturdayTextColor;
    } else if (calendar.date.weekday == DateTime.sunday) {
      calendarCellTextColor = sundayTextColor;
    } else {
      calendarCellTextColor = defaltTextColor;
    }

    /// 日付が今日の場合は青い丸で囲む
    final BoxDecoration todayBoxDecoration;
    if (calendar.isToday()) {
      todayBoxDecoration = const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      );
    } else {
      todayBoxDecoration = const BoxDecoration();
    }

    return InkWell(
      onTap: () {
        /// タップした日付を設定
        onTap(calendar.date);

        /// 予定一覧をダイアログ表示
        showDialog(
          context: context,
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SchedulePage(),
              ],
            );
          },
        );
      },
      child: SizedBox(
        height: 65,
        width: 40,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              decoration: todayBoxDecoration,
              child: Center(
                child: Text(
                  calendar.date.day.toString(),
                  style: TextStyle(color: calendarCellTextColor),
                ),
              ),
            ),

            /// 予定が存在する
            if (false)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
