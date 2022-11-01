import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> datePicker({
  required BuildContext context,
  required bool allDay,
  required DateTime selectedDate,
}) async {
  DateTime newDate = selectedDate;

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
                mode: allDay
                    ? CupertinoDatePickerMode.date
                    : CupertinoDatePickerMode.dateAndTime,
                initialDateTime: selectedDate.add(
                  Duration(minutes: 15 - selectedDate.minute % 15),
                ),
                minuteInterval: 15,
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDateTime) =>
                    newDate = newDateTime,
              ),
            ),
          ],
        ),
      );
    },
  );
}
