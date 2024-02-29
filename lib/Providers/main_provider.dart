import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:instagram_clone/Constants/my_functions.dart';

import '../Screens/create_news_feed.dart';

class MainProvider extends ChangeNotifier{

  TextEditingController textData=TextEditingController();
  final ImagePicker picker = ImagePicker();
  String newPicekd='';
  File? fileimage;
  imageFromCamera(BuildContext context) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      // fileimage = File(pickedFile.path);
      cropImage(pickedFile.path, '',context);
      // newPicekd=pickedFile.path;
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileimage = File(response.file!.path);

      notifyListeners();
    }
  }
  imageFromGallery(BuildContext context) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      cropImage(pickedFile.path, '',context);

      newPicekd=pickedFile.path ;
      notifyListeners();
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }



  Future<void> cropImage(String path, String from,BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileimage = File(croppedFile.path);
      callNext(CreateNewsFeedScreen(), context);
      notifyListeners();
    }
    print("gggggggggggg666" + fileimage.toString());
  }
}