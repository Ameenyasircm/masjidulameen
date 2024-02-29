import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../Providers/LoginProvider.dart';
import 'bottom_navigation_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      LoginProvider loginProvider =
      Provider.of<LoginProvider>(context, listen: false);
      FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser;


      if (user == null) {
        callNextReplacement(const LoginScreen(), context);
      } else {
        callNextReplacement(BottomNavigationScreen(), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(width: width,height: height,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/insta.png',scale: 15,)
        ],
      ),
    ),
    bottomNavigationBar: Container(
      // color: Colors.red,
      height: 100,
      width: 200,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('from'),
          Image.asset('assets/meta.png',scale: 20,)
        ],
      ),
    ),
    );

  }
}
