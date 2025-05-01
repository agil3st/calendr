import 'package:calendr/model/calendar_events.dart';

class Event {
  final int month;
  final int day;
  final bool isDayOff;
  final EventLevel level;
  final String title;

  Event({
    this.month = 0,
    this.day = 0,
    this.isDayOff = false,
    this.level = EventLevel.mandatory,
    this.title = '',
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    month: json['month'],
    day: json['day'],
    isDayOff: json['is_day_off'],
    level: EventLevel.values.asNameMap()[json['level']] ?? EventLevel.mandatory,
    title: json['title'] ?? '',
  );

  bool get isMandatory => level == EventLevel.mandatory;
  bool get isOptional => !isMandatory;

  String get eventTitle => '$day: $title';
}
