import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/component/date_picker.dart';
import 'package:stv_test/component/schedule_deletion_alert_dialog.dart';
import 'package:stv_test/constraints/color.dart';
import 'package:stv_test/routing/named_route.dart';

class ScheduleEditPageComoponent extends StatefulWidget {
  const ScheduleEditPageComoponent({
    super.key,
    required this.isCreate,
    required this.title,
    required this.from,
    required this.to,
    required this.isAllDay,
    required this.comment,
    required this.titleOnChanged,
    required this.fromOnChanged,
    required this.toOnChanged,
    required this.isAllDayOnChanged,
    required this.commentOnChanged,
    required this.onBack,
    required this.onSave,
    required this.onDelete,
  });

  /// Mode
  final bool isCreate;

  /// State
  final String title;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  final String comment;

  /// State変更時処理
  final Function(String) titleOnChanged;
  final Function(DateTime) fromOnChanged;
  final Function(DateTime) toOnChanged;
  final Function(bool) isAllDayOnChanged;
  final Function(String) commentOnChanged;

  /// 戻るボタンタップイベント
  /// [isEdit] 編集したかどうか
  /// [pop] 戻る
  final Function(bool isEdit, Function pop) onBack;

  /// 保存ボタンイベント
  /// [pop] 戻る
  final Function(Function pop) onSave;

  /// 削除ボタンイベント
  /// [pop] 戻る
  final Function(Function pop)? onDelete;

  @override
  State<ScheduleEditPageComoponent> createState() =>
      ScheduleEditPageComoponentState();
}

///
///
/// ページステート
class ScheduleEditPageComoponentState
    extends State<ScheduleEditPageComoponent> {
  /// 編集したか
  bool isEdited = false;

  void _editing() {
    if (widget.isCreate) {
      setState(() {
        isEdited = widget.title.isNotEmpty && widget.comment.isNotEmpty;
      });
    } else {
      setState(() {
        isEdited = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// カレンダーページに戻る
    onPop() {
      if (!mounted) return;
      context.go(calendarPath);
    }

    /// 日付フォーマット
    final DateFormat dateFormat;
    if (widget.isAllDay) {
      dateFormat = DateFormat('yyyy-MM-dd'); // 終日
    } else {
      dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    }

    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,

        /// 戻るボタン
        leading: backButton(
          context: context,
          onPressed: () => widget.onBack(isEdited, onPop),
        ),

        /// 保存ボタン
        actions: [
          saveButton(
            clickable: isEdited,
            save: () => widget.onSave(onPop),
          ),
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
                    title: widget.title,
                    onChanged: (value) {
                      widget.titleOnChanged(value);
                      _editing();
                    },
                  ),
                ),

                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      /// 終日選択ボタン
                      allDaySelectionButton(
                          isAllDay: widget.isAllDay,
                          onChanged: (value) {
                            widget.isAllDayOnChanged(value);
                            _editing();
                          }),

                      /// 開始日時ピッカー
                      datePickerTile(
                        context: context,
                        title: "開始",
                        selectedDate: widget.from,
                        onChange: (value) {
                          widget.fromOnChanged(value);
                          if (widget.isAllDay) {
                            if (widget.to.isBefore(value)) {
                              widget.toOnChanged(value);
                            }
                          } else {
                            if (widget.to.isBefore(value)) {
                              widget.toOnChanged(
                                value.add(const Duration(hours: 1)),
                              );
                            }
                          }
                          _editing();
                        },
                        dateFormat: dateFormat,
                      ),

                      /// 終了日時ピッカー
                      datePickerTile(
                        context: context,
                        title: "終了",
                        selectedDate: widget.to,
                        onChange: (value) {
                          widget.toOnChanged(value);
                          _editing();
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
                    comment: widget.comment,
                    onChanged: (value) {
                      widget.commentOnChanged(value);
                      _editing();
                    },
                  ),
                ),

                /// 削除ボタン
                if (widget.onDelete != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: deleteButton(
                      context: context,
                      delete: () => widget.onDelete!(onPop),
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

  Widget backButton({
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
          deletionAlertDialog(
            context: context,
            title: "予定の削除",
            content: "本当にこの日の予定を削除しますか？",
          );
        },
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
