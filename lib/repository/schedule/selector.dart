import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/model/schedule.dart';

/// 新規作成
final scheduleNameProvider = StateProvider<String>((ref) => "");
final scheduleFromProvider = StateProvider<DateTime>((ref) => DateTime.now());
final scheduleToProvider = StateProvider<DateTime>((ref) => DateTime.now());
final scheduleIsAllDayProvider = StateProvider<bool>((ref) => false);
final scheduleCommentProvider = StateProvider<String>((ref) => "");

final newScheduleProvider = StateProvider<Schedule>((ref) {
  final name = ref.watch(scheduleNameProvider);
  final from = ref.watch(scheduleFromProvider);
  final to = ref.watch(scheduleToProvider);
  final isAllDay = ref.watch(scheduleIsAllDayProvider);
  final comment = ref.watch(scheduleCommentProvider);

  return Schedule(
    id: null,
    name: name,
    from: from,
    to: to,
    isAllDay: isAllDay,
    comment: comment,
  );
});
