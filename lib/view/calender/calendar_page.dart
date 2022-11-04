import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/view/calender/calendar_component.dart';

final pageIndexProvider = StateProvider((_) => 999);

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
      onSwipe: (index) {
        final pageIndex = ref.watch(pageIndexProvider.state);
        selectedYearAndMonthInCalendar.state =
            Jiffy(selectedYearAndMonthInCalendar.state)
                .add(months: index - pageIndex.state)
                .dateTime;
        pageIndex.state = index;
      },
      pageIndex: ref.watch(pageIndexProvider.state).state,
    );
  }
}
