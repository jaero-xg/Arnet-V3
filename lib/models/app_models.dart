// lib/models/app_models.dart

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

  Map<String, dynamic> toMap() => {
        'name': name,
        'avatarIndex': avatarIndex,
        'dateCreated': dateCreated.toIso8601String(),
        'modulesCompleted': modulesCompleted,
        'lessonsCompleted': lessonsCompleted,
        'arSessions': arSessions,
        'averageQuizScore': averageQuizScore,
      };

  factory LearnerProfile.fromMap(Map<String, dynamic> map) => LearnerProfile(
        name: map['name'],
        avatarIndex: map['avatarIndex'],
        dateCreated: DateTime.parse(map['dateCreated']),
        modulesCompleted: map['modulesCompleted'] ?? 0,
        lessonsCompleted: map['lessonsCompleted'] ?? 0,
        arSessions: map['arSessions'] ?? 0,
        averageQuizScore: (map['averageQuizScore'] ?? 0).toDouble(),
      );
}

class RecentActivity {
  final String title;
  final DateTime date;
  RecentActivity({required this.title, required this.date});
}

class QuizRecord {
  final String title;
  final int score;
  final int total;
  final DateTime date;
  QuizRecord({required this.title, required this.score, required this.total, required this.date});
  double get percentage => (score / total) * 100;
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
  QuizQuestion({required this.question, required this.options, required this.correctIndex});
}

class Model3D {
  final String id;
  final String name;
  final String description;
  final String category;
  final String learningObjective;
  final String relatedModuleId;
  final String thumbnailEmoji;

  Model3D({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.learningObjective,
    required this.relatedModuleId,
    required this.thumbnailEmoji,
  });
}
