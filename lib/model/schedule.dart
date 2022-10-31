// class Schedule {
//   final int? id;
//   final String name;
//   final DateTime from;
//   final DateTime to;
//   final bool isAllDay;
//   final String comment;

//   Schedule({
//     required this.id,
//     required this.name,
//     required this.from,
//     required this.to,
//     required this.isAllDay,
//     required this.comment,
//   });
// }

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
