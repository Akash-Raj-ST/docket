// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}


class LoadEventEvent extends EventEvent{
  @override
  List<Object> get props => [];
}

class AddEventEvent extends EventEvent {
  final Event event;
  
  AddEventEvent({
    required this.event,
  });

  @override
  List<Object> get props => [];
}

class UpdateEventEvent extends EventEvent {
  final key;
  final Event event;
  
  UpdateEventEvent({
    required this.key,
    required this.event,
  });

  @override
  List<Object> get props => [];
}

class DeleteEventEvent extends EventEvent {
  final key;
  
  DeleteEventEvent({
    required this.key,
  });

  @override
  List<Object> get props => [];
}

class EventServiceEvent extends EventEvent{
  @override
  List<Object> get props => [];
}
