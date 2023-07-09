import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:project/colors.dart';
import 'package:project/pages/blog/blog.dart';

import 'package:project/pages/loginScreen.dart';
import 'package:project/pages/professionalCare/doctor.dart';
import 'package:project/pages/professionalCare/welcome_screen.dart';
import 'package:project/pages/selfcare/catagories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentDate;var formattedate;
  @override
  void initState() {
    currentDate = DateTime.now();
    formattedate=DateFormat('dd-MMM-yy').format(currentDate);
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Text(
          "OK",
          style: TextStyle(color: primary),
        ));

    void OnSelected(BuildContext context, int value) {
      switch (value) {
        case 2:
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route route) => false);
          break;
      }
    }

    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  Text(
                                    greetingMessage(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "$formattedate",
                            style: TextStyle(
                              color: Color.fromARGB(70, 188, 216, 239),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    FlutterPhoneDirectCaller.callNumber(
                                        '+917736759612');
                                  },
                                  child: Text(
                                    "SOS",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Icon(
                                Icons.phone,
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                      Theme(
                          data: Theme.of(context).copyWith(
                              cardColor: Colors.white,
                              iconTheme: IconThemeData(color: Colors.white)),
                          child: PopupMenuButton(
                              onSelected: (value) => OnSelected(context, value),
                              itemBuilder: (context) => [
                                    PopupMenuItem<int>(
                                      value: 2,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            child: Text('Logout'),
                                            onTap: () {
                                              FirebaseAuth.instance
                                                  .signOut()
                                                  .then((value) {
                                                print("Signed out");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ]))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Nurture your mental health, prioritize self-care, and remember your resilience in facing life's challenges.",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 17),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "How do you feel?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(130, 189, 237, 0.286),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AlertDialog(
                                                title:
                                                    Text("Sorry to hear that!"),
                                                content: Text(
                                                    "We hope things get better for you soon"),
                                                actions: [
                                                  okButton,
                                                ],
                                              )));
                                },
                                child: Center(
                                    child: Text(
                                  '😩',
                                  style: TextStyle(fontSize: 28),
                                )),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Bad',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(73, 130, 189, 237),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AlertDialog(
                                                title:
                                                    Text("Good to hear that!"),
                                                content: Text(
                                                    "I hope today bring you more positivity and enjoyment"),
                                                actions: [
                                                  okButton,
                                                ],
                                              )));
                                },
                                child: Center(
                                    child: Text(
                                  '🙂',
                                  style: TextStyle(fontSize: 28),
                                )),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Fine',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(73, 130, 189, 237),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    "Thats wonderful to hear!"),
                                                content: Text(
                                                    "May the rest of your day be filled with similar joy and success"),
                                                actions: [
                                                  okButton,
                                                ],
                                              )));
                                },
                                child: Center(
                                    child: Text(
                                  '😄',
                                  style: TextStyle(fontSize: 28),
                                )),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Well',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(73, 130, 189, 237),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    "Wow! Thats fantastic"),
                                                content: Text(
                                                    "Wishing you many more incredible experiences and happiness"),
                                                actions: [
                                                  okButton,
                                                ],
                                              )));
                                },
                                child: Center(
                                    child: Text(
                                  '🥳',
                                  style: TextStyle(fontSize: 28),
                                )),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Excellent',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(25),
                color: Color.fromARGB(108, 149, 167, 183),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Choose Your Category!",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Catagories()));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                              padding: EdgeInsets.all(16),
                                              color: primary,
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Text(
                                          'SELF CARE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 70,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Doctor()));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                              padding: EdgeInsets.all(16),
                                              color: primary,
                                              child: Icon(
                                                Icons.medical_services,
                                                color: Colors.white,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          'PROFESSIONAL CARE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 1,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlogPage()));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                              padding: EdgeInsets.all(16),
                                              color: primary,
                                              child: Icon(
                                                Icons.bookmark_outline_rounded,
                                                color: Colors.white,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          'BLOG',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 90,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 11.59) {
      return 'Good Morning';
    } else if (timeNow > 12 && timeNow <= 16) {
      return 'Good Afternoon';
    } else if (timeNow > 16 && timeNow < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }
}
