import 'package:date_time_picker/date_time_picker.dart';
import 'package:docket/services/event.dart';
import 'package:docket/services/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/bloc/event_bloc.dart';
import '../models/event.dart';
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
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is TaskInitial) {
          print("child bloc provider TaskInitial");
        }

        if (state is TaskLoadedState) {
          print("child bloc provider TaskLoaded");
        }
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
                if (_taskContoller.text.length > 0) {
                  BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                      task: Task(
                          title: _taskContoller.text,
                          dateCreated: new DateTime.now().toString(),
                          status: false)));

                  Navigator.of(context).pop();
                  
                } else {
                  //snack for empty warning
                }
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

  String event_name = "";
  String date = "";
  String time = "";
  String alert = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is EventAdded){
          print("event added successfully");
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Event"),
            TextField(
              controller: _eventContoller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Text("Date"),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              onChanged: (value) => {
                setState(() {
                  date = value;
                })
              },
            ),
            Text("Time"),
            DateTimePicker(
              type: DateTimePickerType.time,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.lock_clock),
              onChanged: (value) => {
                setState(() {
                  time = value;
                })
              },
            ),
            Text("Alert"),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.lock_clock),
              onChanged: (value) => {
                setState(() {
                  alert = value;
                })
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_eventContoller.text.length > 0) {
                  BlocProvider.of<EventBloc>(context).add(AddEventEvent(
                      event: Event(
                          title: _eventContoller.text,
                          dateCreated: new DateTime.now().toString(),
                          deadlineDate: date,
                          deadlineTime: time,
                          alert: alert,
                          status: false)));

                          Navigator.of(context).pop();

                } else {
                  //snack for empty warning
                }
              },
              icon: Icon(Icons.add),
              label: Text("Add Event"),
            )
          ],
        );
      },
    );
  }
}
