import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> sfCreateProfilePicture(File file) async {
  var newImage = img.decodeImage(file.readAsBytesSync()) as img.Image;
  newImage = img.copyCrop(newImage, (newImage.height * 0.9).toInt(), 0,
      newImage.width, newImage.height);

  var dir = (await getExternalStorageDirectory());
  File croppedFile = File(join(dir!.path, 'profile_picture.jpg'));
  if (await croppedFile.exists()) {
    await croppedFile.delete();
  }
  croppedFile.createSync(recursive: true);
  await croppedFile.writeAsBytes(img.encodeJpg(newImage), flush: true);
}
