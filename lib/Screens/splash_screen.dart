import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Screens/home_screen.dart';
import 'package:instagram_clone/Screens/loginscreen.dart';
import 'package:instagram_clone/constants/my_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/LoginProvider.dart';
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
    // LoginProvider loginProvider =
    // Provider.of<LoginProvider>(context, listen: false);
    Timer(const Duration(seconds: 3), () async {

      var user = prefs.getString("appwrite_token");
      if (user == null) {
        callNextReplacement(HomeScreen(loginPhone: '',type: '',), context);
      }else{
        mainProvider.userAuthorized(prefs.getString("phone_number").toString(), context, "",
            '', prefs.getString("password").toString());

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
                ),),SizedBox(height: 20,),
            Text("Masjidul Ameen \n Payyanad",textAlign: TextAlign.center,
                style: TextStyle( color: myblack.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,fontFamily: "Poppins"
                )

                )
          ],
        ),

    );
  }
}



