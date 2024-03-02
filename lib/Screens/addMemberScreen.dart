import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/MainProvider.dart';
import '../constants/my_colors.dart';
class AddMemberScreen extends StatelessWidget {
   AddMemberScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: InkWell(onTap: (){
          final FormState? form = _formKey.currentState;
          if (form!.validate()) {

          }

        },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 324,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [
                    searchBartext,
                    searchBartext2,
                  ],
                )),
            child: Text(
              'Save',
              style: const TextStyle(
                  color: clFFFFFF,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: InkWell(onTap: (){
        //   finish(context);
        // },
        //   child: const Icon(
        //     Icons.arrow_back_ios,
        //     color: clBlack,
        //     size: 18,
        //   ),
        // ),
        centerTitle: true,
        title: const Text(
          "Registration Form",
          style: TextStyle(
            color: clBlack,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        controller: value.nameCT,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please Enter Name";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 15,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        controller: value.phoneCT,
                        textAlign: TextAlign.start,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Phone Number',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please Enter Phone Number";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 15,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        controller: value.locationCT,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'Location',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Location',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please Enter Location";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 15,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        controller: value.addressCT,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'Address',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Address',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please Enter Address";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 15,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Maritial Status',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          Consumer<MainProvider>(
                              builder: (context, value1,
                                  child) {
                                return Checkbox(
                                  activeColor: const Color(
                                      0xFF3E4FA3),
                                  // shape:
                                  // const CircleBorder(),
                                  checkColor: Colors.white,
                                  value: value1.yesBool,
                                  side: const BorderSide(
                                      color: Colors.black,
                                      width: 2),
                                  onChanged: (bool? value) {
                                    value1.married();
                                  },
                                );
                              }),
                          Text('Married',style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Poppins',fontSize: 15))
                        ],),
                        Row(children: [
                          Consumer<MainProvider>(
                              builder: (context, value1,
                                  child) {
                                return Checkbox(
                                  activeColor: const Color(
                                      0xFF3E4FA3),
                                  // shape:
                                  // const CircleBorder(),
                                  checkColor: Colors.white,
                                  value: value1.noBool,
                                  side: const BorderSide(
                                      color: Colors.black,
                                      width: 2),
                                  onChanged: (bool? value) {
                                    value1.unmarried();
                                  },
                                );
                              }),
                          Text('UnMarried',style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Poppins',fontSize: 15))
                        ],),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        controller: value.adharCT,
                        maxLength: 12,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          counterText: '',
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'AdharNumber',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Adhar Number',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please Enter AdharNumber";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 15,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        // controller: value.subplanNameCT,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'Education Qualification',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Education Qualification',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Education Qualification";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 15,),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.05),
                            blurRadius: 11.76,
                            offset: Offset(0, 3.9),
                            spreadRadius: 0,
                          )
                        ]),
                    child:
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return TextFormField(
                        // controller: value.subplanNameCT,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          // prefixIcon: Image.asset(
                          //   'assets/TickIcon.png',
                          //   scale: 1.5,
                          // ),
                          labelText: 'Job',
                          labelStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Job',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: gray,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please Enter Job";
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  );
                }),
                SizedBox(height: 150,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
final OutlineInputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.white, width: 1.0),
  borderRadius: BorderRadius.circular(20),
);