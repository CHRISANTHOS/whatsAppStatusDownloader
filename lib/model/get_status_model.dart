import 'dart:developer';
import 'dart:io';
import 'package:whatsapp_downloader/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetStatusModel extends ChangeNotifier{

  List<FileSystemEntity> _getWhatsappImages = [];
  List<FileSystemEntity> _getWhatsappVideos = [];
  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getImages => _getWhatsappImages;
  List<FileSystemEntity> get getVideos => _getWhatsappVideos;
  bool get isWhatsAppAvailable => _isWhatsAppAvailable;


  void getStatus(String fileExt)async{
    final permission = await Permission.storage.request();

    if(permission.isDenied){
      Permission.storage.request();
      log('Access Denied');
      return;
    }
    if(permission.isGranted){
      final directory = Directory(Constants.WHATSAPP_PATH);

      if(directory.existsSync()){
        final items = directory.listSync();
        log(items.toString());

        if(fileExt == '.jpg'){
          _getWhatsappImages = items.where((element) => element.path.endsWith('.jpg')).toList();
          notifyListeners();
        }else{
          _getWhatsappVideos = items.where((element) => element.path.endsWith('.mp4')).toList();
          notifyListeners();
        }
        _isWhatsAppAvailable = true;
        notifyListeners();
      }else{
        log('No Whatsapp found');
        _isWhatsAppAvailable = false;
        notifyListeners();
      }
    }
  }

}