part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskAdded extends TaskState {

  @override
  List<Object> get props => [];
}


class TaskDeleted extends TaskState {

  @override
  List<Object> get props => [];
}


class TaskLoadedState extends TaskState {
  final List<Task> Tasks;

  TaskLoadedState(this.Tasks);

  @override
  List<Object> get props => [];
}
