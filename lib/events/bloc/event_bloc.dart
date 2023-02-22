
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:docket/services/event.dart';

import '../../models/event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  
  final EventService _eventService;
  
  EventBloc(this._eventService) : super(EventInitial()) {

    on<EventServiceEvent>((event,emit) async{
      await _eventService.init();

      add(LoadEventEvent());
    });

    on<LoadEventEvent>((event, emit) async{
      final all_events = await _eventService.getEvents();
      emit(EventInitial());
      emit(EventLoadedState(all_events));
    });

    on<AddEventEvent>((event, emit) {
      _eventService.addEvent(event.event);
      emit(EventAdded());
      add(LoadEventEvent());
    });

    on<UpdateEventEvent>((event, emit) {
      _eventService.updateEvent(event.key, event.event);
    });

    on<DeleteEventEvent>((event, emit) {
      _eventService.deleteEvent(event.key);
      emit(EventDeleted());
      add(LoadEventEvent());
    });
  }
}
