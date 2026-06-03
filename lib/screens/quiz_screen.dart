// lib/screens/quiz_screen.dart

import 'package:flutter/material.dart';
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

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};

  QuizQuestion get _currentQuestion =>
      widget.lesson.quizQuestions[_currentIndex];
  int get _totalQuestions => widget.lesson.quizQuestions.length;
  bool get _isLast => _currentIndex == _totalQuestions - 1;

  void _selectAnswer(int optionIndex) {
    setState(() => _selectedAnswers[_currentIndex] = optionIndex);
  }

  void _next() {
    if (_currentIndex < _totalQuestions - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
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
      backgroundColor: AppTheme.surfaceColor,
      appBar: AppBar(
        title: Text('${widget.lesson.subtitle} Quiz',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Question counter + progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentIndex + 1} of $_totalQuestions',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                Text(
                  '${_selectedAnswers.length} answered',
                  style: const TextStyle(
                      fontSize: 13, color: AppTheme.primaryLight),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: AppTheme.primaryColor,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 20),
            // Question card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Question ${_currentIndex + 1}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(_currentQuestion.question,
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
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
            const Spacer(),
            // Navigation buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _currentIndex > 0 ? _previous : null,
                    icon: const Icon(Icons.arrow_back, size: 18),
                    label: const Text('Previous'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      foregroundColor: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLast
                        ? (_selectedAnswers.length == _totalQuestions
                            ? _submit
                            : null)
                        : _next,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48)),
                    child: Text(_isLast ? 'Submit Quiz' : 'Next',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    final letters = ['A', 'B', 'C', 'D'];
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor.withValues(alpha: .08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : const Color(0xFFE0E0E0),
            width: isSelected ? 1.5 : 0.8,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppTheme.primaryColor : Colors.grey[100],
              ),
              child: Center(
                child: Text(
                  letters[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.grey[600],
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
                  color: isSelected
                      ? AppTheme.primaryDark
                      : const Color(0xFF455A64),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
