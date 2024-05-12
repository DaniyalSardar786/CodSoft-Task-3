import 'package:alarm_app/ringtone_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'analog_clock.dart';
import 'globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final myBox=Hive.box("AlarmBox");

  // Define a function to refresh the HomeScreen
  void refreshHomeScreen() {
    setState(() {
      // Add code here to refresh the HomeScreen as needed
    });
  }
  @override
  void initState() {
    super.initState();
    // Load data from Hive into lists when the screen is initialized
    timeList = List<String>.from(myBox.get(1, defaultValue: []));
    ampmList = List<String>.from(myBox.get(2, defaultValue: []));
    dayList = List<String>.from(myBox.get(3, defaultValue: []));
    alarmStatus= List<bool>.from(myBox.get(4,defaultValue: []));
  }

  void _writeData(){
    setState(() {
      myBox.put(1, timeList);
      myBox.put(2, ampmList);
      myBox.put(3, dayList);
      myBox.put(4, alarmStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                 Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Alarm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RingtoneScreen()));
                        },
                          child: const Icon(Icons.settings, size: 28, color: Colors.green)
                      )
                    ],
                  ),
                ),
                const Clock(),
                Expanded(
                  child: ListView.builder(
                    itemCount: timeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: GestureDetector(
                          onTap: () {
                            forUpdate=true;
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => EditScreen(
                            //       showDateTimePicker: _showDateTimePicker,
                            //       index: index, // Pass the index value
                            //     ),
                            //   ),
                            // );
                            _showDateTimePicker(context, index);
                          },
                          child: Row(
                            children: [
                              Text(
                                timeList[index], // Display selected time
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                " ${ampmList[index]}", // Display selected AM/PM
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        subtitle: Text(
                          dayList[index], // Display selected day
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  timeList.removeAt(index);
                                  ampmList.removeAt(index);
                                  dayList.removeAt(index);
                                  alarmStatus.removeAt(index);
                                  _writeData();
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                if(alarmStatus[index]){
                                  alarmStatus.removeAt(index);
                                  alarmStatus.insert(index, false);
                                  _writeData();
                                }
                                else{
                                  alarmStatus.removeAt(index);
                                  alarmStatus.insert(index, true);
                                  _writeData();
                                }
                                });
                              },
                              child: Icon(alarmStatus[index]?Icons.toggle_on:Icons.toggle_off_outlined,size: 55,color:alarmStatus[index]? Colors.green:Colors.grey,),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    int index=0;
                    _showDateTimePicker(context,index); // Call to show date and time picker
                  },
                  shape: const CircleBorder(),
                  backgroundColor: Colors.green.shade800,
                  child: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey.withOpacity(.1),
      ),
    );
  }

  // Function to show the date and time picker
  Future<void> _showDateTimePicker(BuildContext context,index) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          String ampm = pickedTime.period == DayPeriod.am ? 'AM' : 'PM'; // Determine AM/PM
          String formattedTime = _formatTime(pickedTime); // Format time
          if (forUpdate)
            {
              timeList.removeAt(index);
              ampmList.removeAt(index);
              dayList.removeAt(index);
              alarmStatus.removeAt(index);
              timeList.insert(index,formattedTime);
              ampmList.insert(index,ampm);
              dayList.insert(index,_formatDay(pickedDate));
              alarmStatus.insert(index,true);
              forUpdate=false;
              _writeData();
          }
          else{
            timeList.insert(0,formattedTime);
            ampmList.insert(0,ampm);
            dayList.insert(0,_formatDay(pickedDate));
            alarmStatus.insert(0, true);
            _writeData();
          }
        });
      }
    }
  }

  // Function to format the selected time
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Function to format the selected day
  String _formatDay(DateTime date) {
    if (DateTime(date.year, date.month, date.day) ==
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      return 'Today';
    } else if (DateTime(date.year, date.month, date.day) ==
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)) {
      return 'Tomorrow';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}