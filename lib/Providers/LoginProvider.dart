import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Screens/bottom_navigation_screen.dart';

import '../Constants/my_functions.dart';
import '../Screens/home_screen.dart';


class LoginProvider extends ChangeNotifier{
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isTrue = false;


}