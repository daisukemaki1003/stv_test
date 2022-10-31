// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:stv_test/model/schedule.dart';

/// 基本情報
const String scheduleTables = 'schedules';

class ScheduleFields {
  static final List<String> values = [
    id,
    name,
    from,
    to,
    isAllDay,
    comment,
  ];

  static const String id = "_id";
  static const String name = "_name";
  static const String from = "_from";
  static const String to = "_to";
  static const String isAllDay = "_isAllDay";
  static const String comment = "_comment";
}

/// インターフェース
abstract class ScheduleDataSource {
  Future<Database> get database;
  // Future<Database> _init(String filePath);
  Future<Schedule> create(Schedule schedule);
  Future<Schedule> readById(int id);
  Future<List<Schedule>> readByMonth(DateTime date);
  Future<int> update(Schedule schedule);
  Future<int> delete(int id);
  Future close();
}

/// 実装
class ScheduleDataSourceImpl implements ScheduleDataSource {
  static final ScheduleDataSourceImpl instance = ScheduleDataSourceImpl._init();

  static Database? _database;

  ScheduleDataSourceImpl._init();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _init('diaries.db');
    return _database!;
  }

  Future<Database> _init(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $scheduleTables ( 
  ${ScheduleFields.id} $idType, 
  ${ScheduleFields.name} $textType,
  ${ScheduleFields.from} $textType,
  ${ScheduleFields.to} $textType,
  ${ScheduleFields.isAllDay} $boolType
  ${ScheduleFields.comment} $textType
  )
''');
  }

  @override
  Future<Schedule> create(Schedule schedule) async {
    final db = await instance.database;

    final id = await db.insert(scheduleTables, schedule.toJson());
    return schedule.copyWith(id: id);
  }

  @override
  Future<Schedule> readById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      scheduleTables,
      columns: ScheduleFields.values,
      where: '${ScheduleFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Schedule.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<List<Schedule>> readByMonth(DateTime date) {
    // TODO: implement readByMonth
    throw UnimplementedError();
  }

  @override
  Future<int> update(Schedule schedule) async {
    final db = await instance.database;

    return db.update(
      scheduleTables,
      schedule.toJson(),
      where: '${ScheduleFields.id} = ?',
      whereArgs: [schedule.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      scheduleTables,
      where: '${ScheduleFields.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
