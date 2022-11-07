import 'package:intl/intl.dart';

const mon = "月";
const tue = "火";
const wed = "水";
const thu = "木";
const fri = "金";
const sat = "土";
const sun = "日";

/// Calendar page
const kCalenderPageTitle = "カレンダー";
final kCalenderPageWeekHeaderDateFormat = DateFormat('yyyy年MM月');
const kCalenderPageTodayButtonText = "今日";

/// SchedulePage
final kSchedulePageLabelDateFormat = DateFormat('yyyy/MM/dd');
final kSchedulePageWeekLabelDateFormat = DateFormat.E('ja');
const kSchedulePageAllDayText = "終日";
final kSchedulePageEstimatedTimeDateFormat = DateFormat('HH:mm');
const kSchedulePageNoPlanText = "予定がありません";

/// ScheduleEditPage
const kScheduleEditPageDiscardEditsText = "編集を破棄";
const kScheduleEditPageDeleteEventTitle = "予定の削除";
const kScheduleEditPageDeleteEventContent = "本当にこの日の予定を削除しますか？";
final kScheduleEditPageDateFormat = DateFormat('yyyy-MM-dd HH:mm');
final kScheduleEditPageDateFormatForAllDay = DateFormat('yyyy-MM-dd');
const kScheduleEditPageDeleteButtonText = "この予定を削除";
