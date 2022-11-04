import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stv_test/component/date_picker.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/constraints/font.dart';
import 'package:stv_test/view/calender_cell_list/calender_cell_list_container.dart';

class CalendarPageComponent extends StatelessWidget {
  const CalendarPageComponent({
    super.key,
    required this.targetDate,
    required this.targetDateOnChange,
    required this.onSwipe,
    required this.pageIndex,
  });

  final DateTime targetDate;
  final Function(DateTime) targetDateOnChange;
  final Function(int) onSwipe;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
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
                  targetDateOnChange(DateTime.now());
                }),

                /// 月選択ピッカー
                monthPicker(
                  context: context,
                  date: targetDate,
                  onChangeed: targetDateOnChange,
                ),

                Container(),
              ],
            ),
          ),

          /// 週ヘッダー
          weekHeader(),

          /// カレンダーセル
          Expanded(
            child: PageView.builder(
              controller: PageController(initialPage: 999),
              itemBuilder: (BuildContext context, int index) {
                final date =
                    Jiffy(targetDate).add(months: index - pageIndex).dateTime;
                return CalendarCellListContainer(date);
              },
              onPageChanged: onSwipe,
            ),
          ),
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
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onChangeed,
  }) {
    return Row(
      children: [
        Text(
          DateFormat('yyyy年MM月').format(date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        IconButton(
          onPressed: () async {
            final result = await datePicker(
              context: context,
              isAllDay: true,
              date: targetDate,
            );
            if (result != null) {
              onChangeed(result);
            }
          },
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
