import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainProvider.dart';

class LoginProvider extends ChangeNotifier {

  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? packageName;

  LoginProvider() {
  }

  Future<void> userAuthorized(String? phoneNumber, BuildContext context,
      String from, var token) async {
    print(phoneNumber.toString() + ' DIWOJDIOJD');
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);

    db.collection("USERS").where(
        "PHONE_NUMBER", isEqualTo: '+91' + phoneNumber.toString()).get().then((
        value) async {
      if (value.docs.isNotEmpty) {
        if (from == "LOGIN") {
          print('kasokaodsk');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('appwrite_token', token);
          prefs.setString('phone_number', phoneNumber!);
        }
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String name = map['NAME'].toString();
          String id = element.id;
          String phone = map['PHONE_NUMBER'].toString();
          String type = map['TYPE'].toString();
          String image = map['IMAGE'] ?? "";
          String address = map['ADDRESS'] ?? "";


          print(packageName.toString() + ' ' + map['TYPE'].toString() +
              ' FRIJFRF');
          if (packageName.toString() == 'com.spine.rbsAdmin') {
            print(id + 'LSALDMLASD');

            if (map['TYPE'].toString() == 'ADMIN') {
              print(id + 'iddddddddddddddddd');
            }
            else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("NO Admin Found in this Number"),
                duration: Duration(milliseconds: 3000),
              ));
            }
          }
        }
      }
    });
  }
}