// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class ForegroundNotificationService {
//   //notification channel
//   static const String notificationChannelId = "simple_test_channel";

//   int notificationId = 1;

//   initBackgroundService() async {
//     final service = FlutterBackgroundService();

//     const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
//       notificationChannelId,
//       "Simple Test Notification Channel Id",
//       importance: Importance.low,
//     );

//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(androidNotificationChannel);

//     await service.configure(
//         iosConfiguration: IosConfiguration(),
//         androidConfiguration: AndroidConfiguration(
//           // this will be executed when app is in foreground or background in separated isolate
//           onStart: onStart,

//           // auto start service
//           autoStart: true,
//           isForegroundMode: true,

//           notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
//           initialNotificationTitle: 'AWESOME SERVICE',
//           initialNotificationContent: 'Initializing',
//           foregroundServiceNotificationId: notificationId,
//         ));
//   }

//   // onStart(ServiceInstance s) {}
//   @pragma('vm:entry-point')
//   Future<void> onStart(ServiceInstance service) async {
//     // Only available for flutter 3.0.0 and later
//     DartPluginRegistrant.ensureInitialized();

//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     // bring to foreground
//     Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (service is AndroidServiceInstance) {
//         if (await service.isForegroundService()) {
//           flutterLocalNotificationsPlugin.show(
//             notificationId,
//             'COOL SERVICE',
//             'Awesome ${DateTime.now()}',
//             const NotificationDetails(
//               android: AndroidNotificationDetails(
//                 notificationChannelId,
//                 'MY FOREGROUND SERVICE',
//                 // icon: 'ic_bg_service_small',
//                 ongoing: true,
//               ),
//             ),
//           );
//         }
//       }
//     });
//   }
// }
