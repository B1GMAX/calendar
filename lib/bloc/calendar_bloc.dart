import 'package:calendar/model/day_model.dart';
import 'package:calendar/screen/day_screen.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../model/calendar_model.dart';

class CalendarBloc {
  CalendarBloc() {
    _calendarController.add(calendarModel);
  }

  final _calendarController = BehaviorSubject<CalendarModel>();

  Stream<CalendarModel> get calendarStream => _calendarController.stream;

  CalendarModel calendarModel = CalendarModel(
      dateTime: DateTime.now(),
      dayModelMap: {
        DateTime.now(): DayModel(dateTime: DateTime.now(), taskModelList: [])
      });

  void decreaseMonth() {
    calendarModel = calendarModel.copyWith(
        dateTime: DateTime(
      calendarModel.dateTime.year,
      calendarModel.dateTime.month - 1,
    ));

    _calendarController.add(calendarModel);
  }

  void increaseMonth() {
    calendarModel = calendarModel.copyWith(
        dateTime: DateTime(
      calendarModel.dateTime.year,
      calendarModel.dateTime.month + 1,
    ));

    _calendarController.add(calendarModel);
  }

  void dayClicked(BuildContext context, DateTime dateTime) async {
    final DayModel result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayScreen(
          dayModel: calendarModel.dayModelMap[dateTime] ??
              DayModel(dateTime: dateTime, taskModelList: []),
        ),
      ),
    );

    calendarModel.dayModelMap[result.dateTime] = result;

    _calendarController.add(calendarModel);
  }

  void dispose() {
    _calendarController.close();
  }
}
