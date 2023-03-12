import 'package:flutter/material.dart';

import 'drop_down_widget.dart';

class AlertBox extends StatelessWidget {
  final TextEditingController descriptionTextController;
  final VoidCallback onSaveClick;
  final List<String> timeList;

  final Function(String) onDropButtonChange;

  const AlertBox(
      {required this.descriptionTextController,
      required this.onSaveClick,
      required this.timeList,
      required this.onDropButtonChange,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: descriptionTextController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter Task Description',
                helperStyle: TextStyle(color: Colors.grey[600]),
                hintStyle: TextStyle(color: Colors.grey[600]),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 25),
              child: DropDownWidget(
                timeList: timeList,
                onDropButtonChange: onDropButtonChange,
              )),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            MaterialButton(
              onPressed: onSaveClick,
              color: Colors.black,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
