import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  static Future<Map<String, dynamic>> read(
    int year, {
    String country = 'id',
  }) async {
    final String response = await rootBundle.loadString(
      'assets/json/$country/public_holiday.$year.$country.json',
    );
    final Map<String, dynamic> data = await json.decode(response);
    return data;
  }
}
