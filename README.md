# Reward Progress Bar 🏆

A highly customizable, animated progress bar widget for Flutter. Perfect for **Gamification**, **Loyalty Programs**, **Order Tracking**, and step-based processes.

This package allows you to create milestone-based progress bars where lines do not overlap with transparent icons, ensuring a clean and professional UI. It supports **Any Widget** as an icon (SVG, Image, Icon, Text).

## 🎥 Preview

![Reward Progress Bar Demo](assets/screenshots/demo.gif)
## ✨ Features

* **🚀 Animated Progress:** Smooth transitions when updating points.
* **📍 Milestone Based:** Breaks down progress into distinct stages (e.g., Bronze, Silver, Gold).
* **🎨 Fully Customizable:** Control colors, sizes, line thickness, and curves.
* **🧩 Flexible Icons:** Use standard `Icons`, `SvgPicture`, `Images`, or any custom widget.
* **🏷️ Label Support:** Add text labels under each milestone.
* **👆 Interactive:** Support for `onMilestoneTap` to handle user interactions.
* **🚫 No Overflow Issues:** optimized layout to handle various sizes without crashing.

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  reward_progress_bar: ^0.0.1

Then run:
flutter pub get

🚀 Usage
Import the package:

import 'package:reward_progress_bar/reward_progress_bar.dart';

1. Basic Usage (Default Icons)
The simplest way to use the package. It uses default check icons.
CardPoints(
  currentPoints: 45,
  milestones: const [0, 30, 60, 90],
)

2. Full Customization (Gamification Style)
Example with custom icons (Stars), labels, colors, and tap interaction.

CardPoints(
  currentPoints: 75,
  milestones: const [0, 50, 100, 150, 200],
  labels: const ["Start", "Bronze", "Silver", "Gold", "Diamond"],
  progressColor: Colors.amber,
  trackColor: Colors.amber.withOpacity(0.2),
  iconSize: 30,
  lineHeight: 8,
  // You can use any widget here (Icon, SvgPicture, Image)
  completedIcon: const Icon(Icons.star, color: Colors.amber, size: 30),
  pendingIcon: Icon(Icons.star_border, color: Colors.amber.shade200, size: 30),
  onMilestoneTap: (index) {
    print("Clicked on milestone index: $index");
  },
)


3. Using SVG Assets
To use SVGs, simply pass SvgPicture.asset to the icon properties:

CardPoints(
  currentPoints: 60,
  milestones: const [0, 50, 100],
  completedIcon: SvgPicture.asset("assets/check.svg", width: 24, height: 24),
  pendingIcon: SvgPicture.asset("assets/lock.svg", width: 24, height: 24),
)


| ⚙️ Property      | Type             | Default               | Description                                   |
| ---------------- | ---------------- | --------------------- | --------------------------------------------- |
| `currentPoints`  | `int`            | Required              | The current value of progress                 |
| `milestones`     | `List<int>`      | `[0, 10, 20, 30, 40]` | List of values representing each milestone    |
| `labels`         | `List<String>?`  | null                  | Optional text to display under each milestone |
| `progressColor`  | `Color`          | `Colors.blue`         | Color of the active progress line             |
| `trackColor`     | `Color?`         | null                  | Color of the inactive background line         |
| `completedIcon`  | `Widget?`        | null                  | Widget displayed for reached milestones       |
| `pendingIcon`    | `Widget?`        | null                  | Widget displayed for unreached milestones     |
| `iconSize`       | `double`         | 24.0                  | Size of the milestone icons                   |
| `onMilestoneTap` | `Function(int)?` | null                  | Callback when a milestone is tapped           |



🤝 Contributing
Contributions are welcome! If you find a bug or want to add a feature, please open an issue or submit a pull request.
