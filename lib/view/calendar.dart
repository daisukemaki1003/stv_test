import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/component/date_picker.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/constraints/font.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/view/calender_cell_list.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetYear = ref.watch(targetYearProvider.state);
    final targetMonth = ref.watch(targetMonthProvider.state);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("カレンダー"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 今日ボタン
                todayButton(() {
                  final now = DateTime.now();
                  targetYear.state = now.year;
                  targetMonth.state = now.month;
                }),

                /// 月選択ピッカー
                monthPicker(
                  year: targetYear.state,
                  month: targetMonth.state,
                  onPressed: () async {
                    /// 日付選択
                    final result = await datePicker(
                      context: context,
                      isAllDay: true,
                      date: DateTime(targetYear.state, targetMonth.state),
                    );

                    /// 選択された日時で上書き
                    if (result != null) {
                      targetYear.state = result.year;
                      targetMonth.state = result.month;
                    }
                  },
                ),

                Container(),
              ],
            ),
          ),

          /// 週ヘッダー
          weekHeader(),

          /// カレンダーセル
          const CalendarCellListContainer(),
        ],
      ),
    );
  }

  Widget weekHeader() {
    const fontSize = 12.0;
    const defaultWeekHeaderTextStyle = TextStyle(fontSize: fontSize);
    const saturdayWeekHeaderTextStyle =
        TextStyle(fontSize: fontSize, color: saturdayTextColor);
    const sundayWeekHeaderTextStyle =
        TextStyle(fontSize: fontSize, color: sundayTextColor);

    return Container(
      color: weekHeaderColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(mon, style: defaultWeekHeaderTextStyle),
          Text(tue, style: defaultWeekHeaderTextStyle),
          Text(wed, style: defaultWeekHeaderTextStyle),
          Text(thu, style: defaultWeekHeaderTextStyle),
          Text(fri, style: defaultWeekHeaderTextStyle),
          Text(sat, style: saturdayWeekHeaderTextStyle),
          Text(sun, style: sundayWeekHeaderTextStyle),
        ],
      ),
    );
  }

  Widget monthPicker({
    required int year,
    required int month,
    required Function() onPressed,
  }) {
    return Row(
      children: [
        Text(
          "$year年$month月",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }

  Widget todayButton(Function() onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
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
