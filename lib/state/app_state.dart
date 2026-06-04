// lib/state/app_state.dart

import 'package:flutter/foundation.dart';
import '../models/app_models.dart';
import '../data/sample_data.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class AppState extends ChangeNotifier {
  LearnerProfile? _profile;
  List<LearningModule> _modules = [];
  List<Model3D> _models = [];

  LearnerProfile? get profile => _profile;
  List<LearningModule> get modules => _modules;
  List<Model3D> get models => _models;
  bool get hasProfile => _profile != null;

  AppState() {
    _loadData();
  }

  Future<void> _loadData() async {
    // Load profile from persistent storage
    _profile = StorageService.loadProfile();

    // Initialize modules from sample data
    _modules = List.from(sampleModules);
    _models = List.from(sampleModels);

    // Apply saved progress to modules
    final savedProgress = StorageService.loadModuleProgress();
    if (savedProgress != null) {
      for (final progress in savedProgress) {
        final module = _modules.firstWhere(
          (m) => m.id == progress['id'],
          orElse: () => _modules.first,
        );
        if (module.id == progress['id']) {
          module.applyProgress(progress);
        }
      }
    }

    // Update streak and check for notifications
    await StorageService.updateLastActive();
    await _checkStreakNotifications();

    notifyListeners();
  }

  Future<void> _checkStreakNotifications() async {
    if (_profile == null) return;

    final lastNotif = StorageService.getLastNotificationDate();
    final now = DateTime.now();

    // Only send one notification per day
    if (lastNotif == null || !_isSameDay(lastNotif, now)) {
      final streak = StorageService.getCurrentStreak();
      if (streak > 0) {
        await NotificationService.showStreakReminder(streak);
        await StorageService.setLastNotificationDate(now);
      }
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _saveAll() async {
    if (_profile != null) {
      await StorageService.saveProfile(_profile!);
    }
    await StorageService.saveModuleProgress(_modules);
  }

  // ── Profile Management ────────────────────────────────────────────────

  Future<void> createProfile(String name, int avatarIndex) async {
    _profile = LearnerProfile(
      name: name,
      avatarIndex: avatarIndex,
      dateCreated: DateTime.now(),
      achievements: ['First Login'],
    );

    await StorageService.setFirstLaunchDate();
    await _saveAll();

    // Show welcome notification
    await NotificationService.showWelcomeNotification(name);
    await NotificationService.scheduleDailyReminder(hour: 9, minute: 0);

    notifyListeners();
  }

  Future<void> updateProfile(String name, int avatarIndex) async {
    if (_profile == null) return;

    _profile = LearnerProfile(
      name: name,
      avatarIndex: avatarIndex,
      dateCreated: _profile!.dateCreated,
      modulesCompleted: _profile!.modulesCompleted,
      lessonsCompleted: _profile!.lessonsCompleted,
      arSessions: _profile!.arSessions,
      averageQuizScore: _profile!.averageQuizScore,
      recentLessons: _profile!.recentLessons,
      quizRecords: _profile!.quizRecords,
      recentModels: _profile!.recentModels,
      achievements: _profile!.achievements,
    );

    await _saveAll();
    notifyListeners();
  }

  // ── Lesson Progress ─────────────────────────────────────────────────

  Future<void> markLessonComplete(String moduleId, String lessonId) async {
    final module = _modules.firstWhere((m) => m.id == moduleId);
    final lesson = module.lessons.firstWhere((l) => l.id == lessonId);

    if (!lesson.isCompleted) {
      lesson.isCompleted = true;
      module.completedLessons++;

      _profile?.lessonsCompleted++;
      _profile?.recentLessons.insert(
        0,
        RecentActivity(title: lesson.subtitle, date: DateTime.now()),
      );

      // Keep only last 20 recent lessons
      if (_profile!.recentLessons.length > 20) {
        _profile!.recentLessons = _profile!.recentLessons.take(20).toList();
      }

      // Check if module completed
      if (module.completedLessons == module.lessons.length) {
        _profile?.modulesCompleted++;
        _profile?.achievements.add('Module Complete: ${module.title}');

        // Show completion notification
        await NotificationService.showModuleCompleteNotification(module);

        // Check for next module recommendation
        final currentIndex = _modules.indexWhere((m) => m.id == moduleId);
        if (currentIndex < _modules.length - 1) {
          final nextModule = _modules[currentIndex + 1];
          if (nextModule.lessons.isNotEmpty) {
            await NotificationService.showNextLessonRecommendation(
              nextModule.lessons.first,
              nextModule,
            );
          }
        }
      }

      await _saveAll();
      notifyListeners();
    }
  }

  // ── Quiz Results ────────────────────────────────────────────────────

  Future<void> recordQuizResult(String quizTitle, int score, int total) async {
    final percentage = total > 0 ? (score / total) * 100 : 0;

    _profile?.quizRecords.insert(
      0,
      QuizRecord(
        title: quizTitle,
        score: score,
        total: total,
        date: DateTime.now(),
      ),
    );

    // Keep only last 50 quiz records
    if (_profile!.quizRecords.length > 50) {
      _profile!.quizRecords = _profile!.quizRecords.take(50).toList();
    }

    // Recalculate average
    final allScores = _profile?.quizRecords.map((r) => r.percentage) ?? [];
    if (allScores.isNotEmpty) {
      _profile?.averageQuizScore =
          allScores.reduce((a, b) => a + b) / allScores.length;
    }

    // Achievement for perfect score
    if (score == total && total > 0) {
      _profile?.achievements.add('Perfect Score: $quizTitle');
    }

    // Show notification for good scores
    if (percentage >= 80) {
      await NotificationService.showQuizSuccessNotification(quizTitle, percentage.toInt());
    }

    await _saveAll();
    notifyListeners();
  }

  // ── Model Views ─────────────────────────────────────────────────────

  Future<void> recordModelViewed(String modelName) async {
    _profile?.recentModels.insert(
      0,
      RecentActivity(title: modelName, date: DateTime.now()),
    );

    // Keep only last 20 recent models
    if (_profile!.recentModels.length > 20) {
      _profile!.recentModels = _profile!.recentModels.take(20).toList();
    }

    await _saveAll();
    notifyListeners();
  }

  // ── AR Sessions ─────────────────────────────────────────────────────

  Future<void> incrementArSessions() async {
    _profile?.arSessions++;
    await _saveAll();
    notifyListeners();
  }

  // ── Reset Progress ──────────────────────────────────────────────────

  Future<void> resetProgress() async {
    if (_profile == null) return;

    for (var module in _modules) {
      module.completedLessons = 0;
      for (var lesson in module.lessons) {
        lesson.isCompleted = false;
      }
    }

    _profile = LearnerProfile(
      name: _profile!.name,
      avatarIndex: _profile!.avatarIndex,
      dateCreated: _profile!.dateCreated,
    );

    await _saveAll();
    notifyListeners();
  }

  // ── Notifications Toggle ────────────────────────────────────────────

  Future<void> setNotificationsEnabled(bool enabled) async {
    await StorageService.setNotificationsEnabled(enabled);
    if (enabled) {
      await NotificationService.scheduleDailyReminder(hour: 9, minute: 0);
    } else {
      await NotificationService.cancelAllScheduled();
    }
    notifyListeners();
  }

  bool get notificationsEnabled => StorageService.areNotificationsEnabled();
}
