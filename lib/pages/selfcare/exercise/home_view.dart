import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/selfcare/categories.dart';
import 'package:project/pages/selfcare/exercise/mode.dart';

class Exercise {
  final String name;
  final String photoUrl;

  Exercise({required this.name, required this.photoUrl});
}

class ExercisesPage extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      name: 'Push-up',
      photoUrl:
          'https://www.fitnesseducation.edu.au/wp-content/uploads/2017/03/Pushups.jpg',
    ),
    Exercise(
      name: 'Squats',
      photoUrl:
          'https://blog.fitbit.com/wp-content/uploads/2016/10/ArmStanding.jpg',
    ),
    Exercise(
      name: 'Plank',
      photoUrl:
          'https://images.healthshots.com/healthshots/en/uploads/2023/01/06114251/plank-1600x900.jpg',
    ),
    Exercise(
      name: 'burpee',
      photoUrl:
          'https://images.healthshots.com/healthshots/en/uploads/2023/03/16013822/Burpees.jpg',
    ),
    Exercise(
      name: 'Crunch',
      photoUrl:
          'https://t4.ftcdn.net/jpg/04/30/57/71/360_F_430577104_7cghyBul0mCZ9GJzto8YmXG3LLBgracp.jpg',
    ),
    Exercise(
      name: 'Russian Twist',
      photoUrl:
          'https://hips.hearstapps.com/hmg-prod/images/russian-twist-sharpened-1548270008.jpg',
    ),
    Exercise(
      name: 'Jumping Jack',
      photoUrl: 'https://cdn.fitimg.in/gallery_image_jumping-jacks_C2FD.png',
    ),
    Exercise(
      name: 'Wall Sit',
      photoUrl:
          'https://media.self.com/photos/6304f8e8b1ac17acc17bc375/4:3/w_2560%2Cc_limit/master-the-wall-sit.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Exercise Photos',
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: ExerciseListPage(exercises: exercises),
      routes: {
        ExerciseDetailPage.routeName: (context) => ExerciseDetailPage(),
      },
    );
  }
}

class ExerciseListPage extends StatelessWidget {
  final List<Exercise> exercises;

  ExerciseListPage({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Catagories()));
                },
                icon: Icon(Icons.arrow_back)),
            Text('Exercises'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                ExerciseDetailPage.routeName,
                arguments: exercises[index],
              );
            },
            leading: Icon(Icons.fitness_center),
            title: Text(exercises[index].name),
          );
        },
      ),
    );
  }
}

class ExerciseDetailPage extends StatelessWidget {
  static const routeName = '/exercise-detail';

  @override
  Widget build(BuildContext context) {
    final Exercise exercise =
        ModalRoute.of(context)!.settings.arguments as Exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: Center(
        child: Image.network(exercise.photoUrl),
      ),
    );
  }
}
