// lib/state/app_state.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/sample_data.dart';

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
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('profile');
    if (profileJson != null) {
      _profile = LearnerProfile.fromMap(jsonDecode(profileJson));
    }
    _modules = sampleModules;
    _models = sampleModels;
    notifyListeners();
  }

  Future<void> createProfile(String name, int avatarIndex) async {
    _profile = LearnerProfile(
      name: name,
      avatarIndex: avatarIndex,
      dateCreated: DateTime.now(),
      achievements: ['First Login'],
    );
    await _saveProfile();
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
    await _saveProfile();
    notifyListeners();
  }

  void markLessonComplete(String moduleId, String lessonId) {
    final module = _modules.firstWhere((m) => m.id == moduleId);
    final lesson = module.lessons.firstWhere((l) => l.id == lessonId);
    if (!lesson.isCompleted) {
      lesson.isCompleted = true;
      module.completedLessons++;
      _profile?.lessonsCompleted++;
      _profile?.recentLessons.insert(
          0, RecentActivity(title: lesson.subtitle, date: DateTime.now()));
      if (module.completedLessons == module.lessons.length) {
        _profile?.modulesCompleted++;
        _profile?.achievements.add('Module Complete: ${module.title}');
      }
      _saveProfile();
      notifyListeners();
    }
  }

  void recordQuizResult(String quizTitle, int score, int total) {
    _profile?.quizRecords.insert(
      0,
      QuizRecord(
          title: quizTitle, score: score, total: total, date: DateTime.now()),
    );
    final allScores = _profile?.quizRecords.map((r) => r.percentage) ?? [];
    if (allScores.isNotEmpty) {
      _profile?.averageQuizScore =
          allScores.reduce((a, b) => a + b) / allScores.length;
    }
    if (score == total) {
      _profile?.achievements.add('Perfect Score: $quizTitle');
    }
    _saveProfile();
    notifyListeners();
  }

  void recordModelViewed(String modelName) {
    _profile?.recentModels.insert(
        0, RecentActivity(title: modelName, date: DateTime.now()));
    _saveProfile();
    notifyListeners();
  }

  void incrementArSessions() {
    _profile?.arSessions++;
    _saveProfile();
    notifyListeners();
  }

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
    await _saveProfile();
    notifyListeners();
  }

  Future<void> _saveProfile() async {
    if (_profile == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile', jsonEncode(_profile!.toMap()));
  }
}
