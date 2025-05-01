import 'package:calendr/model/calendar_events.dart';
import 'package:calendr/model/event.dart';
import 'package:calendr/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonthView extends StatelessWidget {
  final int year;
  final int month;
  final CalendarEvents calendarEvents;
  const CalendarMonthView({
    super.key,
    required this.year,
    required this.month,
    required this.calendarEvents,
  });

  final Color todayColor = Colors.purpleAccent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 6 / 5,
          child: SfCalendar(
            view: CalendarView.month,
            todayHighlightColor: todayColor,
            allowViewNavigation: false,
            monthViewSettings: const MonthViewSettings(
              dayFormat: 'EEE', // Format nama hari
            ),
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
              color: Colors.deepPurple.withValues(alpha: 180),
            ),
            monthCellBuilder: (context, details) {
              Event event = calendarEvents.getEvent(
                month: details.date.month,
                day: details.date.day,
              );

              Color dayColor = Colors.black;
              Color dayColorOther = Colors.black38;
              Color dayBorderColor = Colors.black12;
              Color dayBorderColorOther = Colors.black38;
              Color dayOffColor = const Color.fromARGB(255, 218, 12, 12);
              Color dayOffColorOther = const Color.fromARGB(98, 218, 12, 12);
              Color optionalIndicatorColor = dayOffColor;

              bool isToday =
                  DateUtils.dateOnly(details.date) ==
                  DateUtils.dateOnly(DateTime.now());
              bool isDayOff = (event.isDayOff);
              bool isSunday = DateTimeUtils.isSunday(details.date);
              bool isOtherDate = details.date.month != month;
              bool showOptionalIndicator = false;

              Color? background = isDayOff ? dayOffColor : null;

              Color textColor =
                  isDayOff
                      ? Colors.white
                      : isOtherDate
                      ? dayColorOther
                      : dayColor;

              if (isOtherDate && isDayOff) {
                background = dayOffColorOther;
              }

              if (isSunday && !isDayOff) {
                textColor = dayOffColor;
              }

              if (isOtherDate && isSunday) {
                textColor = dayOffColorOther;
              }

              if (isDayOff && event.isOptional) {
                background = null;
                textColor = isOtherDate ? dayColorOther : dayColor;
                optionalIndicatorColor =
                    isOtherDate ? dayOffColorOther : dayOffColor;
                showOptionalIndicator = true;
              }

              return Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: background,
                  border: Border.all(
                    color:
                        isToday
                            ? todayColor
                            : isOtherDate
                            ? dayBorderColor
                            : dayBorderColorOther,
                    width: isToday ? 3 : 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(
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
                    if (showOptionalIndicator)
                      Positioned(
                        bottom: 3,
                        right: 0,
                        left: 0,
                        child: CircleAvatar(
                          backgroundColor: optionalIndicatorColor,
                          radius: 3,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 3 / 1,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 1,
              children:
                  calendarEvents
                      .groupEventsToMap(month)
                      .entries
                      .map(
                        (e) => Row(
                          spacing: 4,
                          children: [
                            Container(
                              color: Colors.grey.shade300,
                              padding: EdgeInsets.all(1),
                              width: 60,
                              child: Text(
                                e.key,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              e.value,
                              style: TextStyle(
                                // fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
