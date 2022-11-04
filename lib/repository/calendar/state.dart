import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/utils/create_calendar_list.dart';

// /// プロバイダー
// final calendarNotifierProvider =
//     StateNotifierProvider<CalendarNotifier, List<Calendar>>((ref) {
//   return CalendarNotifier(ref)..initialize();
// });

// /// ステート
// class CalendarNotifier extends StateNotifier<List<Calendar>> {
//   CalendarNotifier(this.ref) : super(List.empty());

//   final Ref ref;

//   Future<void> initialize() async {
//     await fetchList();
//   }

//   fetchList() async {
//     final selectedYearAndMonthInCalendar =
//         ref.watch(selectedYearAndMonthInCalendarProvider);

//     state = createCalendarList(
//       selectedYearAndMonthInCalendar.year,
//       selectedYearAndMonthInCalendar.month,
//     );
//   }

//   setSchedule(List<ScheduleData> schedules) {
//     final days = state;
//     for (var day in days) {
//       final results =
//           schedules.where((element) => day.isThatDay(element.from)).toList();
//       if (results.isNotEmpty) day.schedules.addAll(results);
//     }
//     state = days;
//   }
// }

// class CalendarNotifier extends StateNotifier<AsyncValue<List<Calendar>>> {
//   CalendarNotifier(super.state, this.ref);

//   final Ref ref;

//   Future<void> initialize() async {
//     /// スケジュールを取得
//     final schedules = [];

//     /// カレンダーデータ
//   }
// }
