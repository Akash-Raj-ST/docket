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

  Future<void> addEvent(String title, String dateCreated, String deadline, String alert, bool status) async{
    var key = _events.add(Event(title: title, dateCreated: dateCreated, deadline: deadline, alert: alert, status: status));
  }

  Future<void> deleteEvent(int key) async{
    _events.delete(key);
  }

  Future<void> updateEvent(int key,String title, String dateCreated, String deadline, String alert, bool status) async{
    _events.put(key,Event(title: title, dateCreated: dateCreated, deadline: deadline, alert: alert, status: status));
  }
}