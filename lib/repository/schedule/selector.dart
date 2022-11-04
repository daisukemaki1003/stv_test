import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/repository/schedule/state.dart';

/// 選択されたスケジュール
final targetScheduleProvider = StateProvider<ScheduleData?>((ref) => null);

/// 新規作成時の日付
final targetNewScheduleDateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

/// スケジュールデータ
///
/// ID
final scheduleIdProvider = StateProvider.autoDispose<int?>((ref) {
  final targetSchedule = ref.watch(targetScheduleProvider);
  return targetSchedule?.id;
});

/// タイトル
final scheduleTitleProvider = StateProvider.autoDispose<String>((ref) {
  final targetSchedule = ref.watch(targetScheduleProvider);
  return targetSchedule != null ? targetSchedule.title : "";
});

/// 開始日時
final scheduleFromProvider = StateProvider.autoDispose<DateTime>((ref) {
  final targetSchedule = ref.watch(targetScheduleProvider);
  final targetDate = ref.watch(targetNewScheduleDateProvider);
  return targetSchedule != null ? targetSchedule.from : targetDate;
});

/// 終了日時
final scheduleToProvider = StateProvider.autoDispose<DateTime>((ref) {
  final targetSchedule = ref.watch(targetScheduleProvider);
  final targetDate = ref.watch(targetNewScheduleDateProvider);
  return targetSchedule != null ? targetSchedule.to : targetDate;
});

/// 終日
final scheduleIsAllDayProvider = StateProvider.autoDispose<bool>((ref) {
  final targetSchedule = ref.watch(targetScheduleProvider);
  return targetSchedule != null ? targetSchedule.isAllDay : false;
});

/// コメント
final scheduleCommentProvider = StateProvider.autoDispose<String>((ref) {
  final targetSchedule = ref.watch(targetScheduleProvider);
  return targetSchedule != null ? targetSchedule.comment : "";
});

/// 新規作成
final newScheduleProvider = StateProvider.autoDispose<ScheduleCompanion>((ref) {
  final title = ref.watch(scheduleTitleProvider);
  final from = ref.watch(scheduleFromProvider);
  final to = ref.watch(scheduleToProvider);
  final isAllDay = ref.watch(scheduleIsAllDayProvider);
  final comment = ref.watch(scheduleCommentProvider);

  return ScheduleCompanion(
    title: Value(title),
    from: Value(from),
    to: Value(to),
    isAllDay: Value(isAllDay),
    comment: Value(comment),
  );
});

/// 編集
final editScheduleProvider = StateProvider.autoDispose<ScheduleData>((ref) {
  final id = ref.watch(scheduleIdProvider);
  final title = ref.watch(scheduleTitleProvider);
  final from = ref.watch(scheduleFromProvider);
  final to = ref.watch(scheduleToProvider);
  final isAllDay = ref.watch(scheduleIsAllDayProvider);
  final comment = ref.watch(scheduleCommentProvider);

  return ScheduleData(
    id: id!,
    title: title,
    from: from,
    to: to,
    isAllDay: isAllDay,
    comment: comment,
  );
});

/// データベースの変化をStateNotifierに伝播
// final schedulesStreamProvider = StreamProvider<List<ScheduleData>>((ref) {});
