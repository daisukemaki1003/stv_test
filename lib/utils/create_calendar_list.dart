import 'package:stv_test/model/calendar.dart';

List<Calendar> prevPaddingDays(int year, int month) {
  final calendarList = <Calendar>[];
  final firstDay = DateTime(year, month).weekday;
  final paddingDayCount = (firstDay + 7 - 1) % 7;
  final prevLastDate = DateTime(year, month, 0).day;
  for (var day = prevLastDate - paddingDayCount + 1;
      day < prevLastDate + 1;
      day++) {
    calendarList.add(
      Calendar(
        date: DateTime(year, month, day),
        enabled: false,
      ),
    );
  }
  return calendarList;
}

List<Calendar> currentDays(int year, int month) {
  final calendarList = <Calendar>[];
  final lastDate = DateTime(year, month + 1, 0);
  final currentDayCount = lastDate.day;
  for (var day = 1; day < currentDayCount + 1; day++) {
    calendarList.add(Calendar(
      date: DateTime(year, month, day),
      enabled: true,
    ));
  }
  return calendarList;
}

List<Calendar> nextPaddingDays(int year, int month, prevList, currentList) {
  final list = <Calendar>[];
  final paddingDayCount = (42 - (prevList.length + currentList.length)) % 7;
  for (var day = 1; day < paddingDayCount + 1; day++) {
    list.add(Calendar(
      date: DateTime(year, month, day),
      enabled: false,
    ));
  }
  return list;
}

List<List<Calendar>> createCalendarList(int targetYear, int targetMonth) {
  final prevList = prevPaddingDays(targetYear, targetMonth);
  final currentList = currentDays(targetYear, targetMonth);
  final nextList =
      nextPaddingDays(targetYear, targetMonth, prevList, currentList);
  final flatCalendarDate = [
    ...prevList,
    ...currentList,
    ...nextList,
  ];

  return to2Dim(flatCalendarDate, 7);
}

/// ２次元リストを作成する
List<List<Calendar>> to2Dim(list, numOfElems) {
  if (list.isEmpty) {
    return [];
  }
  return [
    list.take(numOfElems).toList(),
    ...to2Dim(list.skip(numOfElems), numOfElems)
  ];
}
