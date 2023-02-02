
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:docket/services/event.dart';

import '../../models/event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  
  final EventService _eventService;
  
  EventBloc(this._eventService) : super(EventInitial()) {
    on<LoadEventEvent>((event, emit) async{
      final all_events = await _eventService.getEvents();
      emit(EventLoadedState(all_events));
    });

    on<AddEventEvent>((event, emit) {
      _eventService.addEvent(event.event);
      emit(EventInitial());

      add(LoadEventEvent());
    });

    on<UpdateEventEvent>((event, emit) {
      _eventService.updateEvent(event.key, event.event);
    });

    on<DeleteEventEvent>((event, emit) {
      _eventService.deleteEvent(event.key);
    });
  }
}
