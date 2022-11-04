import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/component/discard_edits_dialog.dart';
import 'package:stv_test/component/schedule_deletion_alert_dialog.dart';
import 'package:stv_test/repository/schedule/selector.dart';
import 'package:stv_test/repository/schedule/state.dart';
import 'package:stv_test/view/schedule_edit/schedule_edit_component.dart';

class ScheduleEditPage extends ConsumerWidget {
  const ScheduleEditPage({
    super.key,
    required this.title,
    required this.isCreate,
  });
  final String title;
  final bool isCreate;

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

    /// State更新
    write<T>(StateController<T> state, T value) => state.state = value;

    /// 戻る
    onBack(bool isEdit, Function onPop) async {
      if (!isEdit) {
        onPop();
      } else {
        final result = await discardEditsDialog(
          context: context,
          actionText: "編集を破棄",
        );
        if (result != null && result) onPop();
      }
    }

    /// 保存
    onSave(onPop) async {
      if (isCreate) {
        /// 作成
        final newSchedule = ref.watch(newScheduleProvider.state);
        await scheduleNotifier.create(newSchedule.state);
      } else {
        /// 更新
        final editSchedule = ref.watch(editScheduleProvider.state);
        await scheduleNotifier.update(editSchedule.state);
      }
      onPop();
    }

    /// 削除
    onDelete(onPop) async {
      final result = await deletionAlertDialog(
        context: context,
        title: "予定の削除",
        content: "本当にこの日の予定を削除しますか？",
      );
      if (result != null && result) {
        await scheduleNotifier.delete();
        onPop();
      }
    }

    return ScheduleEditPageComoponent(
      isCreate: isCreate,
      title: scheduleTitle.state,
      from: scheduleFrom.state,
      to: scheduleTo.state,
      isAllDay: scheduleIsAllDay.state,
      comment: scheduleComment.state,
      titleOnChanged: (value) => write(scheduleTitle, value),
      fromOnChanged: (value) => write(scheduleFrom, value),
      toOnChanged: (value) => write(scheduleTo, value),
      isAllDayOnChanged: (value) => write(scheduleIsAllDay, value),
      commentOnChanged: (value) => write(scheduleComment, value),
      onBack: onBack,
      onSave: onSave,
      onDelete: isCreate ? null : onDelete,
    );
  }
}
