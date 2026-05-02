import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

/// A clean, professional design system for the formrules showcase.
abstract class AppTheme {
  // ── Background
  static const Color bgPrimary = Color(0xFF0D1117);
  static const Color bgSurface = Color(0xFF161B22);

  // ── Brand / Accent
  static const Color accent = Color(0xFF3B82F6);
  static const Color accentDim = Color(0x263B82F6);

  // ── Text
  static const Color textPrimary = Color(0xFFF0F6FC);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF484F58);

  // ── Border
  static const Color border = Color(0xFF30363D);
  static const Color borderFocus = Color(0xFF3B82F6);

  // ── State
  static const Color success = Color(0xFF238636);
  static const Color error = Color(0xFFDA3633);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'formrules — Flutter Validation Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.bgPrimary,
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.accent,
          surface: AppTheme.bgSurface,
          error: AppTheme.error,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppTheme.textPrimary, fontSize: 14),
          bodySmall: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
