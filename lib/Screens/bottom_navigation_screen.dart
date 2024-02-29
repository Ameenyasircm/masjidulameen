import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../Providers/main_provider.dart';
import 'home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  void _onItemTapped(int index) {
    setState(() {
      if(index==2){
        MainProvider mainProvider = Provider.of<MainProvider>(context,listen:false);
        mainProvider.fileimage=null;
        mainProvider.imageFromCamera(context);
      }
      selectedIndex = index;
    });
  }

  List<String> pageNames = ['Radio', 'Category', 'Home', 'Chat','Profile'];
  var screens = [ const HomeScreen(), const HomeScreen(), HomeScreen(),const HomeScreen()];

  int selectedIndex= 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: clBlack,
          items: [
          BottomNavigationBarItem(

              icon: Image.asset(
                'assets/home.png',
                height: 20,
                width: 20,
                color: Colors.black,
              ),
              activeIcon: Image.asset(
                'assets/home.png',
                height: 20,
                width: 20,
                color:clBlack,
              ),
              label: "",
              backgroundColor: my_white),
          BottomNavigationBarItem(


              icon: Image.asset(
                'assets/search.png',
                height: 20,
                width: 20,
                color: Colors.black,
              ),
              activeIcon: Image.asset(
                'assets/search.png',
                height: 20,
                width: 20,
                color:clBlack,
              ),
              label: "",
              backgroundColor: my_white),
          BottomNavigationBarItem(

              icon: Image.asset(
                'assets/addPost.png',
                height: 20,
                width: 20,
                color: Colors.black,
              ),
              activeIcon: Image.asset(
                'assets/addPost.png',
                height: 20,
                width: 20,
                color:clBlack,
              ),
              label: "",
              backgroundColor: my_white),
          BottomNavigationBarItem(

              icon: Image.asset(
                'assets/heart.png',
                height: 20,
                width: 20,
                color: Colors.black,
              ),
              activeIcon: Image.asset(
                'assets/heart.png',
                height: 20,
                width: 20,
                color:clBlack,
              ),
              label: "",
              backgroundColor: my_white),
        ],

        ),
      ),
    );
  }
}
