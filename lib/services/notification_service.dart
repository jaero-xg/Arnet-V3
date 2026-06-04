// lib/services/notification_service.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:flutter_timezone/flutter_timezone.dart';
import '../models/app_models.dart';

/// Service for managing local notifications to encourage learning.
/// Sends reminders for daily learning streaks, completed modules, and
/// recommended next lessons.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  /// Initialize notification channels and permissions.
  static Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone data
    tz_data.initializeTimeZones();
    final String timeZoneName =
        (await FlutterTimezone.getLocalTimezone()).identifier;
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      macOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _initialized = true;
  }

  static void _onNotificationTap(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
  }

  // ── Permission ────────────────────────────────────────────────────────

  static Future<bool> requestPermissions() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  // ── Notification Channels ───────────────────────────────────────────

  static const String _channelId = 'arnet_learning_channel';
  static const String _channelName = 'ARNet Learning';
  static const String _channelDesc =
      'Reminders and updates for your learning journey';

  static NotificationDetails _notificationDetails({String? payload}) {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
        styleInformation: BigTextStyleInformation(''),
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  // ── Show Immediate Notifications ────────────────────────────────────

  /// Show a welcome notification when profile is first created.
  static Future<void> showWelcomeNotification(String name) async {
    await _notifications.show(
      0,
      'Welcome to ARNet, $name! 🎓',
      'Your learning journey starts now. Explore modules and earn achievements.',
      _notificationDetails(payload: 'welcome'),
    );
  }

  /// Show notification when a module is completed.
  static Future<void> showModuleCompleteNotification(
    LearningModule module,
  ) async {
    await _notifications.show(
      1,
      'Module Completed! 🏆',
      'Congratulations on finishing "${module.title}". Ready for the next challenge?',
      _notificationDetails(payload: 'module_complete:${module.id}'),
    );
  }

  /// Show notification when a quiz is passed with high score.
  static Future<void> showQuizSuccessNotification(
    String lessonTitle,
    int score,
  ) async {
    await _notifications.show(
      2,
      'Quiz Passed! 🌟',
      'You scored $score% on "$lessonTitle". Great job!',
      _notificationDetails(payload: 'quiz_success'),
    );
  }

  /// Show notification for learning streak reminder.
  static Future<void> showStreakReminder(int streakDays) async {
    await _notifications.show(
      3,
      'Keep Your Streak Alive! 🔥',
      'You\'re on a $streakDays-day learning streak. Don\'t break it today!',
      _notificationDetails(payload: 'streak_reminder'),
    );
  }

  /// Show notification with recommended next lesson.
  static Future<void> showNextLessonRecommendation(
    Lesson lesson,
    LearningModule module,
  ) async {
    await _notifications.show(
      4,
      'Continue Learning 📚',
      'Next up: "${lesson.subtitle}" in ${module.title}. Tap to resume!',
      _notificationDetails(payload: 'lesson:${lesson.id}:${module.id}'),
    );
  }

  /// Show daily learning reminder.
  static Future<void> showDailyReminder() async {
    await _notifications.show(
      5,
      'Time to Learn! 🧠',
      'Spend a few minutes today expanding your network knowledge with ARNet.',
      _notificationDetails(payload: 'daily_reminder'),
    );
  }

  // ── Scheduled Notifications ─────────────────────────────────────────

  /// Schedule daily learning reminder at a specific time.
  static Future<void> scheduleDailyReminder({
    int hour = 9,
    int minute = 0,
  }) async {
    await _notifications.zonedSchedule(
      100,
      'Daily Learning Reminder ⏰',
      'Consistency is key! Open ARNet and continue your network learning journey.',
      _nextInstanceOfTime(hour, minute),
      _notificationDetails(payload: 'scheduled_daily'),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule a streak reminder if user hasn't opened app today.
  static Future<void> scheduleStreakReminder(int currentStreak) async {
    final now = DateTime.now();
    final evening = DateTime(now.year, now.month, now.day, 20, 0);

    if (evening.isAfter(now)) {
      await _notifications.zonedSchedule(
        101,
        'Evening Streak Check 🔥',
        'You have a $currentStreak-day streak! Open ARNet today to keep it going.',
        tz.TZDateTime.from(evening, tz.local),
        _notificationDetails(payload: 'streak_check'),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  /// Cancel all scheduled notifications.
  static Future<void> cancelAllScheduled() async {
    await _notifications.cancelAll();
  }

  /// Cancel a specific notification by ID.
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // ── Helper ─────────────────────────────────────────────────────────

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
