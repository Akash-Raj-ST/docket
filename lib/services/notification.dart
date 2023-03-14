import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  void init() async {
    
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
                                  InitializationSettings(
                                      android: initializationSettingsAndroid, 
                                  );
  
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print("initialized");

    
  }


  Future showNotification(int id,String title,String body) async{

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
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }
}