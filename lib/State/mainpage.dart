import 'package:flutter/material.dart';
import 'package:smarthome/State/page/page.dart';
import 'package:smarthome/utility/my_constant.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('SMART HOME'),
            titleTextStyle: Myconstat().h5Style(),
            shadowColor: Myconstat.primary1,
            backgroundColor: Myconstat.orange1,
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Switch',
                  icon: Icon(
                    Icons.hdr_strong,
                    color: Myconstat.black,
                    size: 30,
                  ),
                ),
                Tab(
                    text: 'Device',
                    icon: Icon(
                      Icons.device_hub,
                      color: Myconstat.black,
                      size: 30,
                    )),
                Tab(
                    text: 'Utility',
                    icon: Icon(
                      Icons.blur_on,
                      color: Myconstat.black,
                      size: 30,
                    )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AddPage1(),
              Center(child: Text('Tab 2 content')),
              Center(child: Text('Tab 3 content'))
            ],
          ),
        ),
      );
}
