import 'package:flutter/material.dart';


class PendingTask extends StatefulWidget {
  List all_tasks;
  var handler;
  PendingTask({required this.all_tasks,required this.handler,super.key});

  @override
  State<PendingTask> createState() => _ShowPendingState();
}

class _ShowPendingState extends State<PendingTask> {

  bool is_checked = false;
  List pending_tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.all_tasks.forEach((task) {
      if(task['status']=='pending'){
        pending_tasks.add(task);
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
      return ListView(
        children: pending_tasks.map((task){
          return Task(task: task,handler: widget.handler,);
        }).toList(),
      );
  }
}   

class Task extends StatefulWidget {
  Map task;
  var handler;

  Task({required this.task,required this.handler,super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool is_checked = false;

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
                value: is_checked,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                onChanged: (bool? value){
                  setState(() {
                    is_checked = value!;

                    if(is_checked){
                      widget.handler(widget.task['id'],'completed');
                    }
                  });
                }
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Text(widget.task['title'],
                    style: TextStyle(
                      decoration: is_checked?TextDecoration.lineThrough:TextDecoration.none,
                      fontSize: 14,
                      color: Colors.black,
                      )
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}