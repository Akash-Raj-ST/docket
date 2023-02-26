import 'package:date_time_picker/date_time_picker.dart';
import 'package:docket/components/AddButton.dart';
import 'package:docket/services/event.dart';
import 'package:docket/services/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/CustomTextField.dart';
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
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button("Task", current_tab, handler),
        SizedBox(
          width: 15,
        ),
        button("Event", current_tab, handler),
      ],
    ),
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
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: CustomTextField(
                  controller: _taskContoller,
                  label:"Task",
                ),
              ),
        
              CustomAddButton(
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
                label: "Add Task", 
              )
            ],
          ),
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
  bool alertStatus = false;

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
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomTextField(
                    controller: _eventContoller,
                    label: "Event"
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: DateTimePicker(
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Date"),
                              ),          
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                            child: Container(
                              child: DateTimePicker(
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
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Time"),
                                  ),  
                              ),
                                          
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(

                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                            child: DateTimePicker(
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
                      
                              decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Alert"),
                              ), 
                            ),
                          ),
                        ),
                      ),


                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                            child: Transform.scale(
                              scale: 1.5,
                              child: Switch(
                                value: alertStatus, 
                                onChanged: (value){
                                  setState(() {
                                    alertStatus = value;
                                  });
                                }
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              CustomAddButton(
                onPressed: () {
                  if (_eventContoller.text.length > 0) {
                    BlocProvider.of<EventBloc>(context).add(AddEventEvent(
                        event: Event(
                            title: _eventContoller.text,
                            dateCreated: new DateTime.now().toString(),
                            deadlineDate: date,
                            deadlineTime: time,
                            alert: alert,
                            alertStatus: false)));
        
                            Navigator.of(context).pop();
        
                  } else {
                    //snack for empty warning
                  }
                },
                label: "Add Event",
              )
            ],
          ),
        );
      },
    );
  }
}
