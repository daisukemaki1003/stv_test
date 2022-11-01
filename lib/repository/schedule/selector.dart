import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/schedule.dart';

/// スケジュールデータ
final scheduleIdProvider = StateProvider<int?>((ref) => null);
final scheduleTitleProvider = StateProvider<String>((ref) => "");
final scheduleFromProvider = StateProvider<DateTime>((ref) => DateTime.now());
final scheduleToProvider = StateProvider<DateTime>((ref) => DateTime.now());
final scheduleIsAllDayProvider = StateProvider<bool>((ref) => false);
final scheduleCommentProvider = StateProvider<String>((ref) => "");

/// 新規作成
final newScheduleProvider = StateProvider<ScheduleCompanion>((ref) {
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
final editScheduleProvider = StateProvider<ScheduleData>((ref) {
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
