import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/addMemberScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Provider/MainProvider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class RegistrationsListScreen extends StatelessWidget {
  const RegistrationsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mHeight=MediaQuery.of(context).size.height;
    final mWidth=MediaQuery.of(context).size.width;
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: InkWell(onTap: (){
        mainProvider.clear();
        callNext(AddMemberScreen(from: '',id: '',), context);
      },
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.green,
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: clBlack,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Registration List",
          style: TextStyle(
            color: clBlack,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(onTap: (){
            mainProvider.fetchaallData();
          },
              child: Icon(Icons.download_outlined,color:Colors.green,size: 30,)),
        )],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            height: 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.04),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 5.15,
                  offset: Offset(0, 2.58),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Consumer<MainProvider>(
                builder: (context, value, child) {
                  return TextField(
                    controller: value.searchCT,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Search with Name/Phone Number",
                      hintStyle:  TextStyle(
                        color: cl898989.withOpacity(0.56),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      suffixIcon: InkWell(
                          onTap: () async {
                            if(value.searchCT.text==""){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:Colors.red,
                                      content: Text("Enter Name/phone to search",)));

                            }else{

                               mainProvider.searchFun(value.searchCT.text.toString());


                            }
                          },
                          child:  Icon(
                            Icons.search,
                            color: cl898989.withOpacity(0.56),
                          )),
                    ),
                    onChanged: (item) {
                      mainProvider.searchFun(value.searchCT.text.toString());
                    },
                    onSubmitted: (txt){


                    },
                  );
                }),
          ),
          SizedBox(height: 15,),

          Consumer<MainProvider>(builder: (context, value, child) {
              return Text('Total Registrations : '+value.fileterMemebrsList.length.toString(),
                  style: TextStyle(
                    color: clBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),);
            }
          ),
          Consumer<MainProvider>(builder: (context, value, child) {
            print(value.fileterMemebrsList.length.toString()+' FRNFR');
            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                itemCount: value.fileterMemebrsList.length,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context1, int index) {
                  var item = value.fileterMemebrsList[index];
                  return  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: InkWell(onTap: (){
                      mainProvider.fetchWithNo(item.id);
                      callNext(AddMemberScreen(id: item.id,from: 'edit',), context);
                    },
                      onLongPress: (){
                        DeleteAlert(context,item.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(

                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(22),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 5.15,
                              offset: Offset(0, 2.58),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  color: cl000000
                                      .withOpacity(0.10),
                                  borderRadius:
                                  BorderRadius.circular(19),
                                ),
                                child: Icon(Icons.person),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Container(width:mWidth*0.6,
                                        child: Text(
                                          item.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight:
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item.phone,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(child: Row(
                              children: [
                                InkWell(onTap:(){
                                  launch("tel:${item.phone}");

                                },
                                    child: Icon(Icons.call,color: Colors.black,size: 25,)),
                                SizedBox(width: 10,),
                                InkWell(onTap: (){
                                  launch("whatsapp://send?phone=${"+91"+item.phone.replaceAll("+91", '').replaceAll(" ", '')}");

                                },
                                    child: Image.asset('assets/whatsapp.png',color: Colors.black,scale: 2.5,)),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }

  DeleteAlert(context,String id) async {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          final width=MediaQuery.of(context).size.width;
          return AlertDialog(surfaceTintColor: Colors.white,
            // shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            content: Container(
              width:width*.70,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),

                // image: const DecorationImage(
                //   scale: 1.5,
                //   image: AssetImage('assets/logoForAlert.png',), // Replace with your image asset
                //   // fit: BoxFit.fill, // Adjust the background size as needed
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const Text(
                    'Confirm Delete',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height:10),

                  const Text(
                    'Are you sure want to delete?',
                    style: TextStyle(
                      color: cl5C5C5C,
                      fontSize: 12,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:1,
                        child: InkWell(
                          onTap:(){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment:Alignment.center,
                            height: 35,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x1C000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color:cl253068,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          flex:1,
                          child:InkWell(
                            onTap:(){
                              mainProvider.deleteitem(id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:Colors.black,
                                      content: Text("Successfully Deleted ")));
                              finish(context);
                            },
                            child: Container(
                              height: 35,
                              alignment:Alignment.center,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(-1.00, -0.00),
                                  end: Alignment(1, 0),
                                  colors: [    searchBartext,
                                    searchBartext2,],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34),
                                ),
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}
