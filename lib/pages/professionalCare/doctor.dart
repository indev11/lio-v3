import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/colors.dart';
import 'package:project/main.dart';
import 'package:project/pages/homepage/homeScreen.dart';
import 'package:project/pages/professionalCare/welcome_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Cannot launch url";
    }
  }

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        buildTop(),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        buildContent(),
      ],
    ));
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: buildCoverImage()),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          "https://img.freepik.com/free-photo/medical-stethoscope-with-paper-cut-family_23-2148488217.jpg",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage("images/therapist.jpg"),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(
            height: 0,
          ),
          Text(
            'Augustine B Francis',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Therapist',
            style: TextStyle(fontSize: 16, color: Colors.black45),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 16,
                  backgroundColor: primary,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        launch(
                            "https://www.facebook.com/augustine.francis.5?mibextid=LQQJ4d");
                      },
                      icon: Icon(FontAwesomeIcons.facebook, size: 20),
                    ),
                  )),
              const SizedBox(
                width: 7,
              ),
              CircleAvatar(
                radius: 16,
                backgroundColor: primary,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      launch(
                          "https://instagram.com/augustinebfrancis?igshid=MzRlODBiNWFlZA==");
                    },
                    icon: Icon(FontAwesomeIcons.instagram, size: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(),
          const SizedBox(
            height: 5,
          ),
          buildAbout(),
        ],
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          children: [
            Text(
              'ABOUT',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Augustine B Francis is a friendly and qualified HR Trainer and Counselor based in Calicut, India. With a passion for helping others, he has inspired and assisted people worldwide. Augustine's goal is to support individuals in their personal and professional growth. Feel free to reach out to him for a friendly conversation or guidance.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Phone No: +919349480708 ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: Text(
                'BOOK APPOINTMENT',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
                backgroundColor: MaterialStateProperty.all(primary),
              ),
            ),
          ],
        ),
      );
}
