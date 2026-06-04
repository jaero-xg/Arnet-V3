// lib/services/storage_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';

/// Comprehensive local storage service for persisting all app data.
/// Handles profile, module progress, quiz records, recent activities,
/// achievements, and appearance settings.
class StorageService {
  static const String _profileKey = 'learner_profile';
  static const String _modulesKey = 'modules_progress';
  static const String _appearanceKey = 'appearance_mode';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _firstLaunchKey = 'first_launch_date';
  static const String _lastActiveKey = 'last_active_date';
  static const String _streakKey = 'current_streak';
  static const String _lastNotificationKey = 'last_notification_date';

  static SharedPreferences? _prefs;

  /// Initialize the storage service. Call this in main() before runApp.
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    if (_prefs == null) {
      throw StateError(
        'StorageService not initialized. Call StorageService.initialize() first.',
      );
    }
    return _prefs!;
  }

  // ── Profile ───────────────────────────────────────────────────────────

  static Future<void> saveProfile(LearnerProfile profile) async {
    await _instance.setString(_profileKey, jsonEncode(profile.toMap()));
  }

  static LearnerProfile? loadProfile() {
    final json = _instance.getString(_profileKey);
    if (json == null) return null;
    try {
      return LearnerProfile.fromMap(jsonDecode(json));
    } catch (e) {
      return null;
    }
  }

  static Future<void> clearProfile() async {
    await _instance.remove(_profileKey);
  }

  // ── Module Progress ───────────────────────────────────────────────────

  static Future<void> saveModuleProgress(List<LearningModule> modules) async {
    final data = modules.map((m) => _moduleToJson(m)).toList();
    await _instance.setString(_modulesKey, jsonEncode(data));
  }

  static List<Map<String, dynamic>>? loadModuleProgress() {
    final json = _instance.getString(_modulesKey);
    if (json == null) return null;
    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> _moduleToJson(LearningModule module) {
    return {
      'id': module.id,
      'completedLessons': module.completedLessons,
      'lessons': module.lessons
          .map((l) => {
                'id': l.id,
                'isCompleted': l.isCompleted,
              })
          .toList(),
    };
  }

  // ── Appearance / Theme ────────────────────────────────────────────────

  static Future<void> saveAppearanceMode(String mode) async {
    await _instance.setString(_appearanceKey, mode);
  }

  static String? loadAppearanceMode() {
    return _instance.getString(_appearanceKey);
  }

  // ── Notifications ─────────────────────────────────────────────────────

  static Future<void> setNotificationsEnabled(bool enabled) async {
    await _instance.setBool(_notificationsKey, enabled);
  }

  static bool areNotificationsEnabled() {
    return _instance.getBool(_notificationsKey) ?? true;
  }

  // ── Activity Tracking ───────────────────────────────────────────────

  static Future<void> updateLastActive() async {
    final now = DateTime.now().toIso8601String();
    final lastActive = _instance.getString(_lastActiveKey);

    if (lastActive != null) {
      final lastDate = DateTime.parse(lastActive);
      final today = DateTime.now();
      final difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        // Consecutive day
        final currentStreak = _instance.getInt(_streakKey) ?? 0;
        await _instance.setInt(_streakKey, currentStreak + 1);
      } else if (difference > 1) {
        // Streak broken
        await _instance.setInt(_streakKey, 1);
      }
    } else {
      // First time active
      await _instance.setInt(_streakKey, 1);
    }

    await _instance.setString(_lastActiveKey, now);
  }

  static DateTime? getLastActive() {
    final str = _instance.getString(_lastActiveKey);
    return str != null ? DateTime.parse(str) : null;
  }

  static int getCurrentStreak() {
    return _instance.getInt(_streakKey) ?? 0;
  }

  static Future<void> setFirstLaunchDate() async {
    if (_instance.getString(_firstLaunchKey) == null) {
      await _instance.setString(
          _firstLaunchKey, DateTime.now().toIso8601String());
    }
  }

  static DateTime? getFirstLaunchDate() {
    final str = _instance.getString(_firstLaunchKey);
    return str != null ? DateTime.parse(str) : null;
  }

  // ── Notification Scheduling ─────────────────────────────────────────

  static Future<void> setLastNotificationDate(DateTime date) async {
    await _instance.setString(_lastNotificationKey, date.toIso8601String());
  }

  static DateTime? getLastNotificationDate() {
    final str = _instance.getString(_lastNotificationKey);
    return str != null ? DateTime.parse(str) : null;
  }

  // ── Clear All ───────────────────────────────────────────────────────

  static Future<void> clearAll() async {
    await _instance.clear();
  }
}
