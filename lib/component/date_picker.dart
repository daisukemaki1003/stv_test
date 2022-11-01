import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 日付を選択する
/// 終日かどうかで表示するデータが変化
Future<DateTime?> datePicker({
  required BuildContext context,

  /// 終日かどうか
  required bool isAllDay,

  /// 初期値
  required DateTime date,
}) async {
  /// 更新した日付を格納
  DateTime newDate = date;

  return showModalBottomSheet<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("キャンセル"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(newDate),
                    child: const Text("完了"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: isAllDay
                    ? CupertinoDatePickerMode.date
                    : CupertinoDatePickerMode.dateAndTime,
                initialDateTime: date.add(
                  Duration(minutes: 15 - date.minute % 15),
                ),
                minuteInterval: 15,
                use24hFormat: true,
                onDateTimeChanged: (dateTime) => newDate = dateTime,
              ),
            ),
          ],
        ),
      );
    },
  );
}
