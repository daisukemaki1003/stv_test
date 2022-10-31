import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/utils/create_calendar_list.dart';

/// 選択された年
final targetYearProvider = StateProvider<int>((ref) => DateTime.now().year);

/// 選択された月
final targetMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

/// 選択された日付
final targetDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

/// [targetDateProvider]の状態を書き換えるPageViewを管理
final pageIndexProvider = StateProvider<int>((ref) => 999);

/// 表示中のカレンダー
final calendarListProvider = Provider<List<Calendar>>((ref) {
  final year = ref.watch(targetYearProvider);
  final month = ref.watch(targetMonthProvider);

  return createCalendarList(year, month);
});
