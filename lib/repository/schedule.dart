import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/schedule.dart';

abstract class ScheduleRepository {
  create(Schedule schedule);
  update(Schedule schedule);
  delete(int id);
  Future<List<Schedule>> fetchByMonth(DateTime today);
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDataSource _dataSource;

  ScheduleRepositoryImpl(this._dataSource);

  @override
  create(Schedule schedule) {
    _dataSource.create(schedule);
  }

  @override
  update(Schedule schedule) {
    _dataSource.update(schedule);
  }

  @override
  delete(int id) {
    _dataSource.delete(id);
  }

  @override
  fetchByMonth(DateTime today) {
    return _dataSource.readByMonth(today);
  }
}
