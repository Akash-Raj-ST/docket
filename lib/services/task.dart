import 'package:hive/hive.dart';
import 'package:docket/models/task.dart';


class TaskService{
  late Box<Task> _tasks;

  Future<void> init() async{
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('TaskBox');
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