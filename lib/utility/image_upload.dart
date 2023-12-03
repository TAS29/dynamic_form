import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/constants/constants.dart';

class ImageUpload {
  uploadImage(field) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          print("Permission denied");
          return;
        }
      }
      final imagePicked = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagePicked == null) return;
      final path = await getApplicationDocumentsDirectory();
      final file = File(path.path + '/${field.metaInfo.savingFolder}/image.png');
      final byteData = await imagePicked.readAsBytes();
      await file.writeAsBytes(byteData);
      final res = await AwsS3.uploadFile(
        accessKey: access_key_id,
        secretKey: secret_access_key,
        file: File(file.path),
        bucket: bucket_name,
        region: aws_region,
      );
      field.metaInfo.mandatory = "no";
      print(res.toString());
      return res ?? "Access Denied While Uploading To S3";
    } catch (e) {
      print('Error saving image!');
      print(e.toString());
    }
  }
}
