import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:overplay/constants/constants.dart';
import 'package:overplay/widgets/player_view.dart';
import 'package:overplay/windows_manager/windows_manager.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class FolderPlayerScreen extends StatefulWidget {
  final String folderPath;
  const FolderPlayerScreen({super.key, required this.folderPath});

  @override
  State<FolderPlayerScreen> createState() => _FolderPlayerScreenState();
}

class _FolderPlayerScreenState extends State<FolderPlayerScreen> {
  List<io.FileSystemEntity> files = List.empty(growable: true);
  String _selectedTrack = "";
  @override
  void initState() {
    super.initState();
    setWindowOptions(this, const Size(1200, 800), title: 'Folder', maximizable: true);
    _lookupFiles(widget.folderPath);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // scrolledUnderElevation: 0.0,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      bottomNavigationBar: PlayerView.bar(_selectedTrack),
      body: Row(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                var filename = path.basename(files[index].path);
                return ListTile(
                  title: Text(filename),
                  onTap: () {
                    setState(() {
                      _selectedTrack = filename;
                    });
                  },
                );
              },
            ),
          ),
          Flexible(
              child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Text('data');
            },
          )),
        ],
      ),
    );
  }

  void _lookupFiles(String folderPath) {
    var allFiles = io.Directory(folderPath).listSync();
    var filtered = allFiles.where(
      (file) {
        bool isMedia = false;
        if (file.statSync().type == io.FileSystemEntityType.directory) {
          _lookupFiles(file.absolute.path);
        }
        for (var extensionString in kAllowedExtensions) {
          if (file.path.endsWith(extensionString)) return true;
        }
        return isMedia;
      },
    ).toList();
    filtered.sort(
      (a, b) {
        var basenameA = path.basename(a.path).substring(0, 2);
        var basenameB = path.basename(b.path).substring(0, 2);
        return compareNatural(basenameA, basenameB);
      },
    );
    files.addAll(filtered);
  }
}
