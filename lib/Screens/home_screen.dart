import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/loginscreen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Provider/MainProvider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import 'addMemberScreen.dart';

class HomeScreen extends StatefulWidget {
  String loginPhone;
   HomeScreen({Key? key,required this.loginPhone}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int activeIndex = 0;
  List<String> carouselImages = [
    "assets/image.jpg",
    "assets/image.jpg",
  ];

  List<String> images=['assets/ttt.png','assets/images.jpg',"assets/imagesQibla.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final mHeight=MediaQuery.of(context).size.height;
    final mWidth=MediaQuery.of(context).size.width;
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mHeight*0.045,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50,width: 50,
                      child: Image.asset('assets/masjid1.png',color: searchBartext,)),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome!" ,style:TextStyle(
                        color: welcomeBlue,
                        fontSize:14,
                        fontFamily: 'Montserrat-Bold',
                        fontWeight: FontWeight.w700,
                      )),
                      Text("MASJIDUL AMEEN PAYYANAD" ,style:TextStyle(
                        color: welcomeBlue,
                        fontSize:14,
                        fontFamily: 'Montserrat-Bold',
                        fontWeight: FontWeight.w700,
                      )),
                    ],
                  ),SizedBox(width: 10,),
                  Align(alignment: Alignment.topRight,
                    child: Consumer<MainProvider>(
                        builder: (context,value,child) {
                          return InkWell(
                            onTap: () {
                              callNext(LoginScreen(from: '', vId: ''), context);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: cl000000.withOpacity(0.10),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                            child: Icon(Icons.login,color: Colors.grey,),
                            )
                            ,
                          );
                        }
                    ),
                  )
                ],
              ),
              SizedBox(height:20,),
              CarouselSlider.builder(
                itemCount: carouselImages.length,
                itemBuilder: (context, index, realIndex) {
                  //final image=value.imgList[index];
                  final image = carouselImages[index];
                  return buildImage(image, context);
                },
                options: CarouselOptions(
                    height: 180,
                    viewportFraction: 1,
                    animateToClosest: true,
                    padEnds: true,
                    autoPlay: true,
                    initialPage: 1,
                    enlargeStrategy:
                    CenterPageEnlargeStrategy.values[2],
                    enlargeCenterPage: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    }),
              ),
              buildIndiCator(
                  carouselImages.length, context, activeIndex),
              SizedBox(height: 20,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return ListView.builder(
                      shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        itemCount: value.homeList.length,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder:
                            (BuildContext context1, int index) {
                          var item = value.homeList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: InkWell(onTap:(){
                              if(index==0){
                                mainProvider.clearBool=false;
                                mainProvider.clear();
                                // mainProvider.fetch();
                                callNext(AddMemberScreen(), context);
                              }
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
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: AssetImage(images[index])
                                          ),
                                          color: cl000000
                                              .withOpacity(0.10),
                                          borderRadius:
                                          BorderRadius.circular(19),
                                        ),
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
                                              Text(
                                                item,
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
                                    Expanded(child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,size: 20,))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
              ),
          
            ],
          ),
        ),
      ),

    );
  }

   buildImage(var image, context) {
     return Container(
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),
           image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
     );
   }

   buildIndiCator(int count, BuildContext context, int activeIndex) {
     int imgCount = count;
     return Center(
       child: Padding(
         padding: const EdgeInsets.only(top: 8),
         child: AnimatedSmoothIndicator(
           activeIndex: activeIndex,
           count: count,
           effect: ExpandingDotsEffect(
               dotWidth: 7,
               dotHeight: 7,
               strokeWidth: 1,
               paintStyle: PaintingStyle.fill,
               activeDotColor: carousel,
               dotColor: Colors.grey.shade300),
         ),
       ),
     );
   }
}
