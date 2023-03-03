import 'dart:io';

import 'package:flutter/material.dart';
import 'image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_downloader/model/get_status_model.dart';

class ImagePage extends StatefulWidget {
  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusModel>(builder: (context, file, child) {
        if (isFetched == false) {
          file.getStatus('.jpg');
          Future.delayed(const Duration(seconds: 2), () {
            isFetched = true;
          });
        }
        return file.isWhatsAppAvailable == false
            ? const Center(
                child: Text('No WhatsApp Available'),
              )
            : file.getImages.isEmpty
                ? const Center(
                    child: Text('No images found'),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      children: List.generate(file.getImages.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageView()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(file.getImages[index].path),
                                ),
                              ),
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
