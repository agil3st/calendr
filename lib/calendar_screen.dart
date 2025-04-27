import 'package:calendr/components/calendar_month_view.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  final int year;
  const CalendarScreen({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Calendar $year'),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(20),
              crossAxisCount: 3,
              childAspectRatio: 6 / 5,
              shrinkWrap: true,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: List.generate(
                12,
                (index) => CalendarMonthView(month: index + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
