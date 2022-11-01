import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/component/date_picker.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/repository/schedule/selector.dart';
import 'package:stv_test/repository/schedule/state.dart';
import 'package:stv_test/routing/named_route.dart';

class ScheduleEditPage extends ConsumerWidget {
  const ScheduleEditPage({
    super.key,
    required this.title,
    required this.onCreate,
  });

  final String title;
  final bool onCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// スケジュール Notifier
    final scheduleNotifier = ref.watch(scheduleNotifierProvider.notifier);

    /// スケジュール State
    final scheduleTitle = ref.watch(scheduleTitleProvider.state);
    final scheduleFrom = ref.watch(scheduleFromProvider.state);
    final scheduleTo = ref.watch(scheduleToProvider.state);
    final scheduleIsAllDay = ref.watch(scheduleIsAllDayProvider.state);
    final scheduleComment = ref.watch(scheduleCommentProvider.state);

    /// 編集したかどうか
    final isEdited = ref.watch(isEditedProvider.state);

    /// 日付フォーマット
    final DateFormat dateFormat;
    if (scheduleIsAllDay.state) {
      dateFormat = DateFormat('yyyy-MM-dd'); // 終日
    } else {
      dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    }

    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        title: Text(title),
        elevation: 0,

        /// 戻るボタン
        leading: popButton(
          context: context,
          onPressed: () async {
            /// 編集時じゃない
            if (!isEdited.state) context.go(calendarPath);
            final result = await discardEditsDialog(context);
            if (result != null && result) context.go(calendarPath);
            // scheduleNotifier.clear();
            isEdited.state = false;
          },
        ),

        /// 保存ボタン
        actions: [
          saveButton(
            clickable: onCreate
                ? scheduleTitle.state.isNotEmpty &&
                    scheduleComment.state.isNotEmpty
                : isEdited.state,
            save: () {
              context.go(calendarPath);
              onCreate ? scheduleNotifier.create() : scheduleNotifier.update();
              isEdited.state = false;
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                /// タイトル
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: titleInputField(
                      context: context,
                      title: scheduleTitle.state,
                      onChanged: (value) {
                        scheduleTitle.state = value;
                        isEdited.state = true;
                      }),
                ),

                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      /// 終日選択ボタン
                      allDaySelectionButton(
                        isAllDay: scheduleIsAllDay.state,
                        onChanged: (value) {
                          scheduleIsAllDay.state = value;
                          isEdited.state = true;
                        },
                      ),

                      /// 開始日時ピッカー
                      datePickerTile(
                        context: context,
                        title: "開始",
                        selectedDate: scheduleFrom.state,
                        onChange: (date) {
                          /// 終日
                          if (scheduleIsAllDay.state) {
                            scheduleFrom.state = date;
                            if (scheduleTo.state.isBefore(date)) {
                              scheduleTo.state = date;
                            }
                          } else {
                            /// 終日じゃない
                            scheduleFrom.state = date;
                            if (scheduleTo.state.isBefore(date)) {
                              scheduleTo.state =
                                  date.add(const Duration(hours: 1));
                            }
                          }
                          isEdited.state = true;
                        },
                        dateFormat: dateFormat,
                      ),

                      /// 終了日時ピッカー
                      datePickerTile(
                        context: context,
                        title: "終了",
                        selectedDate: scheduleTo.state,
                        onChange: (date) {
                          scheduleTo.state = date;
                          isEdited.state = true;
                        },
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
                      onChanged: (value) {
                        scheduleComment.state = value;
                        isEdited.state = true;
                      }),
                ),

                /// 削除ボタン
                if (!onCreate)
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: deleteButton(
                      context: context,
                      delete: () async {
                        Navigator.of(context).pop();
                        context.go(calendarPath);
                        await scheduleNotifier.delete();
                        isEdited.state = false;
                      },
                    ),
                  )
              ],
            ),
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
          final result = await datePicker(
            context: context,
            isAllDay: false,
            date: selectedDate,
          );

          /// 選択された日時で上書き
          if (result != null) onChange(result);
        },

        /// フォーマットに応じて日付表示
        child: Text(
          dateFormat.format(selectedDate),
          style: const TextStyle(color: defaltTextColor),
        ),
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

  Widget popButton({
    required BuildContext context,
    required Function() onPressed,
  }) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onPressed,
    );
  }

  Widget saveButton({
    required bool clickable,
    required Function() save,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextButton(
        onPressed: clickable ? save : null,
        style: TextButton.styleFrom(
          backgroundColor: defaultColor,
        ),
        child: const Text("保存"),
      ),
    );
  }

  Widget deleteButton({
    required BuildContext context,
    required Function() delete,
  }) {
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
          _showAlertDialog(context, delete);
        },
      ),
    );
  }

  Future<bool?> discardEditsDialog(BuildContext context) {
    return showCupertinoModalPopup<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("編集を破棄"),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("キャンセル"),
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, Function() delete) {
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
            onPressed: delete,
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
    required BuildContext context,
    required String title,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      autofocus: true,
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
