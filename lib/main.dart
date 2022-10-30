import 'package:flutter/material.dart';
import 'package:stv_test/view/calendar.dart';
import 'package:stv_test/view/schedule_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const CalendarPage(),
      home: const ScheduleEditor(),
    );
  }
}
