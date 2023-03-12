import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayWidget extends StatelessWidget {
  final VoidCallback onClick;
  final int day;
  final int tasksNumbers;
  final DateTime dateTime;

  const DayWidget(
      {required this.day,
      required this.onClick,
      required this.tasksNumbers,
      required this.dateTime,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onClick,
          child: Container(
            height: 65,
            width: 55,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: Colors.blue[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEEE').format(dateTime).substring(0, 3),
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  day.toString(),
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
        tasksNumbers != 0
            ? Positioned(
                right: 2,
                bottom: 27,
                child: Container(
                  alignment: Alignment.center,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.blue[700]!,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    tasksNumbers.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
