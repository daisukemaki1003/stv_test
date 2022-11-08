import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/component/discard_edits_dialog.dart';
import 'package:stv_test/component/schedule_deletion_alert_dialog.dart';
import 'package:stv_test/constraints/text.dart';
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
    // final targetSchedule = ref.watch(targetScheduleProvider.state);
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
          actionText: kScheduleEditPageDiscardEditsText,
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
      await onPop();
    }

    /// 削除
    onDelete(onPop) async {
      final result = await deletionAlertDialog(
        context: context,
        title: kScheduleEditPageDeleteEventTitle,
        content: kScheduleEditPageDeleteEventContent,
      );
      if (result != null && result) {
        final targetSchedule = ref.watch(targetScheduleProvider.state);
        await scheduleNotifier.delete(targetSchedule.state!);
        onPop();
      }
    }

    return ScheduleEditPageComoponent(
      isCreate: isCreate,
      appBarTitle: title,
      scheduleTitle: scheduleTitle.state,
      scheduleFrom: scheduleFrom.state,
      scheduleTo: scheduleTo.state,
      scheduleIsAllDay: scheduleIsAllDay.state,
      scheduleComment: scheduleComment.state,
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
