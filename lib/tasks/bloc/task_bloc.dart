import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task.dart';
import '../../services/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final TaskService _taskService;

  TaskBloc(this._taskService) : super(TaskInitial()) {

    on<TaskServiceEvent>((event,emit) async{
          await _taskService.init();
          add(LoadTaskEvent());
      }
    );

    on<LoadTaskEvent>((event, emit) async{
      final all_tasks = await _taskService.getTasks();
      emit(TaskInitial());
      emit(TaskLoadedState(all_tasks));
    });

    on<AddTaskEvent>((event, emit) {
      _taskService.addTask(event.task);
      emit(TaskAdded());
      add(LoadTaskEvent());
    });

    on<UpdateTaskEvent>((event, emit) {
      _taskService.updateTask(event.key, event.task);
      add(LoadTaskEvent());
    });

    on<DeleteTaskEvent>((event, emit) {
      _taskService.deleteTask(event.key);
      emit(TaskDeleted());
      add(LoadTaskEvent());
    });
  }
}
