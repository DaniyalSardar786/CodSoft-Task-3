import 'package:flutter/material.dart';

class CustomTimePicker {
  static Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay initialTime) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
  }
}
