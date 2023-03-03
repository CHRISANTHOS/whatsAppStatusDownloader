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

    //Use this when implementing on Android <11
    // final permission = await Permission.storage.request();

    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();


    if(result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted){
      final directory = Directory(Constants.whatsAppPath);

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