import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:docket/utils/button.dart';
import 'package:docket/utils/heading.dart';
import './PendingTask.dart';
import './TodayTask.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskState();
}

class _TaskState extends State<TaskPage> {

  List all_tasks = [{"id":1,"title":"review  2 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":2,"title":"review  3 ppt for ISM","deadline":"12/01/2023","status":"today"},
                    {"id":3,"title":"review  4 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":4,"title":"review  5 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":5,"title":"review  6 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":6,"title":"review  7 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":7,"title":"review  8 ppt for ISM","deadline":"12/01/2023","status":"today"},
                    {"id":8,"title":"review  9 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":9,"title":"review  10 ppt for ISM","deadline":"12/01/2023","status":"pending"},
                    {"id":10,"title":"review  11 ppt for ISM","deadline":"12/01/2023","status":"pending"},
  ];

  String current_tab = "Today";

  void set_tab_handler(String option){
    setState(() {
      current_tab = option;
    });
  }

  void update_status_handler(int id,String status){
    List updated_tasks = all_tasks;

    updated_tasks.forEach((task) {
      if(task['id']==id){
        task['status'] = status;
      }
    });

    setState(() {
      all_tasks = updated_tasks;
    });
    print(all_tasks);
  }

  void add_task_handler(task){
    print("adding task...");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    
        children: [
          heading("Task"),
      
          Padding(
            padding: const EdgeInsets.only(top:15,bottom:15),
            child: ShowOptions(current_tab,set_tab_handler),
          ),
          
          Expanded(
            child: current_tab=="Today"?TodayTask(all_tasks: all_tasks,handler: update_status_handler):PendingTask(all_tasks: all_tasks,handler: update_status_handler)
          ),
      
        ],
      ),
    );
  }
}


Widget ShowOptions(current_tab,handler) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      button("Today",current_tab,handler),
      SizedBox(width: 10,),
      button("Pending",current_tab,handler),
      
    ],
  );
}
