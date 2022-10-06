import 'package:flutter/material.dart';
//import 'package:flutter/circular_countdown_timer';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);
  static const routeName = '/timer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("5 минут на игру"), centerTitle: true),
        body: Center(
          child: CircularCountDownTimer(
            width: 150,
            height: 150,
            fillColor: Colors.red,
            ringColor: Colors.white,
            isReverse: true,
            duration: 300,
            strokeWidth: 30,
            textStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
