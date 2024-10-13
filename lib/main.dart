import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:overplay/constants/constants.dart';
import 'package:overplay/screens/launch_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  var packageInfo = await PackageInfo.fromPlatform();

  kVersionInfo = VersionInfo(
    appName: packageInfo.appName,
    packageName: packageInfo.packageName,
    version: packageInfo.version,
    buildNumber: packageInfo.buildNumber,
  );
  var displays = await screenRetriever.getAllDisplays();
  for (var element in displays) {
    if (element.size.width > kDisplayWidth) {
      kDisplayWidth = element.size.width;
    }
    if (element.size.height > kDisplayHeight) {
      kDisplayHeight = element.size.height;
    }
  }
  WindowOptions windowOptions = const WindowOptions(
    size: Size(kLaunchScreenWidth, kLaunchScreenHeight),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setMaximizable(false);
    await windowManager.setMaximumSize(const Size(kLaunchScreenWidth, kLaunchScreenHeight));
    await windowManager.setMinimumSize(const Size(kLaunchScreenWidth, kLaunchScreenHeight));
    await windowManager.focus();
    await windowManager.setTitle('Overplay');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overplay',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const LaunchScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Show player',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
