import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/dhikr/presentation/screens/dhikr_counter_screen.dart';

class DhikrCounterApp extends StatelessWidget {
  const DhikrCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhikr Counter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DhikrCounterScreen(),
    );
  }
}
