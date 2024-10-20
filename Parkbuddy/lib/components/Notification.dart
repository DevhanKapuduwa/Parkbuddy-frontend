import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  try{
    await requestNotificationPermission();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }catch(e){
    print("^^^!");
    print(e.toString());

  }

}

notificationDetails(){
  print("&*&*");
  return const NotificationDetails(
    android: AndroidNotificationDetails( "channelId", "channelName",importance: Importance.max,priority: Priority.high),

  );
}

Future showNotification({int id=0,String? title , String? body,String? payLoad}) async{
  return flutterLocalNotificationsPlugin.show(id, title, body, await notificationDetails());

}
