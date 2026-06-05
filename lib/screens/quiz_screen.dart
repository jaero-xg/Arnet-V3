// lib/screens/quiz_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/app_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  final LearningModule module;
  const QuizScreen({super.key, required this.lesson, required this.module});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  late final AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  QuizQuestion get _currentQuestion =>
      widget.lesson.quizQuestions[_currentIndex];
  int get _totalQuestions => widget.lesson.quizQuestions.length;
  bool get _isLast => _currentIndex == _totalQuestions - 1;
  bool get _currentAnswered => _selectedAnswers.containsKey(_currentIndex);

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.06, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _selectAnswer(int optionIndex) {
    HapticFeedback.lightImpact();
    setState(() => _selectedAnswers[_currentIndex] = optionIndex);
  }

  void _goTo(int index) {
    _slideController.reset();
    setState(() => _currentIndex = index);
    _slideController.forward();
  }

  void _next() {
    if (_currentIndex < _totalQuestions - 1) _goTo(_currentIndex + 1);
  }

  void _previous() {
    if (_currentIndex > 0) _goTo(_currentIndex - 1);
  }

  void _submit() {
    int correct = 0;
    for (int i = 0; i < _totalQuestions; i++) {
      if (_selectedAnswers[i] == widget.lesson.quizQuestions[i].correctIndex) {
        correct++;
      }
    }
    context.read<AppState>().recordQuizResult(
          '${widget.module.title}: ${widget.lesson.subtitle}',
          correct,
          _totalQuestions,
        );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          score: correct,
          total: _totalQuestions,
          lesson: widget.lesson,
          module: widget.module,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / _totalQuestions;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────
            _QuizHeader(
              lesson: widget.lesson,
              currentIndex: _currentIndex,
              total: _totalQuestions,
              answeredCount: _selectedAnswers.length,
              progress: progress,
              onBack: () => Navigator.pop(context),
            ),

            // ── Question + options ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question dot navigation
                        _DotNavigation(
                          total: _totalQuestions,
                          currentIndex: _currentIndex,
                          answeredMap: _selectedAnswers,
                          onDotTap: _goTo,
                        ),
                        const SizedBox(height: 16),

                        // Question card
                        _QuestionCard(
                          index: _currentIndex,
                          question: _currentQuestion,
                        ),
                        const SizedBox(height: 14),

                        // Answer options
                        ...List.generate(
                          _currentQuestion.options.length,
                          (i) => _AnswerOption(
                            text: _currentQuestion.options[i],
                            index: i,
                            isSelected: _selectedAnswers[_currentIndex] == i,
                            onTap: () => _selectAnswer(i),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom nav ───────────────────────────────────────────
            _BottomNav(
              currentIndex: _currentIndex,
              total: _totalQuestions,
              isLast: _isLast,
              currentAnswered: _currentAnswered,
              allAnswered: _selectedAnswers.length == _totalQuestions,
              onPrevious: _previous,
              onNext: _next,
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quiz Header ───────────────────────────────────────────────────────────────

class _QuizHeader extends StatelessWidget {
  final Lesson lesson;
  final int currentIndex;
  final int total;
  final int answeredCount;
  final double progress;
  final VoidCallback onBack;

  const _QuizHeader({
    required this.lesson,
    required this.currentIndex,
    required this.total,
    required this.answeredCount,
    required this.progress,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
            child: Row(
              children: [
                // Back button
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    width: 36,
                    height: 36,
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
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8BAAB8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Quiz',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                // Answered counter
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.tealColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$answeredCount / $total answered',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Progress bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.tealColor.withValues(alpha: 0.08),
            color: AppTheme.accentColor,
            minHeight: 4,
          ),
        ],
      ),
    );
  }
}

// ── Dot Navigation ────────────────────────────────────────────────────────────

class _DotNavigation extends StatelessWidget {
  final int total;
  final int currentIndex;
  final Map<int, int> answeredMap;
  final ValueChanged<int> onDotTap;

  const _DotNavigation({
    required this.total,
    required this.currentIndex,
    required this.answeredMap,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final isCurrent = i == currentIndex;
        final isAnswered = answeredMap.containsKey(i);

        return GestureDetector(
          onTap: () => onDotTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isCurrent ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isCurrent
                  ? AppTheme.accentColor
                  : isAnswered
                      ? AppTheme.tealColor.withValues(alpha: 0.5)
                      : AppTheme.borderColorLight,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

// ── Question Card ─────────────────────────────────────────────────────────────

class _QuestionCard extends StatelessWidget {
  final int index;
  final QuizQuestion question;

  const _QuestionCard({required this.index, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColorLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Question ${index + 1}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimaryDark,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Answer Option ─────────────────────────────────────────────────────────────

class _AnswerOption extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.text,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  static const _letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentColor.withValues(alpha: 0.08)
              : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentColor
                : (Theme.of(context).dividerTheme.color ??
                    AppTheme.borderColorLight),
            width: isSelected ? 0.8 : 0.8,
          ),
        ),
        child: Row(
          children: [
            // Letter badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.accentColor
                    : AppTheme.tealColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  _letters[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppTheme.textPrimaryDark
                        : const Color(0xFF4A6B7C),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: isSelected
                      ? Theme.of(context).textTheme.titleSmall?.color
                      : AppTheme.textSecondaryDark,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            // Selected checkmark
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 180),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: AppTheme.accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bottom Nav ────────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final int total;
  final bool isLast;
  final bool currentAnswered;
  final bool allAnswered;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  const _BottomNav({
    required this.currentIndex,
    required this.total,
    required this.isLast,
    required this.currentAnswered,
    required this.allAnswered,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerTheme.color ??
                AppTheme.borderColorLight,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        children: [
          // Previous button
          GestureDetector(
            onTap: currentIndex > 0 ? onPrevious : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: currentIndex > 0
                    ? Theme.of(context).scaffoldBackgroundColor
                    : (Theme.of(context).dividerTheme.color ??
                            AppTheme.borderColorLight)
                        .withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: currentIndex > 0
                    ? Theme.of(context).textTheme.titleLarge?.color
                    : const Color(0xFFB0C8D4),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Next / Submit button
          Expanded(
            child: isLast
                ? ElevatedButton(
                    onPressed: allAnswered ? onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: allAnswered
                          ? AppTheme.tealColor
                          : (Theme.of(context).dividerTheme.color ??
                              AppTheme.borderColorLight),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline_rounded,
                            size: 20),
                        const SizedBox(width: 8),
                        Text(
                          allAnswered ? 'Submit quiz' : 'Answer all questions',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: currentAnswered ? onNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentAnswered
                          ? AppTheme.primaryColor
                          : (Theme.of(context).dividerTheme.color ??
                              AppTheme.borderColorLight),
                      foregroundColor: currentAnswered
                          ? Colors.white
                          : const Color(0xFFB0C8D4),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentAnswered ? 'Next question' : 'Pick an answer',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (currentAnswered) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
