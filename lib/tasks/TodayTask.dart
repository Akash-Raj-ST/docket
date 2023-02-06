
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task_bloc.dart';

class TodayTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if(state is TaskLoadedState){
          return ListView(
            children: state.Tasks.map((task) {
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

class TaskItem extends StatelessWidget {
  var task;

  TaskItem({required this.task, super.key});

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

    return Padding(
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
                  value: false,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  onChanged: (bool? value) {
                    // setState(() {
                    //   is_checked = value!;

                    //   if (is_checked) {
                    //     //update status of list
                    //   }
                    // });
                  }),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(task.title,
                      style: TextStyle(
                        decoration: task.status
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
    );
  }
}
