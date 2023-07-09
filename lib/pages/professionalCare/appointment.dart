import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/main.dart';
import 'package:project/pages/homepage/homeScreen.dart';
import 'package:intl/intl.dart';

class Appointment extends StatefulWidget {
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var curentdate;
  var formattedate;
  var time;
  var formattedtime;

  @override
  void initState() {
    // TODO: implement initState
    curentdate = DateTime.now();
    formattedate = DateFormat('dd-MMM-yy').format(curentdate);
    time = curentdate.add(Duration(hours: 2));
    formattedtime = DateFormat('Hm').format(time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        // Remove debug banner
        backgroundColor: primary,
        body: Container(
          margin: EdgeInsetsDirectional.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "You have been given an appointment with the Therapist on $formattedate $formattedtime, Please contact the therapist at the appointed time. Ph.no : 9349480708",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    "Back Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
