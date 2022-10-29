import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// 週ヘッダー内のテキストスタイル
    const defaultWeekHeaderTextStyle = TextStyle(fontSize: 12);
    const saturdayWeekHeaderTextStyle =
        TextStyle(fontSize: 12, color: Colors.blue);
    const sundayWeekHeaderTextStyle =
        TextStyle(fontSize: 12, color: Colors.red);

    /// 週ヘッダー内のバックグラウンドカラー
    const weekHeaderColor = Color.fromARGB(255, 237, 237, 237);

    return Scaffold(
      appBar: AppBar(title: const Text("カレンダー")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 今日ボタン
              _todayButton(),

              /// 月選択ピッカー
              _monthPicker(),

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
        ],
      ),
    );
  }

  Container weekHeader(
      Color weekHeaderColor,
      TextStyle defaultWeekHeaderTextStyle,
      TextStyle saturdayWeekHeaderTextStyle,
      TextStyle sundayWeekHeaderTextStyle) {
    return Container(
      color: weekHeaderColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }

  Widget _monthPicker() {
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

  Widget _todayButton() {
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
