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

  create() async {
    final newSchedule = ref.watch(newScheduleProvider);
    await _dataSource.createSchedule(newSchedule);
    // ref.refresh(diariesNotifierProvider);
  }

  update() async {
    final newSchedule = ref.watch(editScheduleProvider);
    await _dataSource.updateSchedule(newSchedule);
    // ref.refresh(diariesNotifierProvider);
  }

  fetchAll() async {
    final schedules = await _dataSource.fetchAll();
    state = AsyncValue.data(schedules);
  }
}
