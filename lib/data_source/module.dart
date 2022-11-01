import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/schedule.dart';

///
/// DI

final scheduleDataSourceProvider = Provider<ScheduleDataSource>((_) {
  return ScheduleDataSourceImpl();
});
