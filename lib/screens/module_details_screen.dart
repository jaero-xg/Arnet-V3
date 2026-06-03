// lib/screens/module_details_screen.dart

import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'lesson_reader_screen.dart';

class ModuleDetailsScreen extends StatelessWidget {
  final LearningModule module;
  const ModuleDetailsScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    final pct = module.completionPercentage;
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      appBar: AppBar(
        title:
            Text(module.title, style: Theme.of(context).textTheme.titleLarge),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Module header card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(module.thumbnailEmoji,
                              style: const TextStyle(fontSize: 28)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${module.lessons.length} Lessons',
                            style: const TextStyle(
                                fontSize: 13, color: AppTheme.primaryLight),
                          ),
                          Text(
                            '${module.completedLessons} Completed',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(module.description,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progress',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600])),
                      Text('${pct.toInt()}%',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: Colors.grey[200],
                      color: pct == 100
                          ? AppTheme.successColor
                          : AppTheme.primaryColor,
                      minHeight: 7,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Lessons', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          ...module.lessons.asMap().entries.map(
                (entry) => _LessonCard(
                  lesson: entry.value,
                  index: entry.key,
                  module: module,
                ),
              ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final LearningModule module;

  const _LessonCard(
      {required this.lesson, required this.index, required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LessonReaderScreen(lesson: lesson, module: module),
          ),
        ),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: lesson.isCompleted
                      ? AppTheme.successColor.withValues(alpha: .1)
                      : AppTheme.primaryColor.withValues(alpha: .08),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: lesson.isCompleted
                      ? const Icon(Icons.check,
                          size: 18, color: AppTheme.successColor)
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                              fontSize: 14),
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lesson.title,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w500)),
                    Text(lesson.subtitle,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.schedule, size: 13, color: Colors.grey[400]),
                      const SizedBox(width: 3),
                      Text('${lesson.readingTimeMinutes} min',
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (lesson.isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Done',
                          style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.successColor,
                              fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
