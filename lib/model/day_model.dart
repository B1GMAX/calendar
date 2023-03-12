import 'package:calendar/model/task_model.dart';

class DayModel {
  final DateTime dateTime;
  final List<TaskModel> taskModelList;

  const DayModel({required this.dateTime, required this.taskModelList});
}
