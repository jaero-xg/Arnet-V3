import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'lesson_reader_screen.dart';

const _kModuleIcons = <String, IconData>{
  'Module 1': Icons.wifi,
  'Module 2': Icons.cable,
  'Module 3': Icons.router,
  'Module 4': Icons.settings_ethernet_outlined,
};

class ModuleDetailsScreen extends StatelessWidget {
  final LearningModule module;
  const ModuleDetailsScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pct = module.completionPercentage;
    final isDone = pct == 100;

    // Same soft elevation used for cards on the Home screen — keeps every
    // surface in the app reading as one consistent visual language.

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── Sticky App Bar ─────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              module.id,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),

          // ── Module Hero Card ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.greenTint,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _kModuleIcons[module.id] ?? Icons.school_outlined,
                          size: 24,
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
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _InfoPill(
                                  icon: Icons.menu_book_outlined,
                                  label: '${module.lessons.length} lessons',
                                ),
                                _InfoPill(
                                  icon: Icons.check_circle_outline_rounded,
                                  label: '${module.completedLessons} completed',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    module.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isDone ? 'Completed' : '${pct.toInt()}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isDone
                              ? AppTheme.successColor
                              : AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: AppTheme.greenTint,
                      color: isDone
                          ? AppTheme.successColor
                          : AppTheme.primaryColor,
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Lessons header ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Lessons',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(width: 8),
                  const Spacer(),
                  Text(
                    '${module.completedLessons} of ${module.lessons.length}',
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),

          // ── Lesson list ─────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverList.separated(
              itemCount: module.lessons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => _LessonCard(
                lesson: module.lessons[index],
                index: index,
                module: module,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  INFO PILL
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.greenTint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppTheme.primaryColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  LESSON CARD — elevated, matches Home screen's module/action cards
// ═══════════════════════════════════════════════════════════════════════════════

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final LearningModule module;

  const _LessonCard({
    required this.lesson,
    required this.index,
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;
    final isCompleted = lesson.isCompleted;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  LessonReaderScreen(lesson: lesson, module: module),
            ),
          ),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Step indicator
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppTheme.successLight
                        : AppTheme.greenTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: AppTheme.successColor,
                          )
                        : Text(
                            '${index + 1}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: tertiaryText,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        lesson.subtitle,
                        style: theme.textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 12,
                          color: tertiaryText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${lesson.readingTimeMinutes} min',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: tertiaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.successLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Completed',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    else
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: tertiaryText.withValues(alpha: 0.6),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
