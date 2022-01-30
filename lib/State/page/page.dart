import 'package:flutter/material.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smarthome/State/get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smarthome/utility/my_constant.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AddPage1 extends StatefulWidget {
  const AddPage1({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage1> {
  List todolistitems = [];
  String qrcode = 'Hi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Myconstat.black,
        onPressed: startscan,
        child: Icon(
          Icons.qr_code_scanner_sharp,
          color: Myconstat.primary1,
        ),
      ),
      body: Getdata(),
    );
  }

  Future<void> startscan() async {
    try {
      final qrcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrcode = qrcode;
        print(qrcode);
        if (qrcode.contains("smarthome/lasdlkasck/1/looff")) {
          Navigator.pushNamed(context, Myconstat.routeregister);
        }
      });
    } on PlatformException {
      qrcode = 'Failed to get platform version.';
    }
  }
}
