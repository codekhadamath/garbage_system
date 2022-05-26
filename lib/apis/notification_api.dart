import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final onNotifications = BehaviorSubject<String?>();
  static final _notifications = FlutterLocalNotificationsPlugin();

  static AndroidNotificationChannel get _androidNotificationCannel =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

  static Future init({bool initScheduled = false}) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    _notifications.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        onNotifications.add(payload);
      }
    });
  }

  static Future getNotificationDetails({String? sound}) async =>
      NotificationDetails(
          android: AndroidNotificationDetails(
              _androidNotificationCannel.id, _androidNotificationCannel.name,
              channelDescription: _androidNotificationCannel.description,
              importance: _androidNotificationCannel.importance,
              priority: Priority.max,
              playSound: true,
              enableLights: true,
              usesChronometer: true,
              ticker: 'ticker',
              // additionalFlags: Int32List.fromList(<int>[4]), // for repeatedly play the sound
              category: 'alarm',),
          iOS: const IOSNotificationDetails());

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notifications.show(id, title, body, await getNotificationDetails(),
          payload: payload);

  static Future showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          String? sound,
          String? payload,
          required DateTime scheduleTime}) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduleTime, tz.local),
          await getNotificationDetails(sound: sound),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  static Future cancelNotification({required int id}) async {
    await _notifications.cancel(id);
  }
}
