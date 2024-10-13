import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:overplay/constants/constants.dart';
import 'package:overplay/screens/folder_player_screen.dart';
import 'package:overplay/widgets/version_widget.dart';
import 'package:overplay/windows_manager/windows_manager.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('_LaunchScreenState didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant LaunchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('_LaunchScreenState didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('Choose folder on device'),
              onPressed: () async {
                String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

                if (selectedDirectory == null) {
                  // User canceled the picker
                  debugPrint("User canceled selection");
                } else {
                  debugPrint("Selected dir = $selectedDirectory");
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FolderPlayerScreen(folderPath: selectedDirectory),
                    ));
                    setWindowOptions(this, const Size(kLaunchScreenWidth, kLaunchScreenHeight), title: 'Overlay');
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            const ElevatedButton(
              onPressed: null,
              child: Text('Play from Youtube Music'),
            ),
            const Spacer(),
            const VersionWidget(),
          ],
        ),
      ),
    );
  }
}
