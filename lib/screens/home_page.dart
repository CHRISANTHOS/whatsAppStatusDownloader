import 'package:flutter/material.dart';
import 'package:whatsapp_downloader/navPages/image/images.dart';
import 'package:whatsapp_downloader/navPages/video/video.dart';
import 'package:whatsapp_downloader/model/bottom_nav_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> pages = [ImagePage(), VideoPage()];
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavModel>(
      builder: (context, nav, child) {
        return Scaffold(
          body: pages[nav.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              items: const[
                BottomNavigationBarItem(icon: Icon(Icons.image), label: 'image'),
                BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'video'),
              ],
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            currentIndex: nav.currentIndex,
            onTap: (value){
              nav.changeIndex(value);
            },
          ),
        );
      }
    );
  }
}
