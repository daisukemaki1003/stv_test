import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stv_test/routing/named_route.dart';
import 'package:stv_test/view/calendar.dart';
import 'package:stv_test/view/error.dart';

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
    ],
    errorBuilder: (context, state) => RouteErrorPage(
      key: state.pageKey,
      errorMsg: state.error.toString(),
    ),
  );
});
