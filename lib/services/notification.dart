import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
  void init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
                                  InitializationSettings(
                                      android: initializationSettingsAndroid, 
                                  );
  
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
    
  }

  Future<void> showNotification(int id, String title, String body,DateTime scheduleTime) async {
    
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
                                              'ChannelId_6', 
                                              'channelName',
                                              'channelDescription',
                                              playSound: true,
                                              priority: Priority.high,
                                              importance: Importance.high,
                                              );

    var notificationDetails = NotificationDetails(
                              android: androidNotificationDetails,
                            );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      tz.TZDateTime.from(scheduleTime, tz.local), 
      //schedule the notification to show after 2 seconds.
      notificationDetails,
      // Type of time interpretation
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true, // To show notification even when the app is closed
    );

  }
}