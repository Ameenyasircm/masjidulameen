import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:instagram_clone/Providers/main_provider.dart';
import 'package:provider/provider.dart';

class CreateNewsFeedScreen extends StatelessWidget {
  const CreateNewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              'Share',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Consumer<MainProvider>(builder: (context, value, child) {
                  return value.fileimage != null
                      ? Container(
                          height: 70,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(fit: BoxFit.cover,
                                image: FileImage(value.fileimage!)),
                            color: Colors.red,
                          ),
                        )
                      : Container(
                          height: 70,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        );
                }),
                Container(
                  width: width * 0.7,
                  // height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      Consumer<MainProvider>(builder: (context, value, child) {
                    return TextFormField(
                      maxLines: 3,
                      controller: value.textData,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterStyle: const TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4000000059604645),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Write a caption',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text('Add Location'),
            SizedBox(
              height: 20,
            ),
            Text('Tag People'),
            SizedBox(
              height: 20,
            ),
            Text('Add Music'),
            SizedBox(
              height: 20,
            ),
            Text('Post to ither instagram accounts'),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Share to Facebook'),
                FlutterSwitch(
                    activeColor: Colors.blueAccent,
                    width: 40,
                    height: 25.0,
                    valueFontSize: 20.0,
                    toggleSize: 20.0,
                    value: true,
                    borderRadius: 30.0,
                    padding: 2,
                    showOnOff: false,
                    onToggle: (val) {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
