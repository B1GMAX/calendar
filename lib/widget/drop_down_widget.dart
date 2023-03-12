import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final List<String> timeList;
  final Function(String) onDropButtonChange;

  const DropDownWidget(
      {required this.timeList, required this.onDropButtonChange, Key? key})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String selectedItem = '00:30';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      items: widget.timeList
          .map(
            (time) => DropdownMenuItem(
              value: time,
              child: Text(time.toString()),
            ),
          )
          .toList(),
      onChanged: (time) {
        setState(() {
          selectedItem = time!;
        });
        widget.onDropButtonChange(time!);
      },
    );
  }
}
