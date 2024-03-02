import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../constants/strings.dart';
import '../constants/update.dart';

class MainProvider extends ChangeNotifier{
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController nameCT = TextEditingController();
  TextEditingController phoneCT = TextEditingController();
  TextEditingController addressCT = TextEditingController();
  TextEditingController adharCT = TextEditingController();
  TextEditingController educationCT = TextEditingController();
  TextEditingController kidsCountCT = TextEditingController();
  TextEditingController locationCT = TextEditingController();
  TextEditingController qualificationCT = TextEditingController();
  TextEditingController jobCT = TextEditingController();

  bool yesBool=false;
  bool noBool=false;

  void clear(){
    nameCT.clear();
    phoneCT.clear();
    addressCT.clear();
    adharCT.clear();
    educationCT.clear();
    kidsCountCT.clear();
    locationCT.clear();
    qualificationCT.clear();
    jobCT.clear();
    yesBool=false;
    noBool=false;
    notifyListeners();
  }

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


  Future<void> addNewMember() async {
    print('FHURFR');
    HashMap<String,Object> map=HashMap();
    String key=DateTime.now().millisecondsSinceEpoch.toString();
    map['NAME']=nameCT.text;
    map['ID']=key;
    map['PHONE']=phoneCT.text;
    map['LOCATION']=locationCT.text;
    map['ADDRESS']=addressCT.text;
    map['NO_OF_KIDS']=kidsCountCT.text;
    map['ADHAR NO']=adharCT.text;
    map['EDUCATION']=educationCT.text;
    map['JOB']=jobCT.text;
    if(yesBool){
      map['MARRIED']='YES';
    }else{
      map['MARRIED']='no';
    }
    map['ADDED_TIME']=DateTime.now();
    map['ADDED_TIME_Millis']=DateTime.now().millisecondsSinceEpoch.toString();
    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    map['DEVICE_ID']=strDeviceID.toString();

    db.collection('MEMEBRS').doc(key).set(map,SetOptions(merge: true));

  }
  
  
  Future<void> fetch() async {
    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    db.collection('MEMEBRS').where('DEVICE_ID',isEqualTo: strDeviceID).get().then((value){
      if(value.docs.isNotEmpty){
        for(var elemets in value.docs){
          Map<dynamic,dynamic> map=elemets.data() as Map;
         nameCT.text= map['NAME'];
          phoneCT.text=map['PHONE'];
          locationCT.text= map['LOCATION'];
          addressCT.text=map['ADDRESS'];
          kidsCountCT.text=map['NO_OF_KIDS'];
          adharCT.text=map['ADHAR NO'];
          educationCT.text= map['EDUCATION'];
          jobCT.text=map['JOB'];
          if(map['MARRIED']=='YES'){
            yesBool=true;
            noBool=false;
          }else{
            yesBool=false;
            noBool=true;
          }
          notifyListeners();

        }
      }
    });
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