import 'package:calendar/bloc/calendar_bloc.dart';
import 'package:date_utils/date_utils.dart' as du;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/calendar_model.dart';
import '../widget/day_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CalendarBloc>(
      lazy: false,
      create: (context) => CalendarBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, _) {
        return StreamBuilder<CalendarModel>(
          stream: context.read<CalendarBloc>().calendarStream,
          builder: (context, calendarSnapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CalendarBloc>().decreaseMonth();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    Text(calendarSnapshot.hasData
                        ? DateFormat.yMMMM()
                            .format(calendarSnapshot.data!.dateTime)
                        : ''),
                    IconButton(
                      onPressed: () {
                        context.read<CalendarBloc>().increaseMonth();
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              body: calendarSnapshot.hasData
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 20, right: 8),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisExtent: 100,
                                childAspectRatio: 1),
                        itemCount: du.DateUtils.lastDayOfMonth(
                                calendarSnapshot.data!.dateTime)
                            .day,
                        itemBuilder: (context, index) {
                          final day = index + 1;
                          return DayWidget(
                            dateTime: DateTime(
                                calendarSnapshot.data!.dateTime.year,
                                calendarSnapshot.data!.dateTime.month,
                                day),
                            tasksNumbers: calendarSnapshot
                                    .data!
                                    .dayModelMap[DateTime(
                                        calendarSnapshot.data!.dateTime.year,
                                        calendarSnapshot.data!.dateTime.month,
                                        day)]
                                    ?.taskModelList
                                    .length ??
                                0,
                            day: day,
                            onClick: () {
                              context.read<CalendarBloc>().dayClicked(
                                  context,
                                  DateTime(
                                      calendarSnapshot.data!.dateTime.year,
                                      calendarSnapshot.data!.dateTime.month,
                                      day));
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
