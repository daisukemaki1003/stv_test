import 'package:stv_test/data_source/schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/module.dart';
import 'package:stv_test/repository/schedule/selector.dart';

/// プロバイダー
final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, AsyncValue<List<ScheduleData>>>(
        (ref) {
  return ScheduleNotifier(
    ref,
    ref.watch(scheduleDataSourceProvider),
  )..initialize();
});

/// ステート
class ScheduleNotifier extends StateNotifier<AsyncValue<List<ScheduleData>>> {
  ScheduleNotifier(this.ref, this._dataSource)
      : super(const AsyncValue<List<ScheduleData>>.loading());

  final Ref ref;
  final ScheduleDataSource _dataSource;

  Future<void> initialize() async => await fetchAll();

  Future create(ScheduleCompanion schedule) async {
    await _dataSource.createSchedule(schedule);
    ref.refresh(scheduleNotifierProvider);
  }

  Future update(ScheduleData schedule) async {
    print("object");
    print(schedule.id);
    await _dataSource.updateSchedule(schedule);
    ref.refresh(scheduleNotifierProvider);
  }

  Future delete(ScheduleData schedule) async {
    await _dataSource.deleteSchedule(schedule.id);
    ref.refresh(scheduleNotifierProvider);
  }

  Future fetchAll() async {
    state = await AsyncValue.guard(() async {
      final schedules = await _dataSource.fetchAll();
      return schedules;
    });
  }

  bool exist(DateTime date) {
    final data = state.value;
    if (data == null) return false;

    for (var schedule in data) {
      if (date.difference(schedule.from).inDays == 0 &&
          date.day == schedule.from.day) return true;
    }
    return false;
  }
}
