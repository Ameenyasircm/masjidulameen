import 'package:instagram_clone/constants/my_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Provider/LoginProvider.dart';
import '../Provider/MainProvider.dart';
import '../constants/my_colors.dart';
import 'home_screen.dart';

enum MobileVarificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }

class LoginScreen extends StatefulWidget {
  String from;
  String vId;
  LoginScreen({super.key, required this.from, required this.vId});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? packageName;
  TextEditingController phoneNumberCT = TextEditingController();
  TextEditingController countryCodeCT = TextEditingController();
  TextEditingController otpNumberCT = TextEditingController();
  TextEditingController passwordCT = TextEditingController();
  LoginProvider loginProvider = LoginProvider();

  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String flagUri = "";
  String selectedCountryCode = "";
  bool showLoading = false;
  MainProvider mainProvider = MainProvider();
  Client client = Client();
  String VerificationId = "";
  late var tocken;

  void changeCountryCoe(String flag, String code) {
    setState(() {
      flagUri = flag;
      selectedCountryCode = code;
    });
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    print("${packageName}  packagenameee");
    setState(() {});
  }

  Future<void> otpsend() async {
    setState(() {
      showLoading = true;
    });

    print(phoneNumberCT.text + "qwertgfds");
    db
        .collection("USERS")
        .where("PHONE_NUMBER", isEqualTo: '+91' + phoneNumberCT.text)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        // otpsend();
        final account = Account(client);
        try {
          final sessionToken = await account.createPhoneSession(
              userId: ID.unique(),
              phone: '$selectedCountryCode${phoneNumberCT.text}');

          VerificationId = sessionToken.userId;
          tocken = sessionToken.$id;

          setState(() {
            showLoading = false;
            currentSate = MobileVarificationState.SHOW_OTP_FORM_STATE;

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("OTP sent to phone successfully"),
              duration: Duration(milliseconds: 3000),
            ));
          });

          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(
          //   content: Text("Verification Completed"),
          //   duration: Duration(milliseconds: 3000),
          // ));
        } catch (e) {
          if (e is AppwriteException) {
            setState(() {
              showLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Sorry, Verification Failed " + e.toString()),
              duration: const Duration(milliseconds: 3000),
            ));
          } else {
            setState(() {
              showLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Sorry, Verification Failed"),
              duration: Duration(milliseconds: 3000),
            ));
            // Handle other types of exceptions or errors
            print('An unexpected error occurred: $e');
          }
        }
      } else {
        setState(() {
          showLoading = false;
        });
        const snackBar = SnackBar(
          content: Text('No Access,Register Now'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<void> verify() async {
    setState(() {
      showLoading = true;
    });
    final account = Account(client);
    try {
      final session = await account.updatePhoneSession(
          userId: VerificationId, secret: otpNumberCT.text);

      try {
        loginProvider.userAuthorized(phoneNumberCT.text, context, "LOGIN", tocken,'');
      } catch (e) {
        print(e.toString() + 'jepkslkds');
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("login successfully"),
      //     backgroundColor: Colors.purple,
      //   ),
      // );
      // Process the successful response if needed
    } catch (e) {
      if (e is AppwriteException) {
        // Handle AppwriteException
        final errorMessage = e.message ?? 'An error occurred.';

        // Display the error message using a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.purple,
          ),
        );
      } else {
        // Handle other types of exceptions or errors
        print('An unexpected error occurred: $e');
      }
    }

    // print(session.userId.toString()+"dsc");

    // print(session.providerAccessToken+"789456");
  }

  List<String> fixedOtpList = [];

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  void fixedOtpChecking() {
    fixedOtpList.clear();

    setState(() {
      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if (databaseEvent.snapshot.exists) {
          print("object");
          fixedOtpList.clear();
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            print("va${value}df${key}");
            fixedOtpList.add(key.toString());
          });

          print(fixedOtpList.toString() + "ef");
          print(fixedOtpList.contains("9048001001"));
        }
      });
    });
  }

  void checkValueForKey(String targetKey, String pin) {
    setState(() {
      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if (databaseEvent.snapshot.exists) {
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            String keyControllerValue = key.toString();
            String valueControllerValue = value.toString();

            if (keyControllerValue == targetKey) {
              // The targetKey exists in the database
              // Do something with the corresponding value
              print("Value for key $targetKey is $valueControllerValue");

              if (valueControllerValue == pin) {
                LoginProvider loginProvider =
                    Provider.of<LoginProvider>(context, listen: false);

                loginProvider.userAuthorized(
                    phoneNumberCT.text, context, "LOGIN", '','');
                // callNextReplacement(HomeScreen(), context);
              }
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    getPackageName();
    if (widget.from == "REGISTER") {
      currentSate = MobileVarificationState.SHOW_OTP_FORM_STATE;
      VerificationId = widget.vId;
    }

    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('65c4920210d9a3d7d3ee') // Your project ID
        .setSelfSigned();
    super.initState();

    fixedOtpChecking();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final FocusNode _pinPutFocusNode = FocusNode();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: clWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: InkWell(
          onTap: () {
            setState(() {
              if (phoneNumberCT.text.length == 10 &&
                  passwordCT.text.length == 6) {
              loginProvider.userAuthorized(phoneNumberCT.text, context, 'LOGIN', '',passwordCT.text);
              }
            });

              // callNextReplacement(HomeScreen(), context);
            //   if (currentSate ==
            //       MobileVarificationState.SHOW_MOBILE_FORM_STATE) {
            //     if (fixedOtpList.contains(phoneNumberCT.text.toString())) {
            //       setState(() {
            //         currentSate = MobileVarificationState.SHOW_OTP_FORM_STATE;
            //       });
            //     } else {
            //       otpsend();
            //     }
            //   } else {
            //     if (fixedOtpList.contains(phoneNumberCT.text)) {
            //       checkValueForKey(phoneNumberCT.text.toString(),
            //           otpNumberCT.text.toString());
            //     } else {
            //       verify();
            //     }
            //   }
            // });
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
              // currentSate == MobileVarificationState.SHOW_OTP_FORM_STATE
              //     ? 'Verify'
              //     :
            'Login',
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
        centerTitle: true,
        title: const Text(
          'Login Now',
          style: TextStyle(color: myblack, fontSize: 14),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/masjid1.png",
                      width: 150,
                      height: 150,color: searchBartext,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Masjidul Ameen \n Payyanad",textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: myblack,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),

                  ],
                )),

            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // currentSate ==
                    //         MobileVarificationState.SHOW_MOBILE_FORM_STATE
                    //     ?
                    mobileNumberWidget(context, flagUri)
                        // : otpWidget(),
                  ],
                ))

            // Spacer()
          ],
        ),
      ),
    );
  }

  Widget mobileNumberWidget(
      BuildContext context, String flagUri) {
    String codePackage = "";
    String flagImage =
        "https://w7.pngwing.com/pngs/29/173/png-transparent-null-pointer-symbol-computer-icons-pi-miscellaneous-angle-trademark.png";
    final width = MediaQuery.of(context).size.width;
    return Consumer<MainProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //Country
            //mobileNumber
            SizedBox(
              // height: 150,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: phoneNumberCT,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                cursorColor: clBlack,
                style: TextStyle(
                    color: cl767676, fontFamily: 'Poppins', fontSize: 15),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  hintText: 'Mobile Number',
                  helperText: "",
                  hintStyle: TextStyle(color: searchBartext),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: searchBartext,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:searchBartext,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:searchBartext,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: passwordCT,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                cursorColor: clBlack,
                style: TextStyle(
                    color: cl767676, fontFamily: 'Poppins', fontSize: 15),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  hintText: 'Password',
                  helperText: "",
                  hintStyle: TextStyle(color: searchBartext),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: searchBartext,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:searchBartext,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:searchBartext,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

          ],
        ),
      );
    });
  }

  Widget otpWidget() {
    return Consumer<MainProvider>(builder: (context, value, child) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: PinFieldAutoFill(
                codeLength: 6,
                // focusNode: _pinPutFocusNode,
                controller: otpNumberCT,
                keyboardType: TextInputType.number,
                autoFocus: true,
                // controller:value1. pinController,
                currentCode: "",
                decoration: BoxLooseDecoration(
                    gapSpace: 5,
                    radius: const Radius.circular(100),
                    textStyle: const TextStyle(fontSize: 20, color: gray),
                    strokeColorBuilder:
                        const FixedColorBuilder(Color(0xffEBEBEB))),
                onCodeChanged: (pin) {
                  if (pin!.length == 6) {
                    if (fixedOtpList.contains(phoneNumberCT.text)) {
                      checkValueForKey(phoneNumberCT.text.toString(),
                          otpNumberCT.text.toString());
                    } else {
                      verify();
                    }
                  }
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Resend",
                style: TextStyle(
                    color: Colors.red, fontFamily: "Poppins", fontSize: 12),
              ))
        ],
      );
    });
  }
}
