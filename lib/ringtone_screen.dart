import 'package:flutter/material.dart';

class RingtoneScreen extends StatefulWidget {
   const RingtoneScreen({super.key});

  @override
  State<RingtoneScreen> createState() => _RingtoneScreenState();
}

class _RingtoneScreenState extends State<RingtoneScreen> {
  String _selectedRingtone = 'Ringtone 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Ringtone",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Ringtone 1',style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),),
            value: 'Ringtone 1',
            groupValue: _selectedRingtone,
            onChanged: (value) {
              setState(() {
                _selectedRingtone = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Ringtone 2',style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),),
            value: 'Ringtone 2',
            groupValue: _selectedRingtone,
            onChanged: (value) {
              setState(() {
                _selectedRingtone = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Ringtone 3',style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),),
            value: 'Ringtone 3',
            groupValue: _selectedRingtone,
            onChanged: (value) {
              setState(() {
                _selectedRingtone = value!;
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RingtoneScreen(),
  ));
}
