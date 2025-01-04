import 'dart:convert';

import 'package:rxdart/subjects.dart';

import '../imports.dart';

final localNotificationStream =
    BehaviorSubject<Map<String, dynamic>>.seeded({});

Stream<Map<String, dynamic>> get getLocalNotificationStream =>
    localNotificationStream.stream;

class NotificationService {
  NotificationService();

  static Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        onDidReceiveLocalNotification(
          id,
          title,
          body,
          payload,
        );
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    // FlutterLocalNotificationsPlugin()
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .requestNotificationsPermission();
    if (defaultTargetPlatform == TargetPlatform.android) {
      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        if (response.payload != null) {
          Map<String, dynamic> map = jsonDecode(response.payload!);
          localNotificationStream.add(map);
        }
      },
      onDidReceiveBackgroundNotificationResponse: (response) async {
        if (response.payload != null) {
          final map = jsonDecode(response.payload!);
          localNotificationStream.add(map);
        }
      },
    );
  }

  static void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    // if (payload != null) {
    //   final map = jsonDecode(payload!);
    //   if (map["page"].contains("individual_messages") &&
    //       (IndividualMessagesWebSocketClient().webSocketClient?.isActive ??
    //           false)) {
    //     IndividualMessagesWebSocketClient().webSocketClient?.deactivate();
    //   }
    //   localNotificationStream.add(map);
    // }
  }

  // void showNotification(RemoteMessage message) {
  //   const NotificationDetails notiDetails = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'ru.enigma.enigma_mobile',
  //       'push_notification',
  //       icon: '@mipmap/ic_launcher',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ),
  //   );
  //   FlutterLocalNotificationsPlugin().show(
  //     DateTime.now().microsecond,
  //     message.notification!.title,
  //     message.notification!.body,
  //     notiDetails,
  //     payload: message.data.toString(),
  //   );
  // }
}
