import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';





class Update extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  Update({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mHeight=MediaQuery.of(context).size.height;
    final mWidth=MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.84,
                decoration: const BoxDecoration(
                ),
                child:     Stack(
                  children:  [Center(
                      child:     Image.asset(
                        "assets/rbslogo.png",
                        width: 200,
                        height: 200,
                      )),

                  ],
                ),
              ),

              Center(
                child: Text(text,  textAlign: TextAlign.center,style: const TextStyle(

                    fontSize: 18,
                    fontWeight: FontWeight.w500



                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: (){
                    print(ADDRESS.toString()+"VRGBTHYJu");
                    launchURL(ADDRESS);
                  },
                  child: Container(
                    height: 40,
                    width: 150,

                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,),
                            child: Text(button,style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,


                              color: Colors.black,
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


      ),
    );

  }
  void launchURL(String _url) async {
    print(_url+"vjnfjnv");
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
