import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/professionalCare/appointment.dart';
import 'package:project/pages/professionalCare/colors.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            primary,
            primary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              
              child: Image.asset("images/doctors.png"),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Appointment with Therapist",
              style: TextStyle(
                color: wColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            
             
           
            SizedBox(
              height: 60,
            ),
            Material(
              color: wColor,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      color: primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 60,),
            Image.asset("images/lined heart.png",color: wColor,scale: 2,)
          ],
        ),
      ),
    );
  }
}
