import 'dart:developer';

import 'package:flutter/material.dart';

class VideoPlay extends StatefulWidget {
  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  List<Widget> buttons = const [
    Icon(Icons.share),
    Icon(Icons.download),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(buttons.length, (index) {
          return FloatingActionButton(
            heroTag: '$index',
            onPressed: () {
              switch (index) {
                case 0:
                  log('share');
                  break;
                case 1:
                  log('download');
                  break;
              }
            },
            child: buttons[index],
          );
        }),
      ),
    );
  }
}
