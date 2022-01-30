import 'package:smarthome/State/dasktop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/State/mainpage.dart';
import 'package:smarthome/State/page/page.dart';
import 'package:smarthome/State/page/timer.dart';
import 'package:smarthome/State/register.dart';
import 'package:smarthome/screens/home_screen.dart';
import 'package:smarthome/screens/signin_screen.dart';
import 'package:smarthome/utility/my_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Dasktop(),
    );
  }
}
// final Map<String, WidgetBuilder> map = {
//   '/dasktop': (BuildContext context) => Dasktop(),
//   '/register': (BuildContext context) => Register(),
//   '/mainpage': (BuildContext context) => Mainpage(),
//   '/page': (BuildContext context) => AddPage1(),
//   '/timer': (BuildContext context) => Timer(),
//   // '/update_todolist':(BuildContext context) => UpdatePage(V1, V2, V3),
// };

// String? initlalRoute;

// void main() {
//   initlalRoute = Myconstat.routedasktop;
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: Myconstat.appName,
//       routes: map,
//       initialRoute: initlalRoute,
//     );
//   }
// }
