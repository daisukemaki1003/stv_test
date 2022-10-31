import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/constraints/font.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/schedule/state.dart';

import 'package:stv_test/view/schedule.dart';

class CalendarPage extends ConsumerWidget {
  static const String routeName = '/calendar-page';
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// State
    final calendarList = ref.watch(calendarListProvider);
    final scheduleNotifier = ref.watch(scheduleNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("カレンダー")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 今日ボタン
              todayButton(),

              /// 月選択ピッカー
              monthPicker(),

              Container(),
            ],
          ),

          /// 週ヘッダー
          weekHeader(),

          /// カレンダーセル
          Column(
            children: calendarList.map((e) {
              return weekRow(context, e);
            }).toList(),
          ),
        ],
      ),
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
    required bool pran,
    required BuildContext context,
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

    return InkWell(
      onTap: () {
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
              decoration: isToday
                  ? const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    )
                  : null,
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

  Widget weekHeader() {
    const defaultWeekHeaderTextStyle = TextStyle(fontSize: defaltFontSize);
    const saturdayWeekHeaderTextStyle =
        TextStyle(fontSize: defaltFontSize, color: saturdayTextColor);
    const sundayWeekHeaderTextStyle =
        TextStyle(fontSize: defaltFontSize, color: sundayTextColor);

    return Container(
      color: weekHeaderColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text("月", style: defaultWeekHeaderTextStyle),
          Text("火", style: defaultWeekHeaderTextStyle),
          Text("水", style: defaultWeekHeaderTextStyle),
          Text("木", style: defaultWeekHeaderTextStyle),
          Text("金", style: defaultWeekHeaderTextStyle),
          Text("土", style: saturdayWeekHeaderTextStyle),
          Text("日", style: sundayWeekHeaderTextStyle),
        ],
      ),
    );
  }

  Widget monthPicker() {
    return Row(
      children: [
        const Text(
          "2021年8月",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }

  Widget todayButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "今日",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
