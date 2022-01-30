// import 'dart:async';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   var stopwatch = Stopwatch();
//   var display = '00:00:000';
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               display,
//               style: TextStyle(fontSize: 60),
//             ),
//             SizedBox(
//               height: 100,
//               width: 100,
//               child: FloatingActionButton(
//                   child: Icon(
//                     stopwatch.isRunning ? Icons.stop : Icons.play_arrow,
//                     size: 60,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       if (stopwatch.isRunning) {
//                         stopwatch.stop();
//                         // display = stopwatch.elapsed.inSeconds.toString();
//                         // stopwatch.reset();
//                       } else {
//                         stopwatch.reset();
//                         stopwatch.start();
//                         if (timer?.isActive == true) {
//                           timer?.cancel();
//                         }
//                         timer = Timer.periodic(Duration(microseconds: 96), (_) {
//                           setState(() {
//                             var m = stopwatch.elapsed.inMinutes
//                                 .toString()
//                                 .padLeft(2, '0');
//                             var s = stopwatch.elapsed.inSeconds
//                                 .remainder(60)
//                                 .toString()
//                                 .padLeft(2, '0');
//                             var ms = stopwatch.elapsed.inMilliseconds
//                                 .remainder(1000)
//                                 .toString()
//                                 .padLeft(3, '0');
//                             display = '$m:$s:$ms';
//                           });
//                         });
//                       }
//                     });
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarthome/utility/my_constant.dart';

class Timer extends StatefulWidget {
  Timer({Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  DateTime mydatetime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE d MMMM y');

    return time(formatter, now);
  }

  Scaffold time(DateFormat formatter, DateTime now) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        // padding: EdgeInsets.all(10),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Text(
        //       '${now.day} ${now.month} ${now.year}',
        //       style: Myconstat().h4Style(),
        //     ),
        //     Text('เวลา ${now.hour} ${now.minute} ${now.second} วินาที')
        //   ],
        // ),
        padding: EdgeInsets.all(20),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 20,
          children: <Widget>[
            Text(
              '${formatter.format(mydatetime)}',
              style: Myconstat().h4Style(),
            ),
            Text(
              'เวลา ${now.hour}:${now.minute}:${now.second}',
              style: Myconstat().h4Style(),
            )
          ],
        ),
      ),
    );
  }
}
