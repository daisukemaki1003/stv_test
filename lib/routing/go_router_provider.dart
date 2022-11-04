import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stv_test/routing/named_route.dart';
import 'package:stv_test/view/calender/calendar_component.dart';
import 'package:stv_test/view/error.dart';
import 'package:stv_test/view/schedule_edit/schedule_edit_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: calendarPath,
    routes: [
      GoRoute(
        path: calendarPath,
        builder: (context, state) => CalendarPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: createSchedulePath,
        builder: (context, state) => ScheduleEditPage(
          key: state.pageKey,
          title: "予定の追加",
          isCreate: true,
        ),
      ),
      GoRoute(
        path: editSchedulePath,
        builder: (context, state) => ScheduleEditPage(
          key: state.pageKey,
          title: "予定の編集",
          isCreate: false,
        ),
      ),
    ],
    errorBuilder: (context, state) => RouteErrorPage(
      key: state.pageKey,
      errorMsg: state.error.toString(),
    ),
  );
});
