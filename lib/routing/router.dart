import 'package:flutter/material.dart';
import 'package:stv_test/view/calendar.dart';
import 'package:stv_test/view/schedule_edit.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CalendarPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CalendarPage(),
      );
    case ScheduleEditPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ScheduleEditPage(),
      );

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Error 404'),
                ),
              ));
  }
}
