import 'package:docket/utils/utilFunctions.dart';
import 'package:hive/hive.dart';
import 'package:docket/models/task.dart';


class TaskService{
  late Box<Task> _tasks;


  Future<void> init() async{
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('TaskBox');

    //clear done tasks;

    final all_tasks = _tasks.values.toList();

    for(int i=0;i<all_tasks.length;i++){

      if(all_tasks[i].status && !dateEquals(all_tasks[i].dateCreated, DateTime.now())){
        _tasks.delete(all_tasks[i].key);
      }
    }
  }

  Future<List<Task>> getTasks() async{
    final all_tasks = _tasks.values.toList();
    return all_tasks;
  }

  Future<void> addTask(Task task) async{
    var key = _tasks.add(task);
  }

  Future<void> deleteTask(int key) async{
    _tasks.delete(key);
  }

  Future<void> updateTask(int key,Task task) async{
    _tasks.put(key,task);
  }
}