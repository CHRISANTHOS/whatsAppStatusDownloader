import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_native_api/flutter_native_api.dart';

class VideoPlay extends StatefulWidget {
  FileSystemEntity video;
  VideoPlay({super.key, required this.video});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  List<Widget> buttons = const [
    Icon(Icons.share),
    Icon(Icons.download),
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(
        File(widget.video.path),
      ),
      autoPlay: true,
      autoInitialize: true,
      looping: true,
      aspectRatio: 5/6,
      errorBuilder: ((context, errorMessage){
        return Center(child: Text(errorMessage),);
      })
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(controller: _chewieController!),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(buttons.length, (index) {
          return FloatingActionButton(
            heroTag: '$index',
            onPressed: () {
              switch (index) {
                case 0:
                  FlutterNativeApi.shareMultiple(widget.video.path, widget.video.path.split('/').last);
                  break;
                case 1:
                  ImageGallerySaver.saveFile(widget.video.path)
                      .then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Video saved')))
                  });
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
