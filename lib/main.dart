import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:simple_background_service/services/background_service.dart';
// import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ForegroundNotificationService().initBackgroundService();
  // await Permission.notification.isDenied.then((v) {
  //   if (v) {
  //     Permission.notification.request();
  //   }
  // });
  await BgService().initBgService();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final defaultTextStyle = const TextStyle(fontSize: 16);

  bool isServiceRunning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //start service button
            ElevatedButton.icon(
                onPressed: startService,
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text('Start Service', style: defaultTextStyle, overflow: TextOverflow.ellipsis)),
            //start foreground service button
            ElevatedButton.icon(
                onPressed: startForegroundService,
                icon: const Icon(Icons.move_down_rounded),
                label: Text('Start Foreground Service', style: defaultTextStyle, overflow: TextOverflow.ellipsis)),
            //stop service button
            ElevatedButton.icon(
                onPressed: startService,
                icon: const Icon(Icons.stop_rounded),
                label: Text(isServiceRunning ? 'Stop Service' : 'Start Service',
                    style: defaultTextStyle, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }

  void startService() {
    //todo logic to start service
    FlutterBackgroundService().invoke('setAsBackgroundService');
  }

  void startForegroundService() {
    //todo logic to start foreground service

    FlutterBackgroundService().invoke('setAsForegroundService');
  }

  void stopService() async {
    final service = FlutterBackgroundService();
    isServiceRunning = await service.isRunning();

    if (isServiceRunning) {
      service.invoke('stopService');
    } else {
      service.startService();
    }
    //todo logic to stop service
  }
}
