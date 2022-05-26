import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbage_system/apis/notification_api.dart';
import 'package:garbage_system/services/firestore_service.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  Map<String, dynamic> data = message.data;
  print(message);
  //if (data['type'] == 'order') {
  // Navigator.pushNamed(context, '/order_detail',
  //     arguments: data['orderId']);
  // NotificationApi.showNotification(
  //     title: 'Firebase', body: 'Messaging', payload: 'message.notification');
  //}
  NotificationApi.showNotification(id: Random().nextInt(100),
          title: message.notification?.title, body: message.notification?.body);
}

class NotificationService {
  /// We want singelton object of ``NotificationService`` so create private constructor
  /// Use NotificationService as ``NotificationService.instance``
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// ``NotificationService`` started or not.
  /// to start ``NotificationService`` call start method
  bool _started = false;
  late Stream<String> _tokenStream;

  /// Call this method on startup
  /// This method will initialise notification settings
  void start() {
    if (!_started) {
      _integrateNotification();
      _started = true;
      print('started');
    }
  }

  // Call this method to initialize notification

  void _integrateNotification() {
    _registerNotification();
    _initializeLocalNotification();
  }

  /// initialize firebase_messaging plugin
  void _registerNotification() {
    _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    /// App in foreground -> [onMessage] callback will be called
    /// App terminated -> Notification is delivered to system tray. When the user clicks on it to open app [onLaunch] fires
    /// App in background -> Notification is delivered to system tray. When the user clicks on it to open app [onResume] fires
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BLHrSvQPKxUI4n1UIsE7tA8ihDvtBnPPavD1ug-dYG__dAFzyT9tXK6Jw5NiHP5Uubdecsip4Ros9niYT19dVsI')
        .then(setToken);
    _tokenStream = _firebaseMessaging.onTokenRefresh;
    _tokenStream.listen(setToken, onError: _tokenRefreshFailure);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationApi.showNotification(id: Random().nextInt(100),
          title: message.notification?.title, body: message.notification?.body);
    });
  }

  /// Token refresh failure
  void _tokenRefreshFailure(error) {
    debugPrint("FCM token refresh failed with error $error");
  }

  setToken(String? token) async {
    // if (AuthService.currentUser == null) {
    //   return;
    // }

    final ref = FirestoreService.userRef;

    if (ref == null) return;

    final tokenRef = ref.collection('tokens').doc(token);

    tokenRef.set({
      'token': token ?? '',
      'createdAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem, // Platform.operatingSystem
    });
  }

  /// initialize flutter_local_notification plugin
  void _initializeLocalNotification() async {
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
