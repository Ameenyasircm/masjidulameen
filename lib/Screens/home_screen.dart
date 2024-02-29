import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/Instagram_logo.png',
          scale: 4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Image.asset(
            'assets/addPost.png',
            scale: 3,
          ),
          Image.asset(
            'assets/heart.png',
            scale: 3,
          ),
          Image.asset(
            'assets/message.png',
            scale: 3,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 130,
            // color: Colors.teal,
            width: width,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                // physics: const ClampingScrollPhysics(),
                itemCount: 15,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  // var item = value.mostWatchedList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 15),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: index != 0
                                  ? ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 2, color: Color(0xFFFFDD55)),
                                      ),
                                    )
                                  : ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                          width: 0,
                                        ),
                                      ),
                                    ),
                              child: Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: new BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('assets/man1.jpg')),
                                  )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            index == 0 ? Text('Your Story') : Text('Ameen')
                          ],
                        ),
                        index == 0
                            ? Positioned(
                                bottom: 40,
                                left: 55,
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.blue,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  );
                }),
          ),
          Flexible(
            child: ListView.builder(
                // padding: EdgeInsets.only(top: 10),
                // physics: const ClampingScrollPhysics(),
                itemCount: 15,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  // var item = value.mostWatchedList[index];
                  return Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Container(
                          height: 60,width: width,
                          // color: Colors.yellow,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/man1.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text('yakoob', style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      // height: 0,
                                      letterSpacing: 0.14,
                                    ),),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset('assets/more.png',scale: 4,),
                            )
                          ],
                        ),),
                      ),
                      Container(height: 500,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                        image: DecorationImage(fit: BoxFit.fill,
                          image: AssetImage('assets/Rectangle 1.png')
                        )
                      ),),
                      Container(height: 50,
                      // color: Colors.green,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 14,),
                              Image.asset('assets/heart.png',scale: 3,),
                              SizedBox(width: 14,),
                              Image.asset('assets/comment.png',scale: 4,),
                              SizedBox(width: 14,),
                              Image.asset('assets/message.png',scale: 3,),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Image.asset('assets/Save.png',scale: 4,),
                          ),

                        ],
                      ),)
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
