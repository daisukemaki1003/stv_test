import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/utils/create_calendar_list.dart';

/// 選択された年
final targetYearProvider = StateProvider<int>((ref) => DateTime.now().year);

/// 選択された月
final targetMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

/// 表示中のカレンダー
final calendarListProvider = Provider<List<Calendar>>((ref) {
  final year = ref.watch(targetYearProvider);
  final month = ref.watch(targetMonthProvider);

  return createCalendarList(year, month);
});
