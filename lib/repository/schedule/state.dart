import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/module.dart';
import 'package:stv_test/repository/schedule/selector.dart';

/// プロバイダー
final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, AsyncValue<List<Schedule>>>((ref) {
  return ScheduleNotifier(
    ref,
    ref.watch(scheduleDataSourceProvider),
  )..initialize();
});

/// ステート
class ScheduleNotifier extends StateNotifier<AsyncValue<List<Schedule>>> {
  ScheduleNotifier(this.ref, this._dataSource)
      : super(const AsyncValue<List<Schedule>>.loading());

  final Ref ref;
  final ScheduleDataSource _dataSource;

  Future<void> initialize() async {
    await fetchByMonth(DateTime.now());
  }

  create() async {
    final newSchedule = ref.watch(newScheduleProvider);
    await _dataSource.create(newSchedule);
    // ref.refresh(diariesNotifierProvider);
  }

  update() async {
    final newSchedule = ref.watch(newScheduleProvider);
    await _dataSource.update(newSchedule);
    // ref.refresh(diariesNotifierProvider);
  }

  fetchByMonth(DateTime today) async {
    final schedules = await _dataSource.fetchByMonth(today);
    state = AsyncValue.data(schedules);
  }
}
