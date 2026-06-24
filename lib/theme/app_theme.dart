import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════════
  //  BRAND PALETTE — Modern Navy
  //  Deep, premium navy with a vivid azure accent — formal but not dated.
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary: Deep Navy — formal, premium, trustworthy
  static const Color primaryColor = Color(0xFF0F2A5C);
  static const Color primaryLight = Color(0xFF1E4488);
  static const Color primaryDark = Color(0xFF081B40);

  /// Secondary: Royal Blue — used for gradients & highlights
  static const Color secondaryColor = Color(0xFF2E5CE6);

  /// Accent: Vivid Azure — interactive elements, links, focus states
  static const Color accentColor = Color(0xFF1A8FE3);

  /// Tertiary: Deep Teal — completion, progress, success accents
  static const Color tealColor = Color(0xFF0E7C7B);

  /// Danger: Modern Red — errors, removals, critical alerts
  static const Color dangerColor = Color(0xFFDC2626);
  static const Color dangerLight = Color(0xFFFEF2F2);

  /// Success: Forest Green — completions, correct answers, achievements
  static const Color successColor = Color(0xFF15803D);
  static const Color successLight = Color(0xFFF0FDF4);

  /// Warning: Muted Amber — cautions, pending states, deadlines
  static const Color warningColor = Color(0xFFB45309);
  static const Color warningLight = Color(0xFFFFFBEB);

  /// Info: Royal Blue — tips, hints, informational banners
  static const Color infoColor = Color(0xFF1D4ED8);
  static const Color infoLight = Color(0xFFEFF6FF);

  /// Gradient pair — for hero sections, buttons, active states
  static const List<Color> primaryGradient = [
    Color(0xFF0F2A5C),
    Color(0xFF1A8FE3),
  ];

  /// Soft tint used for progress-track backgrounds & icon containers
  static const Color greenTint = Color(0xFFE7EEF9);

  // ═══════════════════════════════════════════════════════════════════════════
  //  LIGHT THEME SURFACES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Background: Cool slate-white — crisp, professional
  static const Color surfaceColorLight = Color(0xFFF6F8FB);
  static const Color cardColorLight = Color(0xFFFFFFFF);
  static const Color borderColorLight = Color(0xFFE3E8F0);
  static const Color dividerColorLight = Color(0xFFEDF1F6);

  // Text hierarchy — light mode
  static const Color textPrimaryLight = Color(0xFF0B1426); // Headings, body
  static const Color textSecondaryLight = Color(0xFF35415A); // Subheadings
  static const Color textTertiaryLight = Color(0xFF5B6884); // Captions, meta
  static const Color textQuaternaryLight =
      Color(0xFF94A0B8); // Placeholders, disabled
  static const Color textInverseLight = Color(0xFFFFFFFF); // On dark buttons

  // ═══════════════════════════════════════════════════════════════════════════
  //  DARK THEME SURFACES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Background: Midnight navy — deep, not flat black
  static const Color surfaceColorDark = Color(0xFF070D1A);
  static const Color cardColorDark = Color(0xFF101A30);
  static const Color borderColorDark = Color(0xFF1C2A45);
  static const Color dividerColorDark = Color(0xFF16213A);

  // Text hierarchy — dark mode (higher luminance for equivalent perceived weight)
  static const Color textPrimaryDark = Color(0xFFF1F4FA); // Headings
  static const Color textSecondaryDark = Color(0xFFAEB9CE); // Subheadings
  static const Color textTertiaryDark = Color(0xFF7A87A3); // Captions
  static const Color textQuaternaryDark = Color(0xFF4A5673); // Placeholders
  static const Color textInverseDark = Color(0xFF070D1A); // On light buttons

  // ═══════════════════════════════════════════════════════════════════════════
  //  UTILITY / OVERLAY
  // ═══════════════════════════════════════════════════════════════════════════
  static const Color overlayLight = Color(0x8014141F); // 50% dark overlay
  static const Color overlayDark = Color(0xCC000000); // 80% black overlay
  static const Color shadowLight = Color(0x1414141F); // Subtle shadow
  static const Color shadowDark = Color(0x40000000); // Elevated shadow

  // ═══════════════════════════════════════════════════════════════════════════
  //  THEME DATA FACTORIES
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        surfaceColor: surfaceColorLight,
        cardColor: cardColorLight,
        borderColor: borderColorLight,
        dividerColor: dividerColorLight,
        textPrimary: textPrimaryLight,
        textSecondary: textSecondaryLight,
        textTertiary: textTertiaryLight,
        textQuaternary: textQuaternaryLight,
        textInverse: textInverseLight,
        overlay: overlayLight,
        shadow: shadowLight,
        primary: primaryColor,
        primaryContainer: primaryLight,
        onPrimaryContainer: textInverseLight,
        error: dangerColor,
        errorContainer: dangerLight,
        success: successColor,
        successContainer: successLight,
        warning: warningColor,
        warningContainer: warningLight,
        info: infoColor,
        infoContainer: infoLight,
      );

  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        surfaceColor: surfaceColorDark,
        cardColor: cardColorDark,
        borderColor: borderColorDark,
        dividerColor: dividerColorDark,
        textPrimary: textPrimaryDark,
        textSecondary: textSecondaryDark,
        textTertiary: textTertiaryDark,
        textQuaternary: textQuaternaryDark,
        textInverse: textInverseDark,
        overlay: overlayDark,
        shadow: shadowDark,
        primary: const Color(0xFF5B9CE8), // Lighter azure-navy for dark bg
        primaryContainer: const Color(0xFF1E335C),
        onPrimaryContainer: textPrimaryDark,
        error: const Color(0xFFF87171), // Softened red
        errorContainer: const Color(0xFF3A1414),
        success: const Color(0xFF4ADE80), // Softened green
        successContainer: const Color(0xFF0F2E1C),
        warning: const Color(0xFFFBBF24), // Softened amber
        warningContainer: const Color(0xFF3A2607),
        info: const Color(0xFF5B9CE8), // Softened azure
        infoContainer: const Color(0xFF132240),
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color surfaceColor,
    required Color cardColor,
    required Color borderColor,
    required Color dividerColor,
    required Color textPrimary,
    required Color textSecondary,
    required Color textTertiary,
    required Color textQuaternary,
    required Color textInverse,
    required Color overlay,
    required Color shadow,
    required Color primary,
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color error,
    required Color errorContainer,
    required Color success,
    required Color successContainer,
    required Color warning,
    required Color warningContainer,
    required Color info,
    required Color infoContainer,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,

      // ── Color Scheme ──────────────────────────────────────────────────────
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        surface: surfaceColor,
      ).copyWith(
        primary: primary,
        onPrimary: textInverse,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: accentColor,
        onSecondary: textInverse,
        secondaryContainer:
            isDark ? const Color(0xFF0F2E40) : const Color(0xFFE4F2FC),
        onSecondaryContainer: isDark ? textPrimaryDark : accentColor,
        tertiary: tealColor,
        onTertiary: textInverse,
        tertiaryContainer:
            isDark ? const Color(0xFF0F2E22) : const Color(0xFFE3FAEF),
        onTertiaryContainer: isDark ? textPrimaryDark : tealColor,
        error: error,
        onError: textInverse,
        errorContainer: errorContainer,
        onErrorContainer: isDark ? const Color(0xFFFECACA) : dangerColor,
        surface: surfaceColor,
        onSurface: textPrimary,
        surfaceContainerHighest: cardColor,
        onSurfaceVariant: textSecondary,
        outline: borderColor,
        outlineVariant: dividerColor,
        shadow: shadow,
        scrim: overlay,
      ),

      scaffoldBackgroundColor: surfaceColor,

      // ── Cards ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: borderColor, width: 0.6),
        ),
      ),

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 19,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: textPrimary, size: 24),
        actionsIconTheme: IconThemeData(color: textSecondary, size: 24),
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),

      // ── Bottom App Bar ─────────────────────────────────────────────────────
      bottomAppBarTheme: BottomAppBarThemeData(
        color: cardColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: shadow,
      ),

      // ── Elevated Button ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textInverse,
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Filled Button ─────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textInverse,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? textPrimary : primaryColor,
          minimumSize: const Size(double.infinity, 52),
          side: BorderSide(
              color: isDark ? borderColor : primaryColor, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Text Button ───────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Icon Button ─────────────────────────────────────────────────────
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: textSecondary,
          backgroundColor: Colors.transparent,
          hoverColor: primary.withValues(alpha: 0.06),
          highlightColor: primary.withValues(alpha: 0.10),
        ),
      ),

      // ── Input Fields ──────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? cardColor : const Color(0xFFF3F3F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: error, width: 1.4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: error, width: 1.8),
        ),
        hintStyle: TextStyle(
          color: textQuaternary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: textTertiary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        prefixIconColor: textQuaternary,
        suffixIconColor: textTertiary,
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primary,
        unselectedItemColor: textQuaternary,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: textQuaternary,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),

      // ── Navigation Bar (Material 3) ───────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: primary.withValues(alpha: isDark ? 0.18 : 0.10),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: primary, size: 24);
          }
          return IconThemeData(color: textQuaternary, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primary,
              letterSpacing: 0.2,
            );
          }
          return TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: textQuaternary,
            letterSpacing: 0.2,
          );
        }),
        elevation: 0,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),

      // ── Chips ─────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? primaryContainer.withValues(alpha: 0.5)
            : const Color(0xFFE7ECF7),
        labelStyle: TextStyle(
          color: isDark ? textPrimaryDark : primaryColor,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        selectedColor: primary,
        checkmarkColor: textInverse,
        secondaryLabelStyle: TextStyle(
          color: textInverse,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ── Progress Indicator ────────────────────────────────────────────────
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: isDark ? borderColorDark : const Color(0xFFE9E9F5),
        circularTrackColor: isDark ? borderColorDark : const Color(0xFFE9E9F5),
        linearMinHeight: 4,
      ),

      // ── Slider ────────────────────────────────────────────────────────────
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: isDark ? borderColorDark : const Color(0xFFE9E9F5),
        thumbColor: primary,
        overlayColor: primary.withValues(alpha: 0.12),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),

      // ── Divider ───────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: dividerColor,
        thickness: 0.6,
        space: 1,
        indent: 0,
        endIndent: 0,
      ),

      // ── List Tile ─────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: textPrimary,
        iconColor: textSecondary,
        selectedTileColor: primary.withValues(alpha: isDark ? 0.08 : 0.04),
        selectedColor: primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minLeadingWidth: 32,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ── Dialog ────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
      ),

      // ── Bottom Sheet ──────────────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        elevation: 0,
        dragHandleColor: textQuaternary,
        dragHandleSize: const Size(40, 4),
      ),

      // ── SnackBar ──────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor:
            isDark ? const Color(0xFF26263A) : const Color(0xFF1E1E2E),
        contentTextStyle: TextStyle(
          color: textInverse,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        insetPadding: const EdgeInsets.all(16),
      ),

      // ── Tooltip ───────────────────────────────────────────────────────────
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF26263A) : const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: textInverse,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        preferBelow: true,
      ),

      // ── Switch ────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return isDark ? const Color(0xFF53536A) : const Color(0xFFD8D8E8);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary.withValues(alpha: 0.35);
          }
          return isDark ? const Color(0xFF2A2A3A) : const Color(0xFFE9E9F5);
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      // ── Checkbox ──────────────────────────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(textInverse),
        side: BorderSide(color: textQuaternary, width: 1.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      // ── Radio ─────────────────────────────────────────────────────────────
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return textQuaternary;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      // ── Typography ────────────────────────────────────────────────────────
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.8,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.6,
          height: 1.2,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.4,
          height: 1.3,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.2,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.1,
          height: 1.4,
        ),
        titleLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.1,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textSecondary,
          fontWeight: FontWeight.w400,
          height: 1.6,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textTertiary,
          fontWeight: FontWeight.w400,
          height: 1.6,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: textQuaternary,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0.1,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textQuaternary,
          letterSpacing: 0.2,
          height: 1.4,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  AVATAR DATA — kept for compatibility
// ═══════════════════════════════════════════════════════════════════════════
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
