import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/main.dart';

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
      final directory = await getTemporaryDirectory();
    final polarisFolder = Directory('${directory.path}/${field.metaInfo.savingFolder}');

    // Create 'polaris' folder if it doesn't exist
    if (!(await polarisFolder.exists())) {
      await polarisFolder.create(recursive: true);
    }

    final file = File('${polarisFolder.path}/image.png');
    final byteData = await imagePicked.readAsBytes();
  
      await file.writeAsBytes(byteData);
      final res = await AwsS3.uploadFile(
        accessKey: access_key_id,
        secretKey: secret_access_key,
        file: File(file.path),
        bucket: bucket_name,
        region: aws_region,
      );
      showImageDialog(File(file.path));
      field.metaInfo.mandatory = "no";
      print(res.toString());
      return res ?? "Access Denied While Uploading To S3";
    } catch (e) {
      print('Error saving image!');
      print(e.toString());
    }
  }
}

void showImageDialog(image) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Camera Image Dialog'),
          content: Container(
            height: 200.0,
            width: 200.0,
            child: image != null
                ? Image.file(image!, fit: BoxFit.cover)
                : Text('No Image'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

