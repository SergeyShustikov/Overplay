import 'package:flutter/material.dart';
import 'package:overplay/constants/constants.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("App version: ${kVersionInfo.version}"),
        ),
      ],
    );
  }
}
