
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/selfcare/categories.dart';

class Exercise {
  final String name;
  final String mediaUrl;
  final String description;
  final MediaType mediaType;

  Exercise({required this.name, required this.mediaUrl, required this.description, this.mediaType = MediaType.image});
}

enum MediaType {
  image,
  gif,
}

class ExercisesPage extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      name: 'Push-up',
      mediaUrl: 'https://i.pinimg.com/originals/20/bd/95/20bd95eedf13ae9e111fe4e2953e0707.gif',
      description: 'STEPS:\n\n 1. Get down on all fours, placing your hands slightly wider than your shoulders.\n\n2. Straighten your arms and legs. \n\n3. Lower your body until your chest nearly touches the floor. \n\n4. Pause, then push yourself back up. \n\n5. Repeat',
    ),
    Exercise(
      name: 'Squats',
      mediaUrl: 'https://images-prod.healthline.com/hlcmsresource/images/topic_centers/Fitness-Exercise/GIFs/400x400_5_Exercises_for_Anterior_Pelvic_Tilt_Squats.gif',
      description: 'STEPS:\n\n 1. Stand with your hands on the back of your head and your feet shoulder-width apart with your feet turned out slightly to open the hip joint.\n\n2. Lower your body until your thighs are parallel to the floor.  \n\n3. Pause, then return to the starting position. \n\n4. Repeat',
    ),
    Exercise(
      name: 'Plank',
      mediaUrl: 'https://i.pinimg.com/originals/bb/e7/86/bbe78693697daed4037ea5439025f68f.gif',
      description: 'STEPS:\n\n 1. Get into a push up position, with your elbows under your shoulders and your feet hip-width apart.\n\n2. Bend your elbows and rest your weight on your forearms and on your toes, keeping your body in a straight line.  \n\n3. Hold for as long as possible. \n\n4. Repeat',
    ),
    Exercise(
      name: 'Burpee',
      mediaUrl: 'https://i.pinimg.com/originals/56/ab/43/56ab43202aba0f1efbf1d90b9dd474ea.gif',
      description: 'STEPS:\n\n 1. Stand straight with your feet shoulder-width apart.\n\n2. Squat and place your hands in front of your feet.\n\n3. Jump back until your body is in plank position. \n\n 4. Do a push up, jump forward, and then push through the heels to return to the starting position.\n\n5. Repeat',
    ),
    Exercise(
      name: 'Crunch',
      mediaUrl: 'https://i.pinimg.com/originals/92/ef/c1/92efc121d71105df65cd4400e8f82a3b.gif',
      description: 'STEPS:\n\n 1. Lie down on the mat, keep your knees bent, your back and feet flat, and your hands supporting your head.\n\n2. Lift your shoulders, squeeze your abdominal muscles and hold for 1 to 2 seconds.  \n\n3. Slowly return to the starting position \n\n4. Repeat',
    ),
    Exercise(
      name: 'Russian Twist',
      mediaUrl: 'https://i.pinimg.com/originals/b2/cc/5d/b2cc5d7320fd54d6e341078b5a2b93fa.gif',
      description: 'STEPS:\n\n 1. Lie down with your legs bent at the knees.\n\n2. Elevate your upper body so that it creates a V shape with your thighs.  \n\n3. Twist your torso to the right, and then reverse the motion, twisting it to the left. \n\n4. Repeat',
    ),
    Exercise(
      name: 'Jumping Jack',
      mediaUrl: 'https://i.pinimg.com/originals/57/cc/e0/57cce0afa73a4b4c9c8c139d08aec588.gif',
      description: 'STEPS:\n\n 1. Stand straight with your feet together and hands by your sides.\n\n2. Jump up, spread your feet and bring both hands together above your head.  \n\n3. Jump again and return to the starting position. \n\n4. Repeat',
    ),
    Exercise(
      name: 'Wall Sit',
      mediaUrl: 'https://i.pinimg.com/564x/39/b5/2a/39b52a9129b19dcd6f0382ffdd5681d8.jpg',
      description: 'STEPS:\n\n 1. Start in a squat position, with your thighs parallel to the floor and your back against a wall.\n\n2. Hold this position for as long as you can.',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Catagories()),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text('Exercises'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ExerciseDetailPage.routeName,
                    arguments: exercises[index],
                  );
                },
                leading: Container(
                  padding: EdgeInsets.all(8), // Add padding here
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        
                        blurRadius: 0.8,
                       
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      exercises[index].mediaUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  exercises[index].name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
    final Exercise exercise = ModalRoute.of(context)!.settings.arguments as Exercise;

return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              exercise.mediaUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  exercise.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(ExercisesPage());
}