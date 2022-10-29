import 'package:flutter/material.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/constraints/font.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// 週ヘッダー内のテキストスタイル
    const defaultWeekHeaderTextStyle = TextStyle(fontSize: defaltFontSize);
    const saturdayWeekHeaderTextStyle =
        TextStyle(fontSize: defaltFontSize, color: saturdayTextColor);
    const sundayWeekHeaderTextStyle =
        TextStyle(fontSize: defaltFontSize, color: sundayTextColor);

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
          weekHeader(
            weekHeaderColor,
            defaultWeekHeaderTextStyle,
            saturdayWeekHeaderTextStyle,
            sundayWeekHeaderTextStyle,
          ),

          weekRow(),
          weekRow(),
          weekRow(),
          weekRow(),
          weekRow(),
          weekRow(),
        ],
      ),
    );
  }

  Widget weekRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _dateCell(false, false, false, false),
          _dateCell(false, false, false, false),
          _dateCell(false, false, false, false),
          _dateCell(false, false, false, false),
          _dateCell(false, false, false, false),
          _dateCell(false, false, true, false),
          _dateCell(true, true, false, true),
        ],
      ),
    );
  }

  Widget _dateCell(bool pran, bool today, bool saturday, bool sunday) {
    final Color textColor;
    if (saturday) {
      textColor = saturdayTextColor;
    } else if (sunday) {
      textColor = sundayTextColor;
    } else {
      textColor = defaltTextColor;
    }

    return Ink(
      height: 65,
      width: 40,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            decoration: today
                ? const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  )
                : null,
            child: Center(
              child: Text(
                "12",
                style: TextStyle(
                  color: today ? Colors.white : textColor,
                  fontWeight: FontWeight.w400,
                ),
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
    );
  }

  Widget weekHeader(
      Color weekHeaderColor,
      TextStyle defaultWeekHeaderTextStyle,
      TextStyle saturdayWeekHeaderTextStyle,
      TextStyle sundayWeekHeaderTextStyle) {
    return Container(
      color: weekHeaderColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
