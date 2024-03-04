import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Models/MemberModel.dart';
import '../Screens/home_screen.dart';
import '../constants/my_functions.dart';
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

  bool clearBool=false;
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

  clr(){
    clear();
    clearBool=true;
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


  List<String> homeList=['Members Registration','Prayer Time','Qibla'];
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

  Future<void> userAuthorized(String? phoneNumber, BuildContext context,
      String from, var token,String password) async {
    print(phoneNumber.toString() + ' DIWOJDIOJD');

    db.collection("USERS").where(
        "PHONE_NUMBER", isEqualTo: '+91' + phoneNumber.toString()).get().then((
        value) async {
      if (value.docs.isNotEmpty) {

        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          if (from == "LOGIN") {
            print('kasokaodsk');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('appwrite_token', token);
            prefs.setString('phone_number', phoneNumber!);
            prefs.setString('password', password!);
            prefs.setString('type',  map['TYPE'].toString()!);
          }
          String name = map['NAME'].toString();
          String id = element.id;
          String phone = map['PHONE_NUMBER'].toString();
          if(password==map['PASSWORD']){
            callNextReplacement(HomeScreen(loginPhone: phone,type: map['TYPE'],), context);
          }else{
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(backgroundColor: Colors.red,
              content: Center(child: Text("NO Admin Found in this Number",style: TextStyle(color: Colors.white),)),
              duration: Duration(milliseconds: 3000),
            ));
          }
        }
      }
    });
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


  Future<void> fetchWithNo(String id) async {
    db.collection('MEMEBRS').doc(id).get().then((value){
      if(value.exists){
          Map<dynamic,dynamic> map=value.data() as Map;
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
  
  List<MemberModel> memebrsList=[];
  void fetchMembersList(){
    print('FNRJRFF KRFN');
    memebrsList.clear();
    db.collection('MEMEBRS').orderBy('ADDED_TIME',descending: true).get().then((value){
      if(value.docs.isNotEmpty){
        memebrsList.clear();
        for(var elements in value.docs){
          Map<dynamic,dynamic> map = elements.data() as Map;
          memebrsList.add(MemberModel(elements.id, map['NAME'].toString(), map['PHONE'].toString()));
          print(memebrsList.length.toString()+' FJRR');
          notifyListeners();
        }
      }
    });
  }

}