import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Constants/my_functions.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/main_provider.dart';
import 'bottom_navigation_screen.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;
  bool isHovering = false;


  Widget getMobileFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen:false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(height: height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(width: width,
                decoration: const BoxDecoration(
                    color: Colors.white ,
                    borderRadius: BorderRadius.all(Radius.circular(32))
                ),
                child: Column(
                  children: [
                    SizedBox(height: height*0.1,),

                    Image.asset('assets/Instagram_logo.png',scale: 2.5,),
                    SizedBox(height: height*0.07,),
                    InkWell(onTap: (){
                      callNextReplacement(BottomNavigationScreen(), context);
                    },
                      child: Container(
                          width: 330,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xff1877f2)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/facebuk.png',scale: 2.5,),
                            Text(
                                "Continue with Facebook",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 18, right: 18,top: 40),
                      child: Container(
                        width: width*0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: TextFormField(
                          controller: phoneController,
                          onChanged: (value) {
                            if (value.length == 10) {
                              showTick = true;
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            } else {
                              showTick = false;
                            }

                            setState(() {});
                          },
                          style:  TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Poppins"),
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          decoration: InputDecoration(
                            fillColor:  Color(0xffe8e6e6),
                            filled: true,
                            counterStyle: const TextStyle(color: Colors.grey),
                            hintStyle:   TextStyle(
                              color: Colors.black.withOpacity(0.4000000059604645),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'phone number or username',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:  BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:  BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:  BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          print(phoneController.text+' KMFLTKMGL');
                          db.collection('USERS').where('PHONE_NUMBER',isEqualTo: "${phoneController.text}").get().then((value) async {
                            if(value.docs.isNotEmpty){
                              setState(() {
                                if (phoneController.text.length == 10) {
                                  showLoading = true;
                                }
                              });
                              await auth.verifyPhoneNumber(
                                  phoneNumber: "+91${phoneController.text}",
                                  verificationCompleted:
                                      (phoneAuthCredential) async {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Verification Completed"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    if (kDebugMode) {}
                                  },
                                  verificationFailed:
                                      (verificationFailed) async {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text("Sorry, Verification Failed"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    if (kDebugMode) {
                                      print(verificationFailed.message.toString());
                                    }
                                  },
                                  codeSent:
                                      (verificationId, resendingToken) async {
                                    setState(() {
                                      showLoading = false;
                                      currentSate = MobileVarificationState
                                          .SHOW_OTP_FORM_STATE;
                                      this.verificationId = verificationId;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "OTP sent to phone successfully"),
                                        duration:
                                        Duration(milliseconds: 3000),
                                      ));

                                      if (kDebugMode) {
                                        print("");
                                      }
                                    });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (verificationId) async {});
                            }else{
                              const snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(milliseconds: 3000),
                                  content: Text("No user Found!",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          });

                        },
                        child: showLoading
                            ?  Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(
                              color: Colors.green,
                            )
                        )
                            :Container( width: width*0.8,
                          height: 35,
                          // width: 340,
                          margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                    color:  Color(0xff1877f2)
                          ),
                          child: const Center(
                            child: Text("Log in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "PoppinsMedium",
                                  letterSpacing: 0.39
                              ),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                SizedBox(
                  width: 218,
                  height: 29,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an account?',
                          style: TextStyle(
                            color: Color(0xFFAEA9A9),
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.30,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.30,
                          ),
                        ),
                        TextSpan(
                          text: 'sign up',
                          style: TextStyle(
                            color: Color(0xFF267FF3),
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ],
                    ),
                  ),),
                    SizedBox(height: height*0.06,),
                  ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }

  Widget getOtpFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(width: width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(32))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 80,),
                      Text('Login', style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),),
                      SizedBox(height: 20,),
                      SizedBox(width: width*0.5,
                        child: Align( alignment:Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65.0),
                            child: Text(
                              'Enter OTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 30
                        ),
                        child: Container(width: width*0.8,
                          height: 80,
                          // color: Colors.redAccent,
                          child: PinFieldAutoFill(
                            codeLength: 6,
                            focusNode: _pinPutFocusNode,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            controller: otpController,

                            currentCode: "",
                            // decoration: UnderlineDecoration(
                            //   colorBuilder: FixedColorBuilder(Colors.white)
                            // ),
                            decoration: BoxLooseDecoration(
                              bgColorBuilder: FixedColorBuilder(Colors.white),
                              textStyle:  TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
                              radius: const Radius.circular(17),
                              strokeColorBuilder:  FixedColorBuilder(Colors.white.withOpacity(0.5)),
                            ),
                            onCodeChanged: (pin) {
                              if (pin!.length == 6) {
                                PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: pin);
                                signInWithPhoneAuthCredential(
                                    context, phoneAuthCredential);
                                otpController.text = pin;
                                setState(() {
                                  Code = pin;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      Container(
                        height: 60,
                        // width: 340
                        // w,
                        width: width*0.38,
                        margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 30),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF096FB2), Color(0xFF004675)
                                ]
                            ),
                            borderRadius: BorderRadius.circular(18)
                        ),
                        child: const Center(
                          child: Text("Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                fontFamily: "PoppinsMedium",
                                letterSpacing: 0.39
                            ),),
                        ),
                      ),
                      showLoading
                          ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                          : Container(),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {
          callNextReplacement(BottomNavigationScreen(), context);


          // callNextReplacement(AdminHomeScreen(), context);

          if (kDebugMode) {
            print("Login SUccess");

          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
          backgroundColor: Colors.black,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(

          key: scaffoldKey,
          body: Container(
            child:
            currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
            // getMobileFormWidget
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
          )),
    );
  }
}
