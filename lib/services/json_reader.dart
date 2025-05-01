import 'dart:convert';

import 'package:calendr/model/calendar_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class JsonReader {
  static Future<CalendarEvents?> read(
    int year, {
    String country = 'id',
    String lang = 'en',
  }) async {
    try {
      final String jsonFile = 'json/$country/public_holiday.$year.$lang.json';
      debugPrint('loading: $jsonFile');
      final String response = await rootBundle.loadString(jsonFile);
      final Map<String, dynamic>? data = await json.decode(response);

      if (data != null) {
        CalendarEvents holiday = CalendarEvents.fromJson(data);
        return holiday;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}
