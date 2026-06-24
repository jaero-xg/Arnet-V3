import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

const _kModuleIcons = <String, IconData>{
  'Module 1': Icons.wifi,
  'Module 2': Icons.cable,
  'Module 3': Icons.router,
  'Module 4': Icons.settings_ethernet_outlined,
};

class LessonReaderScreen extends StatefulWidget {
  final Lesson lesson;
  final LearningModule module;

  const LessonReaderScreen({
    super.key,
    required this.lesson,
    required this.module,
  });

  @override
  State<LessonReaderScreen> createState() => _LessonReaderScreenState();
}

class _LessonReaderScreenState extends State<LessonReaderScreen> {
  final ScrollController _scrollController = ScrollController();
  double _readProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    setState(() {
      _readProgress = (_scrollController.offset / max).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final module = widget.module;
    final lessonIndex = module.lessons.indexWhere((l) => l.id == lesson.id);
    final totalLessons = module.lessons.length;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // ── Main scrollable content ──────────────────────────────────
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ── App bar — mirrors Module Details exactly ────────────
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
                  lesson.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                actions: [
                  if (lessonIndex >= 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${lessonIndex + 1} / $totalLessons',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: _readProgress,
                      backgroundColor: AppTheme.greenTint,
                      color: AppTheme.primaryColor,
                      minHeight: 3,
                    ),
                  ),
                ),
              ),

              // ── Lesson Hero — flat card, matches Module Details hero ─
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon + title row — mirrors module hero row
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
                                // Module breadcrumb pill
                                _InfoPill(
                                  icon: _kModuleIcons[module.id] ??
                                      Icons.school_outlined,
                                  label: module.title,
                                ),
                                const SizedBox(height: 8),
                                // Lesson meta pills row
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _InfoPill(
                                      icon: Icons.schedule_outlined,
                                      label:
                                          '${lesson.readingTimeMinutes} min read',
                                    ),
                                    _InfoPill(
                                      icon: Icons.format_list_bulleted_outlined,
                                      label:
                                          '${lesson.sections.length} sections',
                                    ),
                                    if (lesson.isCompleted)
                                      _InfoPill(
                                        icon:
                                            Icons.check_circle_outline_rounded,
                                        label: 'Completed',
                                        color: AppTheme.successColor,
                                        tint: AppTheme.successLight,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Lesson subtitle as body headline
                      Text(
                        lesson.subtitle,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),

                      // ── Read progress ─────────────────────────────────
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reading progress',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _readProgress >= 1.0
                                ? 'Done'
                                : '${(_readProgress * 100).toInt()}%',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: _readProgress >= 1.0
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
                          value: _readProgress,
                          backgroundColor: AppTheme.greenTint,
                          color: _readProgress >= 1.0
                              ? AppTheme.successColor
                              : AppTheme.primaryColor,
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Sections header — mirrors "Lessons" header ──────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sections',
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Text(
                        '${lesson.sections.length} total',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),

              // ── Section blocks ──────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                sliver: SliverList.separated(
                  itemCount: lesson.sections.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => _SectionCard(
                    section: lesson.sections[index],
                    index: index,
                  ),
                ),
              ),
            ],
          ),

          // ── Sticky bottom CTA ────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomCTA(lesson: lesson, module: module),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  INFO PILL — exact copy from module_details_screen.dart for consistency
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Color? tint;

  const _InfoPill({
    required this.icon,
    required this.label,
    this.color,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? AppTheme.primaryColor;
    final effectiveTint = tint ?? AppTheme.greenTint;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveTint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: effectiveColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  SECTION CARD — same card shape, radius, padding as _LessonCard
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  final LessonSection section;
  final int index;
  const _SectionCard({required this.section, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section number badge + heading row — same pattern as _LessonCard
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.greenTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
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
                      'Section ${index + 1}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tertiaryText,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      section.heading,
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Accent underline — 2px, same primaryColor as progress bar
          Container(
            width: 32,
            height: 2,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 12),

          // Body text — same bodyMedium style and 1.7 line-height as before
          Text(
            section.body,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  BOTTOM CTA — same surface color + upward shadow as Module Details pattern
// ═══════════════════════════════════════════════════════════════════════════════

class _BottomCTA extends StatelessWidget {
  final Lesson lesson;
  final LearningModule module;
  const _BottomCTA({required this.lesson, required this.module});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.30 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {
            context.read<AppState>().markLessonComplete(module.id, lesson.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizScreen(lesson: lesson, module: module),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz_outlined,
                  size: 18, color: theme.colorScheme.onPrimary),
              const SizedBox(width: 8),
              Text(
                "I've read this — Take Quiz",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
