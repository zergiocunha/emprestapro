import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      // Aqui você consulta seu banco
      // Ex: buscar se existem clientes com parcelas vencidas
      _notificationService.showLocalNotification(
        CustomNotification(
          id: 0,
          title: 'Parcelas Vencidas',
          body: 'Você tem parcelas vencidas!',
          payload: 'vencidas',
        ),
      );
      // Se encontrar, dispare uma notificação
      // usando flutter_local_notifications aqui.

      return Future.value(true);
    });
  }

  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true, // true apenas para teste
    );
    Workmanager().registerPeriodicTask(
      "uniqueTaskId",
      "checkExpiredLoans",
      frequency: const Duration(hours: 24), // roda 1 vez por dia
      initialDelay: Duration(hours: timeUntilNext5Minutes()),
    );
    // final notificationSettings =
    //     await FirebaseMessaging.instance.requestPermission(provisional: true);
    // if (notificationSettings.authorizationStatus ==
    //     AuthorizationStatus.authorized) {
    //   await FirebaseMessaging.instance
    //       .setForegroundNotificationPresentationOptions(
    //     badge: true,
    //     sound: true,
    //     alert: true,
    //   );
    //   getDeviceFirebaseToken();
    //   _onMessage();
    //   _onMessageOpenedApp();
    // } else if (notificationSettings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   debugPrint('User granted provisional permission');
    // } else {
    //   debugPrint('User declined or has not accepted permission');
    // }
  }

  int timeUntilEleven() {
    final now = DateTime.now();
    final eleven = DateTime(now.year, now.month, now.day, 11);
    if (now.isAfter(eleven)) {
      return eleven.add(const Duration(days: 1)).difference(now).inHours;
    }
    return eleven.difference(now).inHours;
  }

  int timeUntilNext5Minutes() {
    final now = DateTime.now();
    final next = now
        .add(Duration(minutes: 5 - now.minute % 5))
        .copyWith(second: 0, millisecond: 0, microsecond: 0);
    return next.difference(now).inMinutes;
  }
  //   // await FirebaseMessaging.instance
  //   //     .setForegroundNotificationPresentationOptions(
  //   //   badge: true,
  //   //   sound: true,
  //   //   alert: true,
  //   // );
  //   // getDeviceFirebaseToken();
  //   // _onMessage();
  //   // _onMessageOpenedApp();
  // }

  // getDeviceFirebaseToken() async {
  //   final token = await FirebaseMessaging.instance.getToken();
  //   debugPrint('=======================================');
  //   debugPrint('TOKEN: $token');
  //   debugPrint('=======================================');
  // }

  // _onMessage() {
  //   FirebaseMessaging.onMessage.listen((message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;

  //     if (notification != null && android != null) {
  //       _notificationService.showLocalNotification(
  //         CustomNotification(
  //           id: android.hashCode,
  //           title: notification.title!,
  //           body: notification.body!,
  //           payload: message.data['route'] ?? '',
  //         ),
  //       );
  //     }
  //   });
  // }

  // _onMessageOpenedApp() {
  //   FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  // }

  // _goToPageAfterMessage(message) {
  //   final String route = message.data['route'] ?? '';
  //   // if (route.isNotEmpty) {
  //   //   Routes.navigatorKey?.currentState?.pushNamed(route);
  //   // }
  // }
}
