import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  final String trackName;
  const PlayerView({super.key, required this.trackName});

  factory PlayerView.bar(String trackName) => PlayerView(trackName: trackName);

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 96,
        child: Column(
          children: [
            if (widget.trackName.isNotEmpty) Text('Currently playing: ${widget.trackName}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 44,
                  icon: _isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ));
  }
}
