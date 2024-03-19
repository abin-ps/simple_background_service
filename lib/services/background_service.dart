import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BgService {
  //todo init background service
  Future<void> initBgService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(onBackground: onBackground, onForeground: onStart),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: false,
      ),
    );
  }

}


@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  //todo background running logic here


  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      print('app is now opened to foreground...');
      print('killing background service!');
    } else {
      print('app moves back to background...');
      print('start checking for notifications from backend.....');
      print('started.');
      Timer.periodic(const Duration(seconds: 5), (timer) {
        print('checking for new messages from backend...');
      });
    }

    // if(await service.)
  }

  service.invoke('update');
}

@pragma('vm:entry-point')
Future<bool> onBackground(ServiceInstance s) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return false;
}
