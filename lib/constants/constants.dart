import 'package:screen_retriever/screen_retriever.dart';

const double kLaunchScreenWidth = 480;
const double kLaunchScreenHeight = 800;

late VersionInfo kVersionInfo;
double kDisplayWidth = 0;
double kDisplayHeight = 0;
List<String> kAllowedExtensions = [".mp3"];

class VersionInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  VersionInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });
}
