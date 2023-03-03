import 'dart:developer';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';

class ImageView extends StatefulWidget {
  FileSystemEntity image;
  ImageView({super.key, required this.image});

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
      body: Expanded(
          child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              File(widget.image.path),
            ),
          ),
        ),
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(buttons.length, (index) {
          return FloatingActionButton(
            heroTag: '$index',
            onPressed: () {
              switch (index) {
                case 0:
                  log('share');
                  FlutterNativeApi.shareImage(widget.image.path);
                  break;
                case 1:
                  log('download');
                  ImageGallerySaver.saveFile(widget.image.path).then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image saved')))
                  });
                  break;
                case 2:
                  log('print');
                  FlutterNativeApi.printImage(widget.image.path, widget.image.path.split('/').last);
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
