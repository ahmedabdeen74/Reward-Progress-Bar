import 'package:flutter/material.dart';
import 'package:reward_progress_bar/widgets/card_points.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Reward Progress Bar")),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              CardPoints(
                currentPoints: 25,
                milestones: const [0, 30, 60, 90, 120],
                //  labels: const ["0", "30", "60", "90", "120"],
                progressColor: const Color(0xFFA47052),
                trackColor: const Color(0xFFEDE2DC),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Update Progress"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
