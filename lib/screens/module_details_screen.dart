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
    final isDone = pct == 100;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── Sticky App Bar ─────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).cardTheme.color,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),
            ),
            title: Text(
              module.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 0.8,
                color: Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight,
              ),
            ),
          ),

          // ── Module Hero Card ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).cardTheme.color,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji + stats row
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppTheme.cyanTint,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            module.thumbnailEmoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              module.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            // Lesson + completed pills
                            Row(
                              children: [
                                _InfoPill(
                                  icon: Icons.menu_book_outlined,
                                  label: '${module.lessons.length} lessons',
                                  color: AppTheme.accentColor,
                                ),
                                const SizedBox(width: 6),
                                _InfoPill(
                                  icon: Icons.check_circle_outline_rounded,
                                  label: '${module.completedLessons} done',
                                  color: AppTheme.tealColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Description
                  Text(
                    module.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),

                  // Progress section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        isDone ? 'Completed ✓' : '${pct.toInt()}%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDone
                              ? AppTheme.tealColor
                              : AppTheme.accentColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: AppTheme.cyanTint,
                      color: isDone ? AppTheme.tealColor : AppTheme.accentColor,
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Lessons header ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Text(
                    'Lessons',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    '${module.completedLessons} of ${module.lessons.length}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),

          // ── Lesson list ─────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _LessonCard(
                  lesson: module.lessons[index],
                  index: index,
                  module: module,
                  isLast: index == module.lessons.length - 1,
                ),
                childCount: module.lessons.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info Pill ─────────────────────────────────────────────────────────────────

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Lesson Card ───────────────────────────────────────────────────────────────

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final LearningModule module;
  final bool isLast;

  const _LessonCard({
    required this.lesson,
    required this.index,
    required this.module,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = lesson.isCompleted;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? AppTheme.tealColor.withValues(alpha: 0.25)
              : (Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight),
          width: 0.8,
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LessonReaderScreen(lesson: lesson, module: module),
          ),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Step indicator circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppTheme.tealColor.withValues(alpha: 0.1)
                      : AppTheme.cyanTint,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: AppTheme.tealColor,
                        )
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lesson.subtitle,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Right side: time + done badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 12,
                        color: Color(0xFF8BAAB8),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${lesson.readingTimeMinutes} min',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8BAAB8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.tealColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.tealColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: Color(0xFFB0C8D4),
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
