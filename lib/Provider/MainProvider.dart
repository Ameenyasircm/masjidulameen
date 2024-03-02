import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/update.dart';

class MainProvider extends ChangeNotifier{
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController nameCT = TextEditingController();
  TextEditingController phoneCT = TextEditingController();
  TextEditingController addressCT = TextEditingController();
  TextEditingController adharCT = TextEditingController();
  TextEditingController locationCT = TextEditingController();
  TextEditingController qualificationCT = TextEditingController();
  TextEditingController jobCT = TextEditingController();

  bool yesBool=false;
  bool noBool=false;

  void married(){
    yesBool=true;
    noBool=false;
    notifyListeners();
  }
  void unmarried(){
    yesBool=false;
    noBool=true;
    notifyListeners();
  }


  List<String> homeList=['Members Registration','Prayer Time'];
  MainProvider(){
    lockApp();
  }
  Future<void> lockApp() async {
    await mRootReference.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions =
        map[Platform.isAndroid ? 'APPVERSION' : 'IOSVERSION']
            .toString()
            .split(',');
        for (var ee in versions) {
          print("${ee}jvnfjvnjfvn");
        }
        for (var k in versions) {}
        if (!versions.contains(Platform.isAndroid ? appVersion : iOSVersion)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();

          runApp(MaterialApp(
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

}