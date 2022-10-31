import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/view/schedule.dart';

class CalendarCellListContainer extends ConsumerWidget {
  const CalendarCellListContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarList = ref.watch(calendarListProvider);

    return Column(
      children: calendarList.map((calendarListItem) {
        /// 週ごとのカレンダーセルを表示
        return weekRow(context, calendarListItem);
      }).toList(),
    );
  }

  Widget weekRow(BuildContext context, List<Calendar> calendarList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: calendarList.map((calendarListItem) {
          return _dateCell(
            context: context,
            pran: false,
            calendar: calendarListItem,
          );
        }).toList(),
      ),
    );
  }

  Widget _dateCell({
    required BuildContext context,

    /// 予定が存在するか
    required bool pran,

    /// カレンダーデータ
    required Calendar calendar,
  }) {
    /// 今日かどうか
    final isToday = calendar.date == DateTime.now();

    /// 曜日に応じたテキストカラー
    final Color calendarCellTextColor;
    if (!calendar.enabled) {
      calendarCellTextColor = Colors.black12;
    } else if (isToday) {
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
    if (isToday) {
      todayBoxDecoration = const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      );
    } else {
      todayBoxDecoration = const BoxDecoration();
    }

    return InkWell(
      onTap: () {
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
            if (pran)
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
