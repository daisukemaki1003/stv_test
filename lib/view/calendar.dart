import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/constraints/font.dart';
import 'package:stv_test/view/calender_cell_list.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// State

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
          const CalendarCellListContainer(),
        ],
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
