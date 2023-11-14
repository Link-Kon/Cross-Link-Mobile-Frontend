import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';
import '../../config/router/routes.dart';
import '../../presentation/cubits/wearable/wearable_cubit.dart';
import '../../presentation/cubits/wearable/wearable_state.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
  print('before notification background message');
  try {
    sendAlertToWearable(wearableCubitGlobal!);
  } catch (e) {
    print('error: $e');
  }

}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  WearableCubit wearableCubit = wearableCubitGlobal!;

  //FirebaseApi(this.wearableCubit);

  Future<String?> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint('Token: $fCMToken');
    initPushNotification();
    initLocalNotifications();
    return fCMToken;
  }

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print('before notification on app message');
    sendAlertToWearable(wearableCubit);
    navigatorKey.currentState?.pushNamed(
      Routes.HOME,
      arguments: message,
    );
  }
  
  Future<void> initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));
        print('before notification local notification');
        handleMessage(message);
      }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('before notification listen');
      handleMessage(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;

      sendAlertToWearable(wearableCubit);

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher' //TODO: obtain a logo for notifications
          ),
        ),
        payload: jsonEncode(message.data),
      );
    });
  }
}


//Wearable Notification:
void sendAlertToWearable(WearableCubit wearableCubit) {
  switch (wearableCubit.state.runtimeType) {
    case WearableLoading:
      debugPrint('WearableLoading');
      break;

    case WearableSuccess:
      if (wearableCubit.state.device == null) {
        debugPrint('No Active Wearable');

      } else {
        debugPrint('Send 1 to wearable');
        _writeWearable(wearableCubit, '1');

        Timer(const Duration(seconds: 15), () { //Duration of alert in wearable
          debugPrint('Send 0 to wearable');
          _writeWearable(wearableCubit, '0'); //Off lights
        });
      }
      break;
  }
}

Future<void> _writeWearable(WearableCubit wearableCubit, String info) async {
  List<BluetoothService> services = wearableCubit.state.device!.servicesList!;

  for (BluetoothService service in services) {
    if (service.serviceUuid.toString().toUpperCase() == '0000FFE0-0000-1000-8000-00805F9B34FB') {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.characteristicUuid.toString().toUpperCase() == '0000FFE2-0000-1000-8000-00805F9B34FB') {
          try {
            debugPrint('Send information to wearable');
            const asciiEncoder = AsciiEncoder();
            await characteristic.write(asciiEncoder.convert(info), withoutResponse: characteristic.properties.writeWithoutResponse);
            debugPrint('Success');
          } catch (e) {
            debugPrint("Error: $e");
          }
          break;
        }
      }
      break;
    }
  }
}