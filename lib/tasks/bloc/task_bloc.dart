import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task.dart';
import '../../services/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final TaskService _taskService;

  TaskBloc(this._taskService) : super(TaskInitial()) {
    on<LoadTaskEvent>((event, emit) async{
      final all_tasks = await _taskService.getTasks();
      emit(TaskLoadedState(all_tasks));
    });

    on<AddTaskEvent>((event, emit) {
      _taskService.addTask(event.task);
      emit(TaskInitial());

      add(LoadTaskEvent());
    });

    on<UpdateTaskEvent>((event, emit) {
      _taskService.updateTask(event.key, event.task);
    });

    on<DeleteTaskEvent>((event, emit) {
      _taskService.deleteTask(event.key);
    });
  }
}
