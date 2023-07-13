

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/homepage/homeScreen.dart';
import 'package:project/pages/selfcare/exercise/home_view.dart';
import 'package:project/pages/selfcare/journal/home.dart';
import 'package:project/pages/selfcare/meditation/meditation.dart';
import 'package:project/pages/selfcare/yoga/yoga.dart';

class Catagories extends StatelessWidget {
  bool isGuest = false;
  Catagories({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: MyHomePage(isGuest: isGuest),
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool isGuest = false;
   MyHomePage({this.isGuest = false});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Row(children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Text('Hey There!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                  ]),
                  subtitle: Text('Choose One!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                 
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [

                  InkWell(
                    onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Meditation()));
            },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                spreadRadius: 2,
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(CupertinoIcons.sunset_fill,
                                  color: Colors.white)),
                          const SizedBox(height: 8),
                          Text('Meditation'.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                     onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Yoga()));
          },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                spreadRadius: 2,
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(CupertinoIcons.sunset,
                                  color: Colors.white)),
                          const SizedBox(height: 8),
                          Text('Yoga'.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                     onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ExercisesPage()));
          },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                spreadRadius: 2,
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(CupertinoIcons.bolt, color: Colors.white)),
                          const SizedBox(height: 8),
                          Text('Exercises'.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainActivity(isGuest: widget.isGuest,)));
          },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                spreadRadius: 2,
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(CupertinoIcons.eyedropper,
                                  color: Colors.white)),
                          const SizedBox(height: 8),
                          Text('Journal'.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}