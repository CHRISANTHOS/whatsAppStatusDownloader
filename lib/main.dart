import 'package:flutter/material.dart';
import 'package:whatsapp_downloader/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_downloader/model/bottom_nav_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavModel())
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
