import 'package:calendr/model/country_details.dart';
import 'package:calendr/model/event.dart';

class CalendarEvents {
  final CountryDetails countryDetails;
  final List<Event> events;

  CalendarEvents({required this.countryDetails, required this.events});

  factory CalendarEvents.fromJson(Map<String, dynamic> json) => CalendarEvents(
    countryDetails: CountryDetails.fromJson(json['country_details']),
    events: (json['events'] as List).map((e) => Event.fromJson(e)).toList(),
  );

  List<Event> monthEvents(int month) {
    return events.where((e) => e.month == month).toList();
  }

  Map<String, String> groupEventsToMap(int month) {
    final events = monthEvents(month);
    final grouped = <String, List<int>>{};

    for (final event in events) {
      final key = '${event.month}-${event.title}';
      grouped.putIfAbsent(key, () => []).add(event.day);
    }

    final result = <String, String>{};

    for (final entry in grouped.entries) {
      final parts = entry.key.split('-');
      final title = parts.sublist(1).join('-'); // handle dash in title
      final days = entry.value..sort();
      final range =
          (days.length == 1) ? '${days.first}' : '${days.first}–${days.last}';

      result[range] = title;
    }

    return result;
  }

  Event getEvent({required int month, required int day}) {
    if (events.isEmpty) return Event();

    final event = events.firstWhere(
      (e) => e.month == month && e.day == day,
      orElse: () => Event(),
    );

    return event;
  }

  static CalendarEvents get dummy =>
      CalendarEvents(countryDetails: CountryDetails(), events: []);
}

enum EventLevel { mandatory, optional }
