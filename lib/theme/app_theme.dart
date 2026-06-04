// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ── Brand Colors (from ARNET logo) ──────────────────────────────────────
  static const Color primaryColor = Color(0xFF1B2B3A); // dark navy
  static const Color primaryLight = Color(0xFF243447); // mid navy
  static const Color primaryDark = Color(0xFF101E2B); // deeper navy
  static const Color accentColor = Color(0xFF5CD6E0); // cyan (logo highlight)
  static const Color tealColor =
      Color(0xFF00C2A8); // teal green (progress/success)
  static const Color dangerColor =
      Color(0xFFE05A5A); // coral red (alerts/errors)
  static const Color cyanTint =
      Color(0xFFC8E8EF); // light cyan (chips/badges bg)

  // ── Light Theme Surfaces ────────────────────────────────────────────────
  static const Color surfaceColorLight =
      Color(0xFFF4F8FA); // near-white scaffold
  static const Color cardColorLight = Color(0xFFFFFFFF); // pure white cards
  static const Color borderColorLight =
      Color(0xFFE0EEF2); // subtle cyan-tinted border

  // ── Dark Theme Surfaces ─────────────────────────────────────────────────
  static const Color surfaceColorDark = Color(0xFF0F1923); // deep navy scaffold
  static const Color cardColorDark = Color(0xFF1B2B3A); // slightly lighter navy
  static const Color borderColorDark = Color(0xFF2A3F52); // subtle border
  static const Color textPrimaryDark =
      Color(0xFFE8F4F8); // light cyan-white text
  static const Color textSecondaryDark = Color(0xFF8BAAB8); // muted cyan text

  // ── Semantic aliases (kept for backwards compat) ─────────────────────────
  static const Color successColor = tealColor;
  static const Color warningColor = Color(0xFFFFA726);

  // ── Light Theme ─────────────────────────────────────────────────────────
  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        surfaceColor: surfaceColorLight,
        cardColor: cardColorLight,
        borderColor: borderColorLight,
        textPrimary: primaryColor,
        textSecondary: const Color(0xFF4A6B7C),
        textTertiary: const Color(0xFF6B8FA0),
        textQuaternary: const Color(0xFF8BAAB8),
      );

  // ── Dark Theme ────────────────────────────────────────────────────────
  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        surfaceColor: surfaceColorDark,
        cardColor: cardColorDark,
        borderColor: borderColorDark,
        textPrimary: textPrimaryDark,
        textSecondary: textSecondaryDark,
        textTertiary: const Color(0xFF7A9BA8),
        textQuaternary: const Color(0xFF5A8A98),
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
        onSecondary: primaryDark,
        surfaceContainerHighest: cardColor,
      ),

      scaffoldBackgroundColor: surfaceColor,

      // ── Cards ────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 0.8),
        ),
      ),

      // ── AppBar ───────────────────────────────────────────────────────
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

      // ── Elevated Button ──────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: primaryDark,
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

      // ── Outlined Button ──────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? textPrimaryDark : primaryColor,
          minimumSize: const Size(double.infinity, 52),
          side: const BorderSide(color: accentColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // ── Text Button ────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentColor,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Input Fields ───────────────────────────────────────────────────
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
          borderSide: const BorderSide(color: accentColor, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dangerColor, width: 1.5),
        ),
        hintStyle: TextStyle(
          color: textQuaternary,
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── Bottom Navigation Bar ────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: accentColor.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: accentColor, size: 24);
          }
          return IconThemeData(color: textQuaternary, size: 22);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accentColor,
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

      // ── Chips ─────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? primaryLight : cyanTint,
        labelStyle: TextStyle(
          color: textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),

      // ── Progress Indicator ───────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accentColor,
        linearTrackColor: cyanTint,
        circularTrackColor: cyanTint,
      ),

      // ── Divider ───────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: borderColor,
        thickness: 0.8,
        space: 1,
      ),

      // ── List Tile ─────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: cardColor,
        textColor: textPrimary,
        iconColor: textQuaternary,
      ),

      // ── Dialog ────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // ── Typography ────────────────────────────────────────────────────
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
