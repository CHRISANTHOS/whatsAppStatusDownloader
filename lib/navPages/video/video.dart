import 'dart:io';

import 'package:flutter/material.dart';
import 'video_play.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_downloader/model/get_status_model.dart';

class VideoPage extends StatefulWidget {
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusModel>(builder: (context, file, child) {
        if (isFetched == false) {
          file.getStatus('.mp4');
          Future.delayed(Duration(seconds: 2), () {
            isFetched = true;
          });
        }
        return file.isWhatsAppAvailable == false
            ? const Center(
                child: Text('No Whatsapp Available'),
              )
            : file.getVideos.isEmpty
                ? const Center(
                    child: Text('No Videos'),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      children: List.generate(file.getVideos.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPlay()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
      }),
    );
  }
}
