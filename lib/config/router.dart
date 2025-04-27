import 'package:calendr/calendar_screen.dart';
import 'package:calendr/index_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => IndexScreen()),
    GoRoute(
      path: '/:year',
      builder: (context, state) {
        int year = int.tryParse(state.pathParameters['year'] ?? '0') ?? 0;
        return CalendarScreen(year: year);
      },
    ),
  ],
);
