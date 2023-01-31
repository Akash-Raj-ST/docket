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

  Future<void> addTask(String title, String dateCreated, bool status) async{
    var key = _tasks.add(Task(title: title, dateCreated: dateCreated, status: status));
  }

  Future<void> deleteTask(int key) async{
    _tasks.delete(key);
  }

  Future<void> updateTask(int key,String title, String dateCreated, bool status) async{
    _tasks.put(key,Task(title: title, dateCreated: dateCreated, status: status));
  }
}