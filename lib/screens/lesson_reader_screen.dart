// lib/screens/lesson_reader_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

class LessonReaderScreen extends StatelessWidget {
  final Lesson lesson;
  final LearningModule module;

  const LessonReaderScreen(
      {super.key, required this.lesson, required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Text(lesson.title, style: Theme.of(context).textTheme.titleLarge),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Module label
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    module.title,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 14),
                Text(lesson.subtitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text('${lesson.readingTimeMinutes} min read',
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[500])),
                  ],
                ),
                const SizedBox(height: 28),
                ...lesson.sections
                    .map((section) => _SectionBlock(section: section)),
              ],
            ),
          ),
          // Bottom sticky button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  context
                      .read<AppState>()
                      .markLessonComplete(module.id, lesson.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          QuizScreen(lesson: lesson, module: module),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz_outlined),
                label: const Text('Take Quiz',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final LessonSection section;
  const _SectionBlock({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.heading, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Container(
            width: 32,
            height: 2.5,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            section.body,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
