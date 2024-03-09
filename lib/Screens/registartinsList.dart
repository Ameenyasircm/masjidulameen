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
}
