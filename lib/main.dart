import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reward_progress_bar/reward_progress_bar.dart';

void main() => runApp(const RewardShowcaseApp());

class RewardShowcaseApp extends StatelessWidget {
  const RewardShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const ShowcaseScreen(),
    );
  }
}

class ShowcaseScreen extends StatefulWidget {
  const ShowcaseScreen({super.key});

  @override
  State<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  int currentPoints = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reward Package Demo"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // 1 - (Custom SVG Assets)
              // =================================================
              const _SectionTitle("1. Custom Assets (SVG Support)"),
              _ShowcaseCard(
                color: const Color(0xFFFDF8F5),
                child: CardPoints(
                  currentPoints: currentPoints,
                  milestones: const [0, 30, 60, 90, 120],
                  labels: const [
                    "Start",
                    "Bronze",
                    "Silver",
                    "Gold",
                    "Diamond",
                  ],
                  progressColor: const Color(0xFFA47052),
                  trackColor: const Color(0xFFEDE2DC),
                  completedIcon: SvgPicture.asset(
                    "assets/images/check.svg",
                    width: 24,
                    height: 24,
                  ),
                  pendingIcon: SvgPicture.asset(
                    "assets/images/empty_check.svg",
                    width: 24,
                    height: 24,
                  ),
                  iconSize: 24,
                  onMilestoneTap: (i) =>
                      _showSnack(context, "SVG Milestone $i"),
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // 2- (Gamification - Flutter Icons)
              // =================================================
              const _SectionTitle("2. Gamification (Star Icons)"),
              _ShowcaseCard(
                color: Colors.white,
                child: CardPoints(
                  currentPoints: currentPoints,
                  milestones: const [0, 40, 80, 120],
                  labels: const ["Rookie", "Elite", "Master", "Legend"],
                  progressColor: Colors.amber,
                  trackColor: Colors.amber.withValues(alpha: 0.2),
                  // استخدام أيقونات فلاتر الجاهزة
                  completedIcon: const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  pendingIcon: Icon(
                    Icons.star_border,
                    color: Colors.amber.shade200,
                    size: 30,
                  ),
                  iconSize: 30,
                  onMilestoneTap: (i) => _showSnack(context, "Star Level $i"),
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // 3.(Loyalty - Different Shapes)
              // =================================================
              const _SectionTitle("3. Loyalty Rewards (Gift Icons)"),
              _ShowcaseCard(
                color: Colors.indigo.shade50,
                child: CardPoints(
                  currentPoints: currentPoints,
                  milestones: const [0, 50, 100, 150],
                  // labels: const ["Start", "50", "100", "150"],
                  progressColor: Colors.indigo,
                  trackColor: Colors.white,
                  completedIcon: const Icon(
                    Icons.card_giftcard,
                    color: Colors.indigo,
                    size: 24,
                  ),
                  pendingIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                    size: 24,
                  ),
                  iconSize: 34,
                  onMilestoneTap: (i) =>
                      _showSnack(context, "Gift #$i Unlocked!"),
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // 4.(Minimal - Circles)
              // =================================================
              const _SectionTitle("4. Order Tracking (Minimal)"),
              CardPoints(
                currentPoints: currentPoints,
                milestones: const [0, 40, 80, 120],
                labels: const ["Placed", "Packed", "Shipped", "Delivered"],
                progressColor: Colors.green,
                trackColor: Colors.grey.shade300,
                completedIcon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
                pendingIcon: const Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 12,
                ),
                iconSize: 20,
                onMilestoneTap: (i) => _showSnack(context, "Order Step $i"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset:  Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => setState(() => currentPoints = 0),
              icon: const Icon(
                Icons.refresh,
                color: Colors.white70,
                size: 20,
              ),
              tooltip: "Reset",
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 15),
            Text(
              "Pts: $currentPoints",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 35,
              height: 35,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 0,
                onPressed: () {
                  setState(() {
                    if (currentPoints < 160) currentPoints += 10;
                  });
                },
                mini: true,
                child: const Icon(Icons.add, color: Colors.black, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 800),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _ShowcaseCard extends StatelessWidget {
  final Widget child;
  final Color color;
  const _ShowcaseCard({required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
