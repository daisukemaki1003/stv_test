import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:stv_test/model/schedule.dart';

part 'schedule.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

/// インターフェース
abstract class ScheduleDataSource {
  Future<int> createSchedule(ScheduleCompanion schedule);
  Future<bool> updateSchedule(ScheduleData schedule);
  Future<int> deleteSchedule(int id);
  Future<List<ScheduleData>> fetchAll();
}

/// 実装
@DriftDatabase(tables: [Schedule])
class ScheduleDataSourceImpl extends _$ScheduleDataSourceImpl
    implements ScheduleDataSource {
  ScheduleDataSourceImpl() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<int> createSchedule(ScheduleCompanion newSchedule) async {
    return into(schedule).insert(newSchedule);
  }

  @override
  Future<bool> updateSchedule(ScheduleData newSchedule) async {
    return update(schedule).replace(newSchedule);
  }

  @override
  Future<int> deleteSchedule(int id) async {
    return (delete(schedule)..where((it) => it.id.equals(id))).go();
  }

  @override
  Future<List<ScheduleData>> fetchAll() async {
    return select(schedule).get();
  }
}
