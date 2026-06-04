// lib/screens/lesson_reader_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

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

    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Stack(
        children: [
          // ── Main scrollable content ──────────────────────────────────
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ── App bar ────────────────────────────────────────────
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8BAAB8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                // Lesson position indicator e.g. "2 / 5"
                actions: [
                  if (lessonIndex >= 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.cyanTint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${lessonIndex + 1} / $totalLessons',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(5),
                  child: LinearProgressIndicator(
                    value: _readProgress,
                    backgroundColor: AppTheme.cyanTint,
                    color: AppTheme.accentColor,
                    minHeight: 4,
                  ),
                ),
              ),

              // ── Lesson hero ────────────────────────────────────────
              SliverToBoxAdapter(
                child: _LessonHero(lesson: lesson, module: module),
              ),

              // ── Section blocks ─────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _SectionBlock(
                      section: lesson.sections[index],
                      index: index,
                    ),
                    childCount: lesson.sections.length,
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

// ── Lesson Hero ───────────────────────────────────────────────────────────────

class _LessonHero extends StatelessWidget {
  final Lesson lesson;
  final LearningModule module;
  const _LessonHero({required this.lesson, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module breadcrumb pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  module.thumbnailEmoji,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 5),
                Text(
                  module.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Lesson subtitle as the main headline
          Text(
            lesson.subtitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),

          // Meta row: read time + section count
          Row(
            children: [
              _MetaChip(
                icon: Icons.schedule_rounded,
                label: '${lesson.readingTimeMinutes} min read',
              ),
              const SizedBox(width: 8),
              _MetaChip(
                icon: Icons.format_list_bulleted_rounded,
                label: '${lesson.sections.length} sections',
              ),
              if (lesson.isCompleted) ...[
                const SizedBox(width: 8),
                const _MetaChip(
                  icon: Icons.check_circle_rounded,
                  label: 'Completed',
                  color: AppTheme.tealColor,
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Container(
            height: 0.8,
            color: Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight,
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    this.color = const Color(0xFF8BAAB8),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ── Section Block ─────────────────────────────────────────────────────────────

class _SectionBlock extends StatelessWidget {
  final LessonSection section;
  final int index;
  const _SectionBlock({required this.section, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section number + heading row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section number badge
              Container(
                width: 26,
                height: 26,
                margin: const EdgeInsets.only(top: 1, right: 10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  section.heading,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Cyan accent underline
          Container(
            width: 36,
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Body text
          Text(
            section.body,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

// ── Bottom CTA ────────────────────────────────────────────────────────────────

class _BottomCTA extends StatelessWidget {
  final Lesson lesson;
  final LearningModule module;
  const _BottomCTA({required this.lesson, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight,
            width: 0.8,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.06),
            blurRadius: 12,
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
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz_outlined, size: 20),
              SizedBox(width: 8),
              Text(
                "I've read this — Take Quiz",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
