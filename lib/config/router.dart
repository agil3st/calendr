import 'package:calendr/calendar_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) =>
              CalendarScreen(year: DateTime.now().year, lang: 'id'),
    ),
    GoRoute(
      path: '/:lang/:year',
      builder: (context, state) {
        final String lang = state.pathParameters['lang'] ?? 'id';
        final int year =
            int.tryParse(
              state.pathParameters['year'] ?? '${DateTime.now().year}',
            ) ??
            DateTime.now().year;
        return CalendarScreen(year: year, lang: lang);
      },
    ),
  ],
);
