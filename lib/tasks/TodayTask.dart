
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import 'bloc/task_bloc.dart';

import '../utils/utilFunctions.dart';

class TodayTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if(state is TaskLoadedState){
          
          var todayTaskList = state.Tasks.where((task) => dateEquals(task.dateCreated,DateTime.now()));
          
          return ListView(
            children: todayTaskList.map((task) {
                return TaskItem(task: task);
            }).toList(),
          );
        }
        else{
          return Center(
            child:Text("Loading Today Task...")
          );
        }
      },
    );
  }
}


class TaskItem extends StatefulWidget {
  var task;

  TaskItem({required this.task, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.greenAccent;
    }

    return Dismissible(

      key: Key(widget.task.key.toString()),

      onDismissed: ((direction) {
        BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(key: widget.task.key));
        print("dismissed");
      }),

      background: Padding(
        padding: const EdgeInsets.only(top:14.0,bottom:14.0),
        child: Container(color: Colors.red[100],),
      ),

      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
    
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
    
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Checkbox(
                    value: widget.task.status,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    onChanged: (bool? value) {
                      setState(() {
    
                        var updated_task = Task(title: widget.task.title,dateCreated: widget.task.dateCreated,status:value!);
    
                        BlocProvider.of<TaskBloc>(context)..add(UpdateTaskEvent(key: widget.task.key, task: updated_task));
                      });
                    }),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(widget.task.title,
                        style: TextStyle(
                          decoration: widget.task.status
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 14,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

