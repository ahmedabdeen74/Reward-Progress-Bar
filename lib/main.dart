import 'package:flutter/material.dart';
import 'package:reward_progress_bar/widgets/card_points.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              CardPoints(
                trackColor: Color(0xFFEDE2DC),
                currentPoints: 10,
                milestones: [0, 30, 60, 90, 120],
                progressColor: Color(0xFFA47052),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
