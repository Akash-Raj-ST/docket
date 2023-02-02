part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTaskEvent extends TaskEvent{
  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Task task;
  
  AddTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [];
}

class UpdateTaskEvent extends TaskEvent {
  final key;
  final Task task;
  
  UpdateTaskEvent({
    required this.key,
    required this.task,
  });

  @override
  List<Object> get props => [];
}

class DeleteTaskEvent extends TaskEvent {
  final key;
  
  DeleteTaskEvent({
    required this.key,
  });

  @override
  List<Object> get props => [];
}
