import 'package:hive/hive.dart';
import 'package:docket/models/event.dart';


class EventService{
  late Box<Event> _events;

  Future<void> init() async{
    Hive.registerAdapter(EventAdapter());
    _events = await Hive.openBox<Event>('EventBox');

    _events.clear();

    _events.add(Event(title: "Check1", dateCreated: "Today", deadlineDate: "2023-01-02", deadlineTime: "2023-01-02", alert: "alert_time", status: false));
    _events.add(Event(title: "Check2", dateCreated: "Today", deadlineDate: "2023-01-02", deadlineTime: "2023-01-02", alert: "alert_time", status: false));
    print("Loaded event init");
  }

  Future<List<Event>> getEvents() async{
    // final all_events = _events.values.toList();
    
    return [Event(title: "Check1", dateCreated: "Today", deadlineDate: "2023-01-02", deadlineTime: "2023-01-02", alert: "alert_time", status: false)];
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