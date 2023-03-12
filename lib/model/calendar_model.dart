import 'day_model.dart';

class CalendarModel {
  final DateTime dateTime;
  final Map<DateTime, DayModel> dayModelMap;

  const CalendarModel({required this.dateTime, required this.dayModelMap});

  CalendarModel copyWith(
          {DateTime? dateTime, Map<DateTime, DayModel>? dayModelMap}) =>
      CalendarModel(
        dateTime: dateTime ?? this.dateTime,
        dayModelMap: dayModelMap ?? this.dayModelMap,
      );
}
