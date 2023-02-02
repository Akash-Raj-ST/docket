import 'package:hive/hive.dart';
import 'package:docket/models/event.dart';


class EventService{
  late Box<Event> _events;

  Future<void> init() async{
    Hive.registerAdapter(EventAdapter());
    _events = await Hive.openBox<Event>('EventBox');
  }

  Future<List<Event>> getEvents() async{
    final all_events = _events.values.toList();

    return all_events;
  }

  Future<void> addEvent(Event event) async{
    var key = _events.add(event);
  }

  Future<void> deleteEvent(int key) async{
    _events.delete(key);
  }

  Future<void> updateEvent(int key,Event event) async{
    _events.put(key,event);
  }
}