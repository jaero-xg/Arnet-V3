// lib/screens/module_details_screen.dart

import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'lesson_reader_screen.dart';

const _kModuleIcons = <String, IconData>{
  'Module 1': Icons.wifi_rounded,
  'Module 2': Icons.cable_rounded,
  'Module 3': Icons.router_rounded,
  'Module 4': Icons.settings_ethernet_rounded,
};

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
                    borderRadius: BorderRadius.circular(16),
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
              module.id,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 0.8,
                color: Theme.of(context).dividerTheme.color ??
                    AppTheme.borderColorLight,
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
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppTheme.greenTint,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Icon(
                          _kModuleIcons[module.id] ?? Icons.school_outlined,
                          size: 30,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              module.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _InfoPill(
                                  icon: Icons.menu_book_outlined,
                                  label: '${module.lessons.length} lessons',
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(width: 6),
                                _InfoPill(
                                  icon: Icons.check_circle_outline_rounded,
                                  label: '${module.completedLessons} done',
                                  color: AppTheme.primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    module.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        isDone ? 'Completed ✓' : '${pct.toInt()}%',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: AppTheme.greenTint,
                      color: AppTheme.primaryColor,
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
        borderRadius: BorderRadius.circular(10),
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
        borderRadius: BorderRadius.circular(26),
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
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : AppTheme.greenTint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: AppTheme.primaryColor,
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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.labelSmall,
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 12,
                        color: Color(0xFF9AA0A8),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${lesson.readingTimeMinutes} min',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9AA0A8),
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
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: Color(0xFF9AA0A8),
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
