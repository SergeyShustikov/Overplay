// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:overplay/constants/constants.dart';
import 'package:window_manager/window_manager.dart';

Future<void> setWindowOptions(State state, Size size, {String? title, bool maximizable = false}) async {
  WindowOptions windowOptions = WindowOptions(
    // size: size,
    maximumSize: Size(kDisplayWidth, kDisplayHeight),
    minimumSize: const Size(kLaunchScreenWidth, kLaunchScreenHeight),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: title,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    state.setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      // if (Theme.of(context).platform != TargetPlatform.windows) return;
      await windowManager.setMaximizable(maximizable);
      await windowManager.setResizable(maximizable);
      if (title != null) await windowManager.setTitle(title);
      await windowManager.setSize(size, animate: true);
    });
  });
}
