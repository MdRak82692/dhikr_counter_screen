# Dhikr Counter - Premium Flutter Screen

A high-fidelity, interactive Dhikr Counter screen built with Flutter and Riverpod. This project was designed for a job assessment, focusing on clean architecture, premium UI/UX, and robust state management.

![Dhikr Counter Screen Mockup](https://raw.githubusercontent.com/MdRak82692/dhikr_counter_screen/main/screenshot.png) _(Note: Replace with actual screenshot after running)_

## ✨ Features

- **Premium Islamic Aesthetic**: Dark theme with gold/yellow glow accents and elegant typography.
- **Interactive Counter**: Tap the central glowing circular area to increment the count.
- **Real-time Progress**: Session goal tracking with percentage and progress indicators.
- **Global Stats**: Mocked "Global Live Count" and "Total Recitations Today" for a social/connected feel.
- **Responsive Design**: Adapts beautifully to various screen sizes.
- **Reset Functionality**: Easy reset action to restart the session.
- **Clean Architecture**: Organized into features, domain, and presentation layers.

## 🚀 How to Run

1. **Prerequisites**:
   - Flutter SDK installed.
   - Android Studio or VS Code with Flutter extensions.
2. **Clone/Download the project**.
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   ```bash
   flutter run
   ```

## 📦 Dependencies

- `flutter_riverpod`: For modern, testable, and robust state management.
- `google_fonts`: To provide premium typography (Inter for English, Amiri for Arabic).
- `intl`: For number formatting (e.g., 2,841,092).

## 📂 Folder Structure

The project follows a modified Clean Architecture / Feature-First approach:

```text
lib/
├── core/
│   ├── constants/    # App-wide constants like AppColors
│   └── theme/        # Theme definitions (AppTheme)
├── features/
│   └── dhikr/
│       ├── domain/
│       │   └── models/      # DhikrState model
│       └── presentation/
│           ├── providers/   # Riverpod Notifier and Providers
│           ├── screens/     # DhikrCounterScreen
│           └── widgets/     # Reusable UI like GlowingCounter
├── main.dart             # Entry point
└── app.dart              # MaterialApp & Theme configuration
```

## 🧠 Riverpod State Management

This app uses `StateNotifierProvider` to manage the `DhikrState`.

- **DhikrState**: An immutable model containing the current count, goal, and metadata (Arabic, translation).
- **DhikrNotifier**: Manages state transitions like `increment()`, `reset()`, and `updateGoal()`.
- Why Riverpod? It ensures the UI stays in sync with the state and allows for easy testing and debugging without the overhead of context.

## 🛠 Assumptions & Improvements

### Assumptions

- The "Global Live Count" is a mock value for demonstration purposes.
- The "Back" button and "Change to Voice" are UI placeholders for this assessment.
- All translations and Arabic text are statically provided as part of the initial state.

### Improvements Beyond Reference

- **Glow Effects**: Enhanced the central counter with multi-layered circular glows to give it a "vibrant" feel.
- **Micro-interactions**: Added subtle scale-up/haptics logic (optional enhancement) if targeting a real device.
- **Reset Logic**: Integrated a quick-access reset button in the header.
- **Typography**: Specifically chose `Amiri` for Arabic to ensure the spiritual aesthetic is maintained.

## 🏗 Build Release APK

To generate a production-ready APK, run:

```bash
flutter build apk --release
```

The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`.

## 🎥 Demo Checklist

If you are recording a screen demo, here is the recommended flow:

- [ ] Open the app - show the initial splash of the dark/gold theme.
- [ ] Tap the circular area repeatedly to show incrementing animation.
- [ ] Observe the "Session Goal" numbers and percentage updating in real-time.
- [ ] Tap the Reset icon in the top right to show State management working.
- [ ] Highlight the responsive text (Arabic vs English) and the glow effect.
