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
    if (_isPerfect) return 'Perfect score. Outstanding work.';
    if (_isExcellent) return 'Excellent work. Keep it up.';
    if (_isGood) return 'Good effort. Review and try again.';
    return "Keep studying. You'll get there.";
  }

  Color _scoreColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_isExcellent) return colorScheme.tertiary;
    if (_isGood) return colorScheme.secondary;
    return colorScheme.error;
  }

  Color _scoreBg(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_isExcellent) {
      return colorScheme.tertiaryContainer?.withValues(alpha: 0.5) ??
          colorScheme.tertiary.withValues(alpha: 0.08);
    }
    if (_isGood) {
      return colorScheme.secondaryContainer?.withValues(alpha: 0.5) ??
          colorScheme.secondary.withValues(alpha: 0.08);
    }
    return colorScheme.errorContainer?.withValues(alpha: 0.5) ??
        colorScheme.error.withValues(alpha: 0.08);
  }

  IconData get _scoreIcon {
    if (_isPerfect) return Icons.emoji_events_outlined;
    if (_isExcellent) return Icons.check_circle_outline_rounded;
    if (_isGood) return Icons.thumb_up_outlined;
    return Icons.auto_stories_outlined;
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final scoreColor = _scoreColor(context);
    final scoreBg = _scoreBg(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────
            Container(
              color: theme.cardTheme.color,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Row(
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
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: theme.dividerTheme.color ?? Colors.transparent,
                          width: 0.6,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.lesson.title,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Quiz Result',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 120),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          colorScheme.primaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.module.title,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimaryContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable body ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  children: [
                    // ── Score hero ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 24),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.dividerTheme.color ?? Colors.transparent,
                          width: 0.6,
                        ),
                      ),
                      child: Column(
                        children: [
                          ScaleTransition(
                            scale: _scaleAnim,
                            child: AnimatedBuilder(
                              animation: _progressAnim,
                              builder: (context, _) => SizedBox(
                                width: 140,
                                height: 140,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: const Size(140, 140),
                                      painter: _RingPainter(
                                        progress: _progressAnim.value,
                                        trackColor: theme.dividerTheme.color ??
                                            colorScheme.outlineVariant,
                                        progressColor: scoreColor,
                                      ),
                                    ),
                                    Container(
                                      width: 96,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        color: scoreBg,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            _scoreIcon,
                                            color: scoreColor,
                                            size: 20,
                                            weight: 400,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${(_progressAnim.value * 100).toInt()}%',
                                            style: theme
                                                .textTheme.headlineMedium
                                                ?.copyWith(
                                              color: scoreColor,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1,
                                            ),
                                          ),
                                          Text(
                                            '${widget.score} / ${widget.total}',
                                            style: theme.textTheme.labelSmall
                                                ?.copyWith(
                                              color: theme
                                                  .textTheme.bodySmall?.color,
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
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _fadeAnim,
                            child: Text(
                              _message,
                              style: theme.textTheme.titleLarge?.copyWith(
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Stats row ────────────────────────────────────
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.check_outlined,
                              color: colorScheme.tertiary,
                              label: 'Correct',
                              value: '${widget.score}',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.close_outlined,
                              color: colorScheme.error,
                              label: 'Incorrect',
                              value: '${widget.total - widget.score}',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.quiz_outlined,
                              color: colorScheme.primary,
                              label: 'Total',
                              value: '${widget.total}',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Action buttons ───────────────────────────────
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh_outlined, size: 18),
                                SizedBox(width: 8),
                                Text('Retry quiz'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: () => Navigator.of(context).popUntil(
                              (route) =>
                                  route.isFirst ||
                                  route.settings.name == '/home',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  theme.textTheme.titleSmall?.color,
                              minimumSize: const Size(double.infinity, 50),
                              side: BorderSide(
                                color: theme.dividerTheme.color ??
                                    Colors.transparent,
                                width: 0.8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back_ios_new_rounded,
                                    size: 16),
                                SizedBox(width: 8),
                                Text('Return to module'),
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

// ═══════════════════════════════════════════════════════════════════════════════
//  STAT CARD — Formal, minimal
// ═══════════════════════════════════════════════════════════════════════════════

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 0.6,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
              weight: 400,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.textTheme.bodySmall?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  RING PAINTER — Thinner stroke, formal
// ═══════════════════════════════════════════════════════════════════════════════

class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;

  const _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.progressColor != progressColor;
}
