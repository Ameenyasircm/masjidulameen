import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_colors.dart';

Widget textField(String hint,TextInputType type){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
    child: TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(

          color: clBlack,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      keyboardType: type,
      inputFormatters: [type==TextInputType.number?LengthLimitingTextInputFormatter(10):FilteringTextInputFormatter.deny('')],
      decoration:  InputDecoration(
        contentPadding:const EdgeInsets.symmetric(horizontal: 18),
        hintStyle:  const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            color: clBlack) ,
        fillColor: const Color(0XFFF4FAFF),
        filled: true,
        border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),borderSide: const BorderSide(color: Color(0XFFF4FAFF),)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),borderSide: const BorderSide(color: Color(0XFFF4FAFF))),
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),borderSide: const BorderSide(color: Color(0XFFF4FAFF),)),
        hintText: hint,
      ),
    ),
  );
}

TextStyle whiteGoogleBold30=const TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w600,
  color:cl014D88,
);

 Widget appBarAll(){
  return AppBar(
    centerTitle: true,
    leading: Center(
      child: InkWell(
        onTap: () {},
        child: const SizedBox(
          height: 30,
          width: 30,
          child: Icon(Icons.keyboard_arrow_left,size: 30,),
        ),
      ),
    ),
    title:  const Text("Notifications",style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
        color: cl000000
    ),),

  );
 }