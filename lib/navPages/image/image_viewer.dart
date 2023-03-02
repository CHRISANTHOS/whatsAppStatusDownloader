import 'dart:developer';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttons = const [
    Icon(Icons.share),
    Icon(Icons.download),
    Icon(Icons.print)
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
                case 2:
                  log('print');
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
