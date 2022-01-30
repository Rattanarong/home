import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smarthome/State/mainpage.dart';
import 'package:smarthome/reusable_widgets/reusable_widget.dart';
import 'package:smarthome/screens/signup_screen.dart';
import 'package:smarthome/utility/my_constant.dart';
import 'package:smarthome/utils/color_utils.dart';
import 'package:smarthome/widgets/show_image.dart';
import 'package:smarthome/widgets/show_title.dart';
// import 'package:http/http.dart' as http;

class Dasktop extends StatefulWidget {
  const Dasktop({Key? key}) : super(key: key);

  @override
  _DasktopState createState() => _DasktopState();
}

class _DasktopState extends State<Dasktop> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool statusRedEye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("0099CC"),
          hexStringToColor("00B2EE"),
          hexStringToColor("00BFFF")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/Smart home.png"),
                buildAppName(),
                reusableTextField("User:", Icons.account_circle_outlined, false,
                    emailController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Password:", Icons.lock_outline, true, passwordController),
                const SizedBox(
                  height: 5,
                ),
                firbaseButton(context, "Login", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    Fluttertoast.showToast(msg: "Login Sucessful");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Mainpage()));
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(
                        msg: "${error.toString()}",
                        gravity: ToastGravity.CENTER);
                    print("Error ${error.toString()}");
                  });
                }),
                // buildUser(size),
                // buildPassword(size),
                // buildLogin(size),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Non Account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " create Account",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   double size = MediaQuery.of(context).size.width;
  //   return Scaffold(
  //     body: SafeArea(
  //       child: GestureDetector(
  //         onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
  //         behavior: HitTestBehavior.opaque,
  //         child: ListView(
  //           children: [
  // buildImage(size),
  // buildAppName(),
  // reusableTextField("User:", Icons.account_circle_outlined, false,
  //     emailController),
  // const SizedBox(
  //   height: 20,
  // ),
  // reusableTextField(
  //     "Password", Icons.lock_outline, true, passwordController),
  // const SizedBox(
  //   height: 5,
  // ),
  // firbaseButton(context, "Login", () {
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //           email: emailController.text,
  //           password: passwordController.text)
  //       .then((value) {
  //     Fluttertoast.showToast(msg: "Login Sucessful");
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => Mainpage()));
  //   }).onError((error, stackTrace) {
  //     Fluttertoast.showToast(
  //         msg: "${error.toString()}", gravity: ToastGravity.CENTER);
  //     print("Error ${error.toString()}");
  //   });
  // }),
  // // buildUser(size),
  // // buildPassword(size),
  // // buildLogin(size),
  // buildCreateAccount(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ?',
          textStyle: Myconstat().h3Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, Myconstat.routeHomescreen),
          child: Text('create Account'),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          // width: size * 0.6,
          child: ElevatedButton(
            style: Myconstat().MyButtonStyle(),
            onPressed: () {
              // login();
              setState(() {
                emailController.clear();
                passwordController.clear();
              });
              Navigator.pushNamed(context, Myconstat.routemainpage);
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelStyle: Myconstat().h3Style(),
              labelText: 'Email :',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Myconstat.light2,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Myconstat.dark1),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Myconstat.light1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordController,
            obscureText: statusRedEye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        Icons.remove_red_eye,
                        color: Myconstat.dark2,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: Myconstat.dark2,
                      ),
              ),
              labelStyle: Myconstat().h3Style(),
              labelText: 'password :',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Myconstat.light2,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Myconstat.dark1),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Myconstat.light1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(title: Myconstat.appName, textStyle: Myconstat().h1Style()),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: ShowImage(path: Myconstat.image1),
        ),
      ],
    );
  }

  // Future login() async {
  //   var url = Uri.http('192.168.1.86:8000', '/api/login/');
  //   Map<String, String> header = {"Content-type": "application/json"};
  //   String jsondata =
  //       '{"username":"${usernameController.text}","password":"${passwordController.text}",}';
  //   var response = await http.post(url, headers: header, body: jsondata);
  //   print('----------');
  //   print(response.body);
  //   if (response.body == "true") {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return Mainpage();
  //     }));
  //   }
  // }
}
