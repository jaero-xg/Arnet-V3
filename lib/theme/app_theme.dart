// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF455A64); // blue-grey
  static const Color primaryLight = Color(0xFF78909C);
  static const Color primaryDark = Color(0xFF263238);
  static const Color accentColor = Color(0xFF546E7A);
  static const Color surfaceColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color successColor = Color(0xFF66BB6A);
  static const Color warningColor = Color(0xFFFFA726);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
          surface: surfaceColor,
        ).copyWith(
          primary: primaryColor,
          secondary: accentColor,
          surface: surfaceColor,
        ),
        scaffoldBackgroundColor: surfaceColor,
        cardTheme: CardThemeData(
          color: cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFE0E0E0), width: 0.8),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: primaryDark,
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: primaryColor.withValues(alpha: 0.5),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          elevation: 1,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: primaryDark),
          headlineSmall: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: primaryDark),
          titleLarge: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: primaryDark),
          titleMedium: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: primaryDark),
          bodyLarge:
              TextStyle(fontSize: 15, color: Color(0xFF37474F), height: 1.6),
          bodyMedium:
              TextStyle(fontSize: 14, color: Color(0xFF546E7A), height: 1.5),
          labelSmall: TextStyle(fontSize: 12, color: Color(0xFF78909C)),
        ),
      );
}

const List<Map<String, dynamic>> avatarList = [
  {'emoji': '👨‍🎓', 'label': 'Graduate'},
  {'emoji': '👩‍🎓', 'label': 'Graduate'},
  {'emoji': '👨‍🔬', 'label': 'Scientist'},
  {'emoji': '👩‍🔬', 'label': 'Scientist'},
  {'emoji': '👨‍💻', 'label': 'Coder'},
  {'emoji': '👩‍💻', 'label': 'Coder'},
  {'emoji': '🧑‍🏫', 'label': 'Teacher'},
  {'emoji': '👨‍⚕️', 'label': 'Doctor'},
  {'emoji': '👩‍⚕️', 'label': 'Doctor'},
];
