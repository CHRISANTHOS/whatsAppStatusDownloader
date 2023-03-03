import 'dart:io';
import 'package:launch_review/launch_review.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetStatusModel>(context, listen: false).getStatus('.jpg');
  }
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
            ? SafeArea(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No WhatsApp Available'),
                      TextButton(
                        onPressed: () {
                          LaunchReview.launch(androidAppId: 'com.whatsapp');
                        },
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                        child: const Text('Download now', style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                ),
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
                                    builder: (context) => ImageView(
                                          image: file.getImages[index],
                                        )));
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
