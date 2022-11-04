import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/view/calender/calendar_page.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedYearAndMonthInCalendar =
        ref.watch(selectedYearAndMonthInCalendarProvider.state);

    return CalendarPageComponent(
      targetDate: selectedYearAndMonthInCalendar.state,
      targetDateOnChange: (DateTime date) {
        selectedYearAndMonthInCalendar.state = date;
      },
    );
  }
}
