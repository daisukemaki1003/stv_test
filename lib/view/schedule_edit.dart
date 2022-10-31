import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/repository/schedule/selector.dart';
import 'package:stv_test/routing/named_route.dart';

class ScheduleEditPage extends ConsumerWidget {
  const ScheduleEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// State
    final scheduleTitle = ref.watch(scheduleTitleProvider.state);
    final scheduleFrom = ref.watch(scheduleFromProvider.state);
    final scheduleTo = ref.watch(scheduleToProvider.state);
    final scheduleIsAllDay = ref.watch(scheduleIsAllDayProvider.state);
    final scheduleComment = ref.watch(scheduleCommentProvider.state);

    /// 日付フォーマット
    final DateFormat dateFormat;
    if (scheduleIsAllDay.state) {
      dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    } else {
      dateFormat = DateFormat('yyyy-MM-dd');
    }

    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        title: const Text("予定の追加"),

        /// 戻るボタン
        leading: popButton(context),

        /// 保存ボタン
        actions: [saveButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              /// タイトル
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: titleInputField(
                  title: scheduleTitle.state,
                  onChanged: (value) => scheduleTitle.state = value,
                ),
              ),

              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    /// 終日選択ボタン
                    allDaySelectionButton(
                      isAllDay: scheduleIsAllDay.state,
                      onChanged: (value) => scheduleIsAllDay.state = value,
                    ),

                    /// 開始日時ピッカー
                    datePickerTile(
                      context: context,
                      title: "開始",
                      selectedDate: scheduleFrom.state,
                      onChange: (date) => scheduleFrom.state = date,
                      dateFormat: dateFormat,
                    ),

                    /// 終了日時ピッカー
                    datePickerTile(
                      context: context,
                      title: "終了",
                      selectedDate: scheduleTo.state,
                      onChange: (date) => scheduleTo.state = date,
                      dateFormat: dateFormat,
                    ),
                  ],
                ),
              ),

              /// コメント
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: commentInputField(
                  comment: scheduleComment.state,
                  onChanged: (value) => scheduleComment.state = value,
                ),
              ),

              /// 削除ボタン
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: deleteButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget datePickerTile({
    required BuildContext context,
    required String title,
    required DateTime selectedDate,
    required Function(DateTime) onChange,
    required DateFormat dateFormat,
  }) {
    return ListTile(
      title: Text(title),
      trailing: TextButton(
        onPressed: () async {
          /// 日付選択
          final result = await _datePicker(
            context: context,
            allDay: false,
            selectedDate: selectedDate,
          );

          /// 選択された日時で上書き
          if (result != null) onChange(result);
        },

        /// フォーマットに応じて日付表示
        child: Text(dateFormat.format(selectedDate)),
      ),
    );
  }

  Widget allDaySelectionButton({
    required bool isAllDay,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      value: isAllDay,
      title: const Text("終日"),
      onChanged: onChanged,
    );
  }

  Widget popButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => context.go(calendarPath),
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: defaultColor,
        ),
        child: const Text("保存"),
      ),
    );
  }

  Future<DateTime?> _datePicker({
    required BuildContext context,
    required bool allDay,
    required DateTime selectedDate,
  }) async {
    ///
    DateTime date = selectedDate;

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
                      onPressed: () => Navigator.of(context).pop(date),
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
                  initialDateTime: DateTime.now().add(
                    Duration(minutes: 15 - DateTime.now().minute % 15),
                  ),
                  minuteInterval: 15,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDateTime) =>
                      date = newDateTime,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget deleteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'この予定を削除',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          _showAlertDialog(context);
        },
      ),
    );
  }

  void discardEditsDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("編集を破棄"),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text("キャンセル"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('予定の削除'),
        content: const Text('本当にこの日の予定を削除しますか？'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            textStyle: const TextStyle(color: Colors.blue),
            child: const Text('キャンセル'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            textStyle: const TextStyle(color: Colors.blue),
            child: const Text('削除'),
          )
        ],
      ),
    );
  }

  Widget commentInputField({
    required String comment,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      minLines: 5,
      maxLines: 15,
      decoration: InputDecoration(
        hintText: 'コメントを入力してください',
        hintStyle: const TextStyle(color: Colors.black12),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.blue),
        ),
      ),
      initialValue: comment,
      onChanged: onChanged,
    );
  }

  Widget titleInputField({
    required String title,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'タイトルを入力してください',
        hintStyle: const TextStyle(color: Colors.black12),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.blue),
        ),
      ),
      initialValue: title,
      onChanged: onChanged,
    );
  }
}
