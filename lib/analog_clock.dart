import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime dateTime = DateTime.now();

  void _setNewDateTime(DateTime dateTiime) {
    setState(() {
      dateTime = dateTiime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnalogClockExample(dateTime),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

Widget AnalogClockExample(DateTime dateTimee) {
  return SingleChildScrollView(
    // padding: EdgeInsets.all(7),
    scrollDirection: Axis.horizontal,
    child: Column(
      children: [
        Row(
          children: [
            AnalogClock.dark(
              width: 200,
              height: 200,
              isLive: true,
              datetime: dateTimee,
              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(.2),shape: BoxShape.circle,),
            ),
          ],
        ),
      ],
    ),
  );
}