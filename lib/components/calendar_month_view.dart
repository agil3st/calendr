import 'package:calendr/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonthView extends StatelessWidget {
  final int month;
  CalendarMonthView({super.key, required this.month});

  final int year = DateTime.now().year;
  final Map<String, dynamic> holidays = {"1": "Hari Ini", "12": "Hari Itu"};

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      allowViewNavigation: false,
      minDate: DateTime.parse(
        '$year-${month.toString().padLeft(2, '0')}-01 00:00:00',
      ),
      maxDate: DateTime.parse(
        '$year-${month.toString().padLeft(2, '0')}-${DateUtils.getDaysInMonth(year, month)} 00:00:00',
      ),
      headerDateFormat: 'MMMM',
      headerStyle: CalendarHeaderStyle(
        backgroundColor: Colors.grey.shade300,
        textStyle: TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
      headerHeight: 60,
      showTodayButton: false,
      selectionDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurple.withValues(alpha: 200),
      ),
      monthCellBuilder: (context, details) {
        bool isDayOff = holidays.keys.contains(details.date.day.toString());
        bool isSunday = DateTimeUtils.isSunday(details.date);

        Color? background =
            isDayOff ? const Color.fromARGB(255, 211, 27, 14) : null;

        Color textColor =
            isDayOff
                ? Colors.white
                : details.date.month != month
                ? Colors.black38
                : Colors.black;

        if (isSunday && !isDayOff) {
          textColor = const Color.fromARGB(255, 233, 62, 50);
        }

        return Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: background,
            border: Border.all(
              color:
                  details.date.month != month ? Colors.black12 : Colors.black38,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              details.date.day.toString(),
              style: TextStyle(
                fontWeight:
                    details.date.month != month
                        ? FontWeight.w500
                        : FontWeight.w700,
                fontSize: 20,
                color: textColor,
              ),
            ),
          ),
        );
      },
    );

    /* return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.now(),
      lastDay: DateTime.now(),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextFormatter:
            (date, locale) => DateFormat.MMMM(locale).format(date),
      ),
    ); */
  }
}
