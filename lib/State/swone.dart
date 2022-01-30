import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smarthome/utility/my_constant.dart';

import 'dart:async';
import 'dart:io';
import 'package:smarthome/mqtt_client.dart';
import 'package:smarthome/mqtt_server_client.dart';

class FirstSwitch extends StatefulWidget {
  final String topic;
  final String no;
  const FirstSwitch(
    this.topic,
    this.no,
  );

  @override
  _FirstSwitchState createState() => _FirstSwitchState();
}

class _FirstSwitchState extends State<FirstSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 320))
          ..addListener(() {
            setState(() {});
          });

    _anim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.decelerate),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Center(child: child),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 240,
                height: 240 * (150 / 283),
                color: Colors.grey.shade200,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 440),
                        width: 240 - 7.9,
                        height: 240 * (150 / 283) - 7.9,
                        color: isOn ? Colors.tealAccent : Colors.red,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: ClipPath(
                        clipper: MyClipper(
                          1 - _anim.value,
                        ),
                        child: Container(
                          width: 240 - 7.9,
                          height: 240 * (150 / 283) - 7.9,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    Center(
                      child: ClipPath(
                        clipper: MyClipper(
                          1 - _anim.value,
                        ),
                        child: Container(
                          width: 240,
                          height: 240 * (150 / 283),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 240,
                height: 240 * (150 / 283),
                color: Colors.transparent,
                child: Stack(children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 320),
                    top: 0,
                    right: isOn ? 240 * (150 / 283) - 14 : 0,
                    child: Opacity(
                      opacity: 1 - _ctrl.value,
                      child: Container(
                        width: 240 * (150 / 283),
                        height: 240 * (150 / 283),
                        child: Center(
                          child: Text(
                            isOn ? "ON" : "OFF",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20 - 8 * _ctrl.value,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                      duration: Duration(milliseconds: 640),
                      curve: Curves.bounceOut,
                      top: 10,
                      left: isOn ? 240 * (150 / 283) - 5 : 10.0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isOn = !isOn;
                          });
                          mqttpub(widget.topic, widget.no, isOn);
                          _ctrl.forward().whenComplete(() {
                            _ctrl.reverse();
                          });
                        },
                        child: Container(
                          width: 240 * (150 / 283) - 20,
                          height: 240 * (150 / 283) - 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: Offset(-3, 3),
                                blurRadius: 5,
                              ),
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: Offset(3, -3),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 2,
                                left: 2,
                                child: Container(
                                  width: 240 * (150 / 283) - 24,
                                  height: 240 * (150 / 283) - 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.grey.withOpacity(0.02),
                                        Colors.grey.withOpacity(0.2),
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 0),
                                top: isOn ? (240 * (150 / 283) - 24) / 2 : 24,
                                bottom:
                                    isOn ? (240 * (150 / 283) - 24) / 2 : 24,
                                left: !isOn ? (240 * (150 / 283) - 24) / 2 : 24,
                                right:
                                    !isOn ? (240 * (150 / 283) - 24) / 2 : 24,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                        Colors.transparent,
                                      ],
                                      begin: isOn
                                          ? Alignment.topCenter
                                          : Alignment.centerLeft,
                                      end: isOn
                                          ? Alignment.bottomCenter
                                          : Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> checkled() async {
    final client = MqttServerClient('electsut.trueddns.com', '');
    client.port = 27860;
    client.logging(on: false);
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;
    try {
      await client.connect();
    } on Exception catch (e) {
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    print('EXAMPLE::Subscribing');
    const topic = 'Dart/Mqtt_client'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    await MqttUtilities.asyncSleep(3);
    client.disconnect();
  }

  Future<dynamic> mqttpub(topic, no, senddata) async {
    final client = MqttServerClient('electsut.trueddns.com', '');
    client.port = 27860;
    client.logging(on: false);
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    var pubTopic = '$topic$no';
    final builder = MqttClientPayloadBuilder();
    builder.addString("{'state':'$senddata'}");

    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
    await MqttUtilities.asyncSleep(3);
    client.disconnect();
    checkled();
  }
}

class MyClipper extends CustomClipper<Path> {
  final double toggle;

  MyClipper(this.toggle);
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    var path = Path();

    path.lineTo(0, h / 2);
    path.cubicTo(0, h * 0.225, w * 0.119258, 0, w * 0.265018, 0);

    //!
    path.cubicTo(
      w * 0.382509,
      0,
      w * 0.441696,
      h * 0.133333 * toggle, //? d
      w * 0.5,
      h * 0.133333 * toggle, //? d
    );
    path.cubicTo(
      w * 0.558303,
      h * 0.133333 * toggle, //? d
      w * 0.617491,
      0,
      w * 0.734982,
      0,
    );

    path.cubicTo(w * 0.880742, 0, w, h * 0.225, w, h * 0.5);
    path.cubicTo(w, h * 0.775, w * 0.880742, h, w * 0.734982, h);

    //!
    path.cubicTo(
      w * 0.617491,
      h,
      w * 0.558303,
      h - h * 0.133333 * toggle, //? d
      w * 0.5,
      h - h * 0.133333 * toggle, //? d
    );
    path.cubicTo(
      w * 0.441696,
      h - h * 0.133333 * toggle, //? d
      w * 0.382509,
      h,
      w * 0.265018,
      h,
    );

    path.cubicTo(w * 0.119258, h, 0, h * 0.775, 0, h * 0.5);
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
