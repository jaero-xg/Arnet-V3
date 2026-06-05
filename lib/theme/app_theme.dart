// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ── Brand Colors ──────────────────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF3E6EA8);
  static const Color primaryLight = Color(0xFF5B86BB);
  static const Color primaryDark = Color(0xFF2E5786);
  static const Color accentColor = Color(0xFF4A7BB8);
  static const Color tealColor = Color(0xFF4F8FA8);
  static const Color dangerColor = Color(0xFFE05A5A);
  static const Color greenTint = Color(0xFFEAF1F9);

  // ── Light Theme Surfaces ──────────────────────────────────────────────────
  static const Color surfaceColorLight = Color(0xFFF8FAFC);
  static const Color cardColorLight = Color(0xFFFFFFFF);
  static const Color borderColorLight = Color(0xFFE2E8F0);

  // ── Dark Theme Surfaces ───────────────────────────────────────────────────
  static const Color surfaceColorDark = Color(0xFF0B1220);
  static const Color cardColorDark = Color(0xFF131C2B);
  static const Color borderColorDark = Color(0xFF243244);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFB6C2D1);

  // ── Semantic aliases ──────────────────────────────────────────────────────
  static const Color successColor = Color.fromARGB(255, 2, 95, 0);
  static const Color warningColor = Color(0xFFF4A261);

  // ── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        surfaceColor: surfaceColorLight,
        cardColor: cardColorLight,
        borderColor: borderColorLight,
        textPrimary: const Color(0xFF101820),
        textSecondary: const Color(0xFF4A5560),
        textTertiary: const Color(0xFF6C7078),
        textQuaternary: const Color(0xFF9AA0A8),
      );

  // ── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        surfaceColor: surfaceColorDark,
        cardColor: cardColorDark,
        borderColor: borderColorDark,
        textPrimary: textPrimaryDark,
        textSecondary: textSecondaryDark,
        textTertiary: const Color(0xFF7A8E98),
        textQuaternary: const Color(0xFF566878),
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color surfaceColor,
    required Color cardColor,
    required Color borderColor,
    required Color textPrimary,
    required Color textSecondary,
    required Color textTertiary,
    required Color textQuaternary,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        surface: surfaceColor,
      ).copyWith(
        primary: primaryColor,
        secondary: accentColor,
        tertiary: tealColor,
        error: dangerColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surfaceContainerHighest: cardColor,
      ),

      scaffoldBackgroundColor: surfaceColor,

      // ── Cards ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 0.8),
        ),
      ),

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: cardColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textPrimary),
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),

      // ── Elevated Button ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? textPrimaryDark : primaryColor,
          minimumSize: const Size(double.infinity, 52),
          side: const BorderSide(color: primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // ── Text Button ───────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Input Fields ──────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dangerColor, width: 1.5),
        ),
        hintStyle: TextStyle(color: textQuaternary, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: primaryColor.withValues(alpha: 0.12),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor, size: 24);
          }
          return IconThemeData(color: textQuaternary, size: 22);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textQuaternary,
          );
        }),
        elevation: 1,
      ),

      // ── Chips ─────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? primaryDark.withValues(alpha: 0.35) : greenTint,
        labelStyle: TextStyle(
          color: isDark ? textPrimaryDark : primaryDark,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),

      // ── Progress Indicator ────────────────────────────────────────────────
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: greenTint,
        circularTrackColor: isDark ? borderColorDark : greenTint,
      ),

      // ── Divider ───────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: borderColor,
        thickness: 0.8,
        space: 1,
      ),

      // ── List Tile ─────────────────────────────────────────────────────────
      // FIX: tileColor is intentionally NOT set (left null/transparent).
      // Setting tileColor: cardColor causes ListTile to paint a solid
      // rectangle that bleeds past parent container's borderRadius even
      // when clipBehavior: Clip.hardEdge is present, because the color
      // is applied before the clip in the render pipeline on some tiles.
      // With tileColor unset, ListTile inherits the parent's background
      // transparently and the rounded corners are always respected.
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: textPrimary,
        iconColor: primaryColor,
      ),

      // ── Dialog ────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // ── Typography ────────────────────────────────────────────────────────
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          color: textSecondary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textTertiary,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: textQuaternary,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          color: textQuaternary,
        ),
      ),
    );
  }
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
