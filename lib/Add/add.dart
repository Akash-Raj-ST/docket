import 'package:docket/services/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import '../tasks/bloc/task_bloc.dart';
import '../utils/button.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String current_tab = "Task";

  void set_tab_handler(String option) {
    setState(() {
      current_tab = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(title: Text("Add")),
        body: Column(
          children: [
            ShowOptions(current_tab, set_tab_handler),
            current_tab == "Task" ? TaskAddPage() : EventAddPage(),
          ],
        ),
      ),
    );
  }
}

Widget ShowOptions(current_tab, handler) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      button("Task", current_tab, handler),
      SizedBox(
        width: 10,
      ),
      button("Event", current_tab, handler),
    ],
  );
}

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({super.key});

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  final _taskContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer(

      bloc: BlocProvider.of<TaskBloc>(context),

      listener: (context, state) {
        // TODO: implement listener
      },

      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: _taskContoller,
              decoration: InputDecoration(
                labelText: "Task",
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // if (_taskContoller.text.length > 0) {
                //   BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                //       task: Task(
                //           title: _taskContoller.text,
                //           dateCreated: new DateTime.now().toString(),
                //           status: false)));
                // } else {
                //   //snack for empty warning
                // }
              },
              icon: Icon(Icons.add),
              label: Text("Add Task"),
            )
          ],
        );
      },
    );
  }
}

class EventAddPage extends StatefulWidget {
  const EventAddPage({super.key});

  @override
  State<EventAddPage> createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  final _eventContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _eventContoller,
          decoration: InputDecoration(
            labelText: "Event",
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop(_eventContoller.text);
          },
          icon: Icon(Icons.add),
          label: Text("Add Event"),
        )
      ],
    );
  }
}
