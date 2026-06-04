// lib/state/appearance_notifier.dart

import 'package:flutter/material.dart';
import '../services/storage_service.dart';

enum AppearanceMode { system, light, dark }

/// Manages the app-wide theme mode with persistent storage.
///
/// Register in your ChangeNotifierProvider tree (e.g. main.dart) and
/// read [themeMode] in your MaterialApp's `themeMode` parameter.
///
/// Example in main.dart:
/// ```dart
/// MultiProvider(
///   providers: [
///     ChangeNotifierProvider(create: (_) => AppState()),
///     ChangeNotifierProvider(create: (_) => AppearanceNotifier()),
///   ],
///   child: Consumer<AppearanceNotifier>(
///     builder: (context, appearance, _) => MaterialApp(
///       themeMode: appearance.themeMode,
///       theme: AppTheme.lightTheme,
///       darkTheme: AppTheme.darkTheme,
///       home: const MainShell(),
///     ),
///   ),
/// );
/// ```
class AppearanceNotifier extends ChangeNotifier {
  AppearanceMode _mode;

  AppearanceNotifier() : _mode = _loadSavedMode();

  AppearanceMode get mode => _mode;

  ThemeMode get themeMode {
    switch (_mode) {
      case AppearanceMode.system:
        return ThemeMode.system;
      case AppearanceMode.light:
        return ThemeMode.light;
      case AppearanceMode.dark:
        return ThemeMode.dark;
    }
  }

  void setMode(AppearanceMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    StorageService.saveAppearanceMode(mode.name);
    notifyListeners();
  }

  static AppearanceMode _loadSavedMode() {
    final saved = StorageService.loadAppearanceMode();
    if (saved == null) return AppearanceMode.system;
    return AppearanceMode.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppearanceMode.system,
    );
  }
}
