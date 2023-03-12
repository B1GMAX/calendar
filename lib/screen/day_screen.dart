import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../bloc/day_bloc.dart';
import '../model/day_model.dart';

class DayScreen extends StatelessWidget {
  final DayModel? dayModel;

  const DayScreen({required this.dayModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<DayBloc>(
      create: (context) => DayBloc(dayModel),
      builder: (context, _) {
        return Scaffold(
          floatingActionButton: StreamBuilder<List<String>>(
              initialData: const [],
              stream: context.read<DayBloc>().timeListStream,
              builder: (context, timeListSnapshot) {
                return FloatingActionButton(
                  onPressed: () {
                    context
                        .read<DayBloc>()
                        .showAddTaskDialog(context, timeListSnapshot.data!);
                  },
                  child: const Icon(Icons.add),
                );
              }),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context, dayModel);
              },
            ),
            centerTitle: true,
            title: Text(dayModel != null
                ? DateFormat.yMMMMd().format(dayModel!.dateTime)
                : ''),
          ),
          body: StreamBuilder<DayModel?>(
            stream: context.read<DayBloc>().dayModelStream,
            builder: (context, daySnapshot) {
              return daySnapshot.hasData
                  ? ListView.builder(
                      itemCount: daySnapshot.data!.taskModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          constraints: const BoxConstraints(minHeight: 70),
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.blue[100]!,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    daySnapshot
                                        .data!.taskModelList[index].description
                                        .toString(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '${daySnapshot.data!.taskModelList[index].time} год'),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
