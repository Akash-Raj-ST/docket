// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
  
  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventAdded extends EventState {
  @override
  List<Object> get props => [];
}


class EventLoadedState extends EventState {
  final List<Event> Events;

  EventLoadedState(this.Events);

  @override
  List<Object> get props => [];
}
