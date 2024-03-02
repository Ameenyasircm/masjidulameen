import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/loginscreen.dart';
import 'package:instagram_clone/constants/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/MainProvider.dart';
import '../constants/my_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  late SharedPreferences prefs;
  String? packageName;
  Future<void> localDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);
    mainProvider.lockApp();

    localDB();

    Timer(const Duration(seconds: 3), () async {
      var user = prefs.getString("appwrite_token");
      if (user == null) {
        callNextReplacement(LoginScreen(from: "", vId: ""), context);
      }else{


      }


    });
  }



  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child:     Image.asset(
                  "assets/masjid1.png",
                  width: 150,
                  height: 150,color: searchBartext,
                ),),
          ],
        ),

    );
  }
}



