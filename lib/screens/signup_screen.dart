import 'package:smarthome/State/dasktop.dart';
import 'package:smarthome/model/user_model.dart';
import 'package:smarthome/reusable_widgets/reusable_widget.dart';
import 'package:smarthome/screens/home_screen.dart';
import 'package:smarthome/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
        elevation: 0,
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("FFFFFF"),
          hexStringToColor("FFFFFF"),
          hexStringToColor("FFFFFF")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(70, 120, 70, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Full Name", Icons.person_outline,
                    false, usernameController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Phone Number",
                    Icons.phone_android_sharp, false, phoneController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.email_outlined, false,
                    emailController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    passwordController),
                const SizedBox(
                  height: 20,
                ),
                firbaseButton(context, "Register", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    postDetailsToFirestore();
                    print('"Created New Account');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dasktop()));
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(
                        msg: "${error.toString()}",
                        gravity: ToastGravity.CENTER);
                    print('Error ${error.toString()}');
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.username = usernameController.text;
    userModel.phone = phoneController.text;
    userModel.email = emailController.text;
    userModel.password = passwordController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: '"Account created successfully');
    print('TEST UID: $user.uid');
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
