// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:docket/models/event.dart';

class EventService {
  late Box<Event> _events;

  Future<void> init() async{
    Hive.registerAdapter(EventAdapter());
    _events = await Hive.openBox<Event>('EventBox');
  } 

  Future<List<Event>> getEvents() async{
    final all_events = _events.values.toList();
    return all_events;
    //return [Event(title: "Check1", dateCreated: "Today", deadlineDate: "2023-01-02", deadlineTime: "2023-01-02", alert: "alert_time", status: false)];
  }

  Future<void> addEvent(Event event) async{
    var key = _events.add(event);
    print("Event added");
  }

  Future<void> deleteEvent(int key) async{
    await _events.delete(key);
  }

  Future<void> updateEvent(int key,Event event) async{
    await _events.put(key,event);
  }
}
