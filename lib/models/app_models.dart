// lib/models/app_models.dart

import 'package:flutter/src/widgets/icon_data.dart';

/// Complete data model for learner profile with full serialization support.
class LearnerProfile {
  final String name;
  final int avatarIndex;
  final DateTime dateCreated;
  int modulesCompleted;
  int lessonsCompleted;
  int arSessions;
  double averageQuizScore;
  List<RecentActivity> recentLessons;
  List<QuizRecord> quizRecords;
  List<RecentActivity> recentModels;
  List<String> achievements;

  LearnerProfile({
    required this.name,
    required this.avatarIndex,
    required this.dateCreated,
    this.modulesCompleted = 0,
    this.lessonsCompleted = 0,
    this.arSessions = 0,
    this.averageQuizScore = 0,
    List<RecentActivity>? recentLessons,
    List<QuizRecord>? quizRecords,
    List<RecentActivity>? recentModels,
    List<String>? achievements,
  })  : recentLessons = recentLessons ?? [],
        quizRecords = quizRecords ?? [],
        recentModels = recentModels ?? [],
        achievements = achievements ?? [];

  /// Convert to Map for JSON serialization (full persistence)
  Map<String, dynamic> toMap() => {
        'name': name,
        'avatarIndex': avatarIndex,
        'dateCreated': dateCreated.toIso8601String(),
        'modulesCompleted': modulesCompleted,
        'lessonsCompleted': lessonsCompleted,
        'arSessions': arSessions,
        'averageQuizScore': averageQuizScore,
        'recentLessons': recentLessons.map((r) => r.toMap()).toList(),
        'quizRecords': quizRecords.map((q) => q.toMap()).toList(),
        'recentModels': recentModels.map((r) => r.toMap()).toList(),
        'achievements': achievements,
      };

  /// Create from Map (JSON deserialization)
  factory LearnerProfile.fromMap(Map<String, dynamic> map) => LearnerProfile(
        name: map['name'] ?? '',
        avatarIndex: map['avatarIndex'] ?? 0,
        dateCreated: _parseDateTime(map['dateCreated']),
        modulesCompleted: map['modulesCompleted'] ?? 0,
        lessonsCompleted: map['lessonsCompleted'] ?? 0,
        arSessions: map['arSessions'] ?? 0,
        averageQuizScore: (map['averageQuizScore'] ?? 0.0).toDouble(),
        recentLessons: _parseList(map['recentLessons'], RecentActivity.fromMap),
        quizRecords: _parseList(map['quizRecords'], QuizRecord.fromMap),
        recentModels: _parseList(map['recentModels'], RecentActivity.fromMap),
        achievements: _parseStringList(map['achievements']),
      );

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  static List<T> _parseList<T>(dynamic value, T Function(Map<String, dynamic>) fromMap) {
    if (value == null) return [];
    if (value is List) {
      return value.whereType<Map<String, dynamic>>().map(fromMap).toList();
    }
    return [];
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.whereType<String>().toList();
    return [];
  }
}

class RecentActivity {
  final String title;
  final DateTime date;

  RecentActivity({required this.title, required this.date});

  Map<String, dynamic> toMap() => {
        'title': title,
        'date': date.toIso8601String(),
      };

  factory RecentActivity.fromMap(Map<String, dynamic> map) => RecentActivity(
        title: map['title'] ?? '',
        date: LearnerProfile._parseDateTime(map['date']),
      );
}

class QuizRecord {
  final String title;
  final int score;
  final int total;
  final DateTime date;

  QuizRecord({
    required this.title,
    required this.score,
    required this.total,
    required this.date,
  });

  double get percentage => total > 0 ? (score / total) * 100 : 0;

  Map<String, dynamic> toMap() => {
        'title': title,
        'score': score,
        'total': total,
        'date': date.toIso8601String(),
      };

  factory QuizRecord.fromMap(Map<String, dynamic> map) => QuizRecord(
        title: map['title'] ?? '',
        score: map['score'] ?? 0,
        total: map['total'] ?? 0,
        date: LearnerProfile._parseDateTime(map['date']),
      );
}

class LearningModule {
  final String id;
  final String title;
  final String description;
  final String thumbnailEmoji;
  final List<Lesson> lessons;
  int completedLessons;

  LearningModule({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailEmoji,
    required this.lessons,
    this.completedLessons = 0,
  });

  double get completionPercentage =>
      lessons.isEmpty ? 0 : (completedLessons / lessons.length) * 100;

  IconData? get thumbnailSvg => null;

  /// Apply saved progress to this module.
  void applyProgress(Map<String, dynamic> progress) {
    completedLessons = progress['completedLessons'] ?? 0;
    final lessonProgress = progress['lessons'] as List<dynamic>?;
    if (lessonProgress != null) {
      for (final lp in lessonProgress) {
        final lessonId = lp['id'] as String?;
        final isCompleted = lp['isCompleted'] as bool? ?? false;
        final lesson = lessons.firstWhere(
          (l) => l.id == lessonId,
          orElse: () => lessons.first,
        );
        if (lesson.id == lessonId) {
          lesson.isCompleted = isCompleted;
        }
      }
    }
  }
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final int readingTimeMinutes;
  bool isCompleted;
  final List<LessonSection> sections;
  final List<QuizQuestion> quizQuestions;

  Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.readingTimeMinutes,
    this.isCompleted = false,
    required this.sections,
    required this.quizQuestions,
  });
}

class LessonSection {
  final String heading;
  final String body;
  LessonSection({required this.heading, required this.body});
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class Model3D {
  final String id;
  final String name;
  final String description;
  final String category;
  final String learningObjective;
  final String relatedModuleId;
  final String thumbnailSvg;

  Model3D({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.learningObjective,
    required this.relatedModuleId,
    required this.thumbnailSvg,
  });
}
