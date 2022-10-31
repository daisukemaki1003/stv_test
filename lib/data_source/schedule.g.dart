// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ScheduleData extends DataClass implements Insertable<ScheduleData> {
  final int id;
  final String title;
  final String comment;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  const ScheduleData(
      {required this.id,
      required this.title,
      required this.comment,
      required this.from,
      required this.to,
      required this.isAllDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['comment'] = Variable<String>(comment);
    map['from'] = Variable<DateTime>(from);
    map['to'] = Variable<DateTime>(to);
    map['is_all_day'] = Variable<bool>(isAllDay);
    return map;
  }

  ScheduleCompanion toCompanion(bool nullToAbsent) {
    return ScheduleCompanion(
      id: Value(id),
      title: Value(title),
      comment: Value(comment),
      from: Value(from),
      to: Value(to),
      isAllDay: Value(isAllDay),
    );
  }

  factory ScheduleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      comment: serializer.fromJson<String>(json['comment']),
      from: serializer.fromJson<DateTime>(json['from']),
      to: serializer.fromJson<DateTime>(json['to']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'comment': serializer.toJson<String>(comment),
      'from': serializer.toJson<DateTime>(from),
      'to': serializer.toJson<DateTime>(to),
      'isAllDay': serializer.toJson<bool>(isAllDay),
    };
  }

  ScheduleData copyWith(
          {int? id,
          String? title,
          String? comment,
          DateTime? from,
          DateTime? to,
          bool? isAllDay}) =>
      ScheduleData(
        id: id ?? this.id,
        title: title ?? this.title,
        comment: comment ?? this.comment,
        from: from ?? this.from,
        to: to ?? this.to,
        isAllDay: isAllDay ?? this.isAllDay,
      );
  @override
  String toString() {
    return (StringBuffer('ScheduleData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('isAllDay: $isAllDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, comment, from, to, isAllDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleData &&
          other.id == this.id &&
          other.title == this.title &&
          other.comment == this.comment &&
          other.from == this.from &&
          other.to == this.to &&
          other.isAllDay == this.isAllDay);
}

class ScheduleCompanion extends UpdateCompanion<ScheduleData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> comment;
  final Value<DateTime> from;
  final Value<DateTime> to;
  final Value<bool> isAllDay;
  const ScheduleCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
    this.isAllDay = const Value.absent(),
  });
  ScheduleCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String comment,
    required DateTime from,
    required DateTime to,
    this.isAllDay = const Value.absent(),
  })  : title = Value(title),
        comment = Value(comment),
        from = Value(from),
        to = Value(to);
  static Insertable<ScheduleData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? comment,
    Expression<DateTime>? from,
    Expression<DateTime>? to,
    Expression<bool>? isAllDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (comment != null) 'comment': comment,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (isAllDay != null) 'is_all_day': isAllDay,
    });
  }

  ScheduleCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? comment,
      Value<DateTime>? from,
      Value<DateTime>? to,
      Value<bool>? isAllDay}) {
    return ScheduleCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      from: from ?? this.from,
      to: to ?? this.to,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (from.present) {
      map['from'] = Variable<DateTime>(from.value);
    }
    if (to.present) {
      map['to'] = Variable<DateTime>(to.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('isAllDay: $isAllDay')
          ..write(')'))
        .toString();
  }
}

class $ScheduleTable extends Schedule
    with TableInfo<$ScheduleTable, ScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _fromMeta = const VerificationMeta('from');
  @override
  late final GeneratedColumn<DateTime> from = GeneratedColumn<DateTime>(
      'from', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _toMeta = const VerificationMeta('to');
  @override
  late final GeneratedColumn<DateTime> to = GeneratedColumn<DateTime>(
      'to', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _isAllDayMeta = const VerificationMeta('isAllDay');
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
      'is_all_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("is_all_day" IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, comment, from, to, isAllDay];
  @override
  String get aliasedName => _alias ?? 'schedule';
  @override
  String get actualTableName => 'schedule';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('from')) {
      context.handle(
          _fromMeta, from.isAcceptableOrUnknown(data['from']!, _fromMeta));
    } else if (isInserting) {
      context.missing(_fromMeta);
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to']!, _toMeta));
    } else if (isInserting) {
      context.missing(_toMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(_isAllDayMeta,
          isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      comment: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}comment'])!,
      from: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}from'])!,
      to: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}to'])!,
      isAllDay: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_all_day'])!,
    );
  }

  @override
  $ScheduleTable createAlias(String alias) {
    return $ScheduleTable(attachedDatabase, alias);
  }
}

abstract class _$ScheduleDataSourceImpl extends GeneratedDatabase {
  _$ScheduleDataSourceImpl(QueryExecutor e) : super(e);
  late final $ScheduleTable schedule = $ScheduleTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [schedule];
}
