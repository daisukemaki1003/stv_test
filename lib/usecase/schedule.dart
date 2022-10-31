import 'package:stv_test/model/schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/repository/module.dart';
import 'package:stv_test/repository/schedule.dart';

final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, AsyncValue<List<Schedule>>>((ref) {
  return ScheduleNotifier(ref, ref.watch(scheduleRepositoryProvider))
    ..initialize();
});

class ScheduleNotifier extends StateNotifier<AsyncValue<List<Schedule>>> {
  ScheduleNotifier(this.ref, this._repository)
      : super(const AsyncValue<List<Schedule>>.loading());

  final Ref ref;
  final ScheduleRepository _repository;

  Future<void> initialize() async {
    await fetchByMonth(DateTime.now());
  }

  create() async {
    // final diary = ref.watch(diaryProvider);
    // await presenter.create(diary);
    // ref.refresh(diariesNotifierProvider);
  }

  update() async {
    // final diary = ref.watch(diaryProvider);
    // await presenter.update(diary);
    // ref.refresh(diariesNotifierProvider);
  }

  fetchByMonth(DateTime today) async {
    final schedules = await _repository.fetchByMonth(today);
    state = AsyncValue.data(schedules);
  }
}
