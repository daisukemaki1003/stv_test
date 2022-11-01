import 'package:drift/drift.dart';

class Schedule extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get comment => text().named('comment')();
  DateTimeColumn get from => dateTime().named('from')();
  DateTimeColumn get to => dateTime().named('to')();
  BoolColumn get isAllDay =>
      boolean().withDefault(const Constant(false)).named('is_all_day')();
}
