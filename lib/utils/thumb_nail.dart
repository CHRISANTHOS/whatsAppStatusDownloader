import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> getThumbNail(String path)async{
  String? thumb = await VideoThumbnail.thumbnailFile(video: path);

  return thumb!;
}