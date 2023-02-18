import 'package:docket/services/task.dart';
import 'package:flutter/material.dart';

import 'package:docket/utils/button.dart';
import 'package:docket/utils/heading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Add/add.dart';
import './PendingTask.dart';
import './TodayTask.dart';
import 'bloc/task_bloc.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskState();
}

class _TaskState extends State<TaskPage> {
  

  String current_tab = "Today";

  void set_tab_handler(String option) {
    setState(() {
      current_tab = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => TaskBloc(
        RepositoryProvider.of<TaskService>(context)
      )..add(TaskServiceEvent()),

      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is TaskAdded){
            print("Task Added snackbar");
          }
        },

      builder: (context, state) {
        
        if(state is TaskLoadedState){
          return Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading("Task"),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: ShowOptions(current_tab, set_tab_handler),
                ),
                Expanded(
                    child: current_tab == "Today"
                        ? TodayTask()
                        : PendingTask()
                ),

                FloatingActionButton(
                  onPressed: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<TaskBloc>(context),
                            child: AddPage()
                            )
                          )
                    );

                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
          );
        }

        else{

          return Center(
            child: Text("Loading.."),
          );
        }
        },
      ),
    );
  }
}

Widget ShowOptions(current_tab, handler) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      button("Today", current_tab, handler),
      SizedBox(
        width: 10,
      ),
      button("Pending", current_tab, handler),
    ],
  );
}
