import 'package:calendar/widget/alert_box.dart';
import 'package:calendar/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../model/day_model.dart';

class DayBloc {
  final DayModel? dayModel;

  DayBloc(this.dayModel) {
    if (dayModel != null) {
      _dayModelController.add(dayModel!);
    }
    increaseDuration();
  }

  final _timeListController = BehaviorSubject<List<String>>();
  final _dayModelController = BehaviorSubject<DayModel?>();

  Stream<List<String>> get timeListStream => _timeListController.stream;

  Stream<DayModel?> get dayModelStream => _dayModelController.stream;

  final descriptionTextController = TextEditingController();

  void showAddTaskDialog(BuildContext context, List<String> timeList) {
    String selectedItem = '00:30';

    showDialog(
      context: context,
      builder: (context) {
        return AlertBox(
          descriptionTextController: descriptionTextController,
          timeList: timeList,
          onDropButtonChange: (value) {
            selectedItem = value;
          },
          onSaveClick: () {
            dayModel?.taskModelList.add(TaskModel(
                time: selectedItem,
                description: descriptionTextController.text.trim()));

            _dayModelController.add(dayModel);
            descriptionTextController.clear();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  final List<String> timeList = [];

  void increaseDuration() {
    for (int i = 30; i < 1460; i = i + 30) {
      timeList.add(convertDuration(Duration(minutes: 0 + i)));
    }
    _timeListController.add(timeList);
  }

  String convertDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitHours:$twoDigitMinutes';
  }

  void dispose() {
    _dayModelController.close();
    _timeListController.close();
  }
}
