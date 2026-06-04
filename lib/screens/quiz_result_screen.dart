// lib/screens/quiz_result_screen.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final Lesson lesson;
  final LearningModule module;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.lesson,
    required this.module,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  double get percentage => (widget.score / widget.total) * 100;

  bool get _isPerfect => percentage == 100;
  bool get _isExcellent => percentage >= 80;
  bool get _isGood => percentage >= 60;

  String get _message {
    if (_isPerfect) return 'Perfect score! Outstanding work.';
    if (_isExcellent) return 'Excellent work! Keep it up.';
    if (_isGood) return 'Good effort! Review and try again.';
    return 'Keep studying.You\'ll get there!';
  }

  Color get _scoreColor {
    if (_isExcellent) return AppTheme.tealColor;
    if (_isGood) return AppTheme.warningColor;
    return AppTheme.dangerColor;
  }

  Color get _scoreBg {
    if (_isExcellent) return AppTheme.tealColor.withValues(alpha: 0.08);
    if (_isGood) return AppTheme.warningColor.withValues(alpha: 0.08);
    return AppTheme.dangerColor.withValues(alpha: 0.08);
  }

  IconData get _scoreIcon {
    if (_isPerfect) return Icons.emoji_events_rounded;
    if (_isExcellent) return Icons.check_circle_rounded;
    if (_isGood) return Icons.thumb_up_rounded;
    return Icons.auto_stories_rounded;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progressAnim = Tween<double>(begin: 0, end: percentage / 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────
            Container(
              color: Theme.of(context).cardTheme.color,
              padding: const EdgeInsets.fromLTRB(12, 10, 16, 14),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).popUntil(
                          (route) =>
                              route.isFirst || route.settings.name == '/home',
                        ),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).dividerTheme.color ??
                                    AppTheme.borderColorLight,
                                width: 0.8),
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 18,
                            color:
                                Theme.of(context).textTheme.titleLarge?.color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.lesson.title,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8BAAB8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Quiz Result',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      // Module pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.cyanTint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.module.title,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Scrollable body ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  children: [
                    // ── Score hero ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 28, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Theme.of(context).dividerTheme.color ??
                                AppTheme.borderColorLight,
                            width: 0.8),
                      ),
                      child: Column(
                        children: [
                          // Animated ring
                          ScaleTransition(
                            scale: _scaleAnim,
                            child: AnimatedBuilder(
                              animation: _progressAnim,
                              builder: (context, _) => SizedBox(
                                width: 160,
                                height: 160,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: const Size(160, 160),
                                      painter: _RingPainter(
                                        progress: _progressAnim.value,
                                        trackColor: AppTheme.cyanTint,
                                        progressColor: _scoreColor,
                                      ),
                                    ),
                                    // Center content
                                    Container(
                                      width: 110,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: _scoreBg,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            _scoreIcon,
                                            color: _scoreColor,
                                            size: 22,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${(_progressAnim.value * 100).toInt()}%',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w800,
                                              color: _scoreColor,
                                            ),
                                          ),
                                          Text(
                                            '${widget.score} / ${widget.total}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF8BAAB8),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Message
                          FadeTransition(
                            opacity: _fadeAnim,
                            child: Text(
                              _message,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(height: 1.4),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ── Stats row ────────────────────────────────────
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.check_rounded,
                              iconColor: AppTheme.tealColor,
                              iconBg: AppTheme.tealColor.withValues(alpha: 0.1),
                              label: 'Correct',
                              value: '${widget.score}',
                              valueColor: AppTheme.tealColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.close_rounded,
                              iconColor: AppTheme.dangerColor,
                              iconBg:
                                  AppTheme.dangerColor.withValues(alpha: 0.1),
                              label: 'Incorrect',
                              value: '${widget.total - widget.score}',
                              valueColor: AppTheme.dangerColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.quiz_outlined,
                              iconColor: AppTheme.accentColor,
                              iconBg:
                                  AppTheme.accentColor.withValues(alpha: 0.1),
                              label: 'Total',
                              value: '${widget.total}',
                              valueColor: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Action buttons ───────────────────────────────
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Column(
                        children: [
                          // Retry — primary action
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: AppTheme.primaryDark,
                              minimumSize: const Size(double.infinity, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh_rounded, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Retry quiz',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Return to module — secondary action
                          OutlinedButton(
                            onPressed: () => Navigator.of(context).popUntil(
                              (route) =>
                                  route.isFirst ||
                                  route.settings.name == '/home',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).textTheme.titleSmall?.color,
                              minimumSize: const Size(double.infinity, 52),
                              side: const BorderSide(
                                  color: AppTheme.borderColorLight, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back_rounded, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Return to module',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat Card ─────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final Color valueColor;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Theme.of(context).dividerTheme.color ??
                AppTheme.borderColorLight,
            width: 0.8),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF8BAAB8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ring Painter ──────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;

  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 20) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Track
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.progressColor != progressColor;
}
