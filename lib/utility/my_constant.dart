import 'package:flutter/material.dart';

class Myconstat {
  static String appName = 'Smart home';
  static String domain = 'https://f800-183-89-66-98.ngrok.io';

  static String routelogin = '/login';
  static String routedasktop = '/dasktop';
  static String routeregister = '/register';
  // static String routeqrcode = '/qrcode';
  static String routesmarthome = '/smarthome';
  static String routemainpage = '/mainpage';
  static String routeled1 = '/led1';
  static String routeupdate = '/update_todolist';
  static String routeget = '/get';
  static String routetimer = '/timer';
  static String routeHomescreen = '/signup_screen';

  static String image1 = 'assets/images/Smart home.png';

  static Color primary = Color(0xfff9c12d); //เหลือง
  static Color dark = Color(0xffc29100);
  static Color light = Color(0xfffff363);
  static Color primary1 = Color(0xff00e5ff); //เขียวฟ้า
  static Color dark1 = Color(0xff00b2cc);
  static Color light1 = Color(0xff6effff);
  static Color primary2 = Color(0xff5d4037); //สีน้ำตาล
  static Color dark2 = Color(0xff321911);
  static Color light2 = Color(0xff8b6b61);
  static Color orange = Color(0xffe65100);
  static Color orange1 = Color(0xffff9800);
  static Color black = Color(0xff212121);
  static Color grey = Color(0xff616161);
  static Color broun = Color(0xff616161);
  static Color white1 = Color(0xfffafafa);
  static Color oragelight = Color(0xffffe0b2);
  static Color grey1 = Color(0xffffccbc);

  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h4Style() => TextStyle(
        fontSize: 30,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h5Style() => TextStyle(
        fontSize: 24,
        color: broun,
        fontWeight: FontWeight.bold,
      );

  ButtonStyle MyButtonStyle() => ElevatedButton.styleFrom(
        primary: Myconstat.primary,
        padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  ButtonStyle MyButtonStyle1() => ElevatedButton.styleFrom(
        primary: Myconstat.primary,
        padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
}
