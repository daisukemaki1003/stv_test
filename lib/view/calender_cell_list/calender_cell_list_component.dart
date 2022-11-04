import 'package:flutter/material.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/utils/create_calendar_list.dart';
import 'package:stv_test/view/schedule/schedule_page.dart';

class CalendarCellListComponent extends StatelessWidget {
  const CalendarCellListComponent({
    super.key,
    required this.calendar,
    required this.calendarCellOnTap,
  });

  final List<Calendar> calendar;
  final Function(DateTime) calendarCellOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      /// 週ごとのデータに加工
      children: to2Dim(calendar).map((calendarListItem) {
        /// 週ごとのカレンダーセルを表示
        return weekRow(
          context: context,
          calendarList: calendarListItem,
          onTap: calendarCellOnTap,
        );
      }).toList(),
    );
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
    } else if (calendar.isThatDay(DateTime.now())) {
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
    if (calendar.isThatDay(DateTime.now())) {
      todayBoxDecoration = const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      );
    } else {
      todayBoxDecoration = const BoxDecoration();
    }

    return InkWell(
      onTap: () async {
        /// タップした日付を設定
        onTap(calendar.date);

        /// 予定一覧をダイアログ表示
        await showDialog(
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
            if (calendar.schedules.isNotEmpty)
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
