import 'package:smarthome/model/user_model.dart';
import 'package:smarthome/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //------------------------Read data from firebase-------------------------------------------------//
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  //------------------------Read data from firebase-------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${loggedInUser.username}'),
            accountEmail: Text('${loggedInUser.email}'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  // Image.network(src)
                  ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('assets/images/bgNavBar.png'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.report_gmailerrorred_outlined),
            title: Text('Report - Soon Update'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings - Soon Update'),
            onTap: () {},
          ),
          Divider(
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 10,
            color: Colors.black54,
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('Add device - Soon Update'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('Add device - Soon Update'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('Add device - Soon Update'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('Add device - Soon Update'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('Add device - Soon Update'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
