import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/module.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';

/// プロバイダー
final calendarNotifierProvider =
    StateNotifierProvider<CalendarNotifier, AsyncValue<List<Calendar>>>((ref) {
  return CalendarNotifier(
    ref,
    ref.watch(scheduleDataSourceProvider),
  )..initialize();
});

/// ステート
class CalendarNotifier extends StateNotifier<AsyncValue<List<Calendar>>> {
  CalendarNotifier(this.ref, this._dataSource)
      : super(const AsyncValue<List<Calendar>>.loading());

  final Ref ref;
  final ScheduleDataSource _dataSource;

  Future<void> initialize() async {
    await fetchBySelectedMonth();
  }

  fetchBySelectedMonth() async {
    final calendarList = ref.watch(calendarListProvider);
    state = AsyncValue.data(calendarList);
  }
}
