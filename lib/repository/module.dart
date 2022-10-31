import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/repository/schedule.dart';

///
/// DI

/// データソース
final scheduleDataSourceProvider = Provider((_) {
  return ScheduleDataSourceImpl.instance;
});

/// リポジトリ
final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl(ref.watch(scheduleDataSourceProvider));
});
