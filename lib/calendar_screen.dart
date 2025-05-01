import 'dart:ui' as html;

import 'package:calendr/components/calendar_month_view.dart';
import 'package:calendr/model/calendar_events.dart';
import 'package:calendr/services/json_reader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CalendarScreen extends StatelessWidget {
  final String lang;
  final int year;
  const CalendarScreen({super.key, required this.year, required this.lang});

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: Locale(lang),
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.calendar_month),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () {
                      context.go('/$lang/${year - 1}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 4,
                      children: [Icon(Icons.chevron_left), Text('${year - 1}')],
                    ),
                  ),
                  Center(
                    child: Text(
                      'Calendar $year',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      context.go('/$lang/${year + 1}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 4,
                      children: [
                        Text('${year + 1}'),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: JsonReader.read(year, lang: lang),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Loading calendar...'));
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading holidays: ${snapshot.stackTrace}',
                      ),
                    );
                  }

                  final events = snapshot.data ?? CalendarEvents.dummy;

                  return GridView.count(
                    padding: EdgeInsets.all(20),
                    crossAxisCount: 3,
                    childAspectRatio: 6 / 7,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                      12,
                      (index) => CalendarMonthView(
                        year: year,
                        month: index + 1,
                        calendarEvents: events,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: Colors.grey.shade400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      launchUrlString(
                        'https://publicholidays.co.id/$year-dates/',
                      );
                    },
                    child: Text(
                      'Public Holidays',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      launchUrlString(
                        'https://www.calendarlabs.com/holidays/indonesia/$year',
                      );
                    },
                    child: Text(
                      'Calendar Labs',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
