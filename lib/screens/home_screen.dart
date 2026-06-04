// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'module_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    final modules = context.watch<AppState>().modules;
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
            ? 'Good afternoon'
            : 'Good evening';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Top bar ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _TopBar(profile: profile),
            ),

            // ── Greeting + hero banner ─────────────────────────────────
            SliverToBoxAdapter(
              child: _HeroBanner(
                greeting: greeting,
                name: profile?.name ?? 'Learner',
              ),
            ),

            // ── Quick action cards (dismissible tips) ──────────────────
            SliverToBoxAdapter(
              child: _QuickActions(modules: modules),
            ),

            // ── "Your Modules" section header ──────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Row(
                  children: [
                    Text(
                      'Your modules',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      '${modules.length} total',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),

            // ── Module list ────────────────────────────────────────────
            modules.isEmpty
                ? SliverToBoxAdapter(
                    child: _EmptyModules(),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _ModuleCard(
                          module: modules[index],
                        ),
                      ),
                      childCount: modules.length,
                    ),
                  ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 96 + MediaQuery.of(context).padding.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Top bar ──────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final dynamic profile;
  const _TopBar({required this.profile});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = _formatDate(now);

    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          // Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateStr.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8BAAB8),
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Offline badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.cyanTint,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off_rounded,
                    size: 12, color: AppTheme.primaryColor),
                SizedBox(width: 4),
                Text(
                  'Offline',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.accentColor.withValues(alpha: 0.15),
            child: Text(
              avatarList[profile?.avatarIndex ?? 0]['emoji'],
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
  }
}

// ── Hero Banner ───────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  final String greeting;
  final String name;
  const _HeroBanner({required this.greeting, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting text
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w300,
                color: AppTheme.primaryColor,
              ),
              children: [
                TextSpan(text: '$greeting, '),
                TextSpan(
                  text: '$name!',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ARNET info card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Decorative circles for depth
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.accentColor.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: -30,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.accentColor.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Logo box
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.view_in_ar_rounded,
                          color: AppTheme.accentColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ARNET',
                              style: TextStyle(
                                color: AppTheme.accentColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "I'll help you learn through interactive AR modules, 3D models, and hands-on lessons.",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 13,
                                height: 1.5,
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────────

class _QuickActions extends StatefulWidget {
  final List<LearningModule> modules;
  const _QuickActions({required this.modules});

  @override
  State<_QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<_QuickActions> {
  bool _showContinue = true;
  bool _showAR = true;

  LearningModule? get _inProgress {
    try {
      return widget.modules.firstWhere(
        (m) => m.completionPercentage > 0 && m.completionPercentage < 100,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inProgress = _inProgress;
    final hasCards = (_showContinue && inProgress != null) || _showAR;
    if (!hasCards) return const SizedBox(height: 8);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        children: [
          // Continue learning card
          if (_showContinue && inProgress != null)
            _ActionCard(
              icon: Icons.play_circle_outline_rounded,
              iconColor: AppTheme.tealColor,
              iconBg: AppTheme.tealColor.withValues(alpha: 0.1),
              title: 'Continue learning',
              subtitle:
                  '${inProgress.title} • ${inProgress.completionPercentage.toInt()}% done',
              onDismiss: () => setState(() => _showContinue = false),
            ),

          // Try AR card
          if (_showAR)
            _ActionCard(
              icon: Icons.view_in_ar_rounded,
              iconColor: AppTheme.accentColor,
              iconBg: AppTheme.accentColor.withValues(alpha: 0.1),
              title: 'Try an AR model',
              subtitle:
                  'Point your camera at a surface and bring lessons to life.',
              onDismiss: () => setState(() => _showAR = false),
            ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onDismiss;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight,
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          // Chevron
          const Icon(Icons.chevron_right_rounded,
              size: 20, color: Color(0xFFB0C8D4)),
          // Dismiss X
          GestureDetector(
            onTap: onDismiss,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.close_rounded,
                  size: 16, color: Color(0xFFB0C8D4)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Module Card ───────────────────────────────────────────────────────────────

class _ModuleCard extends StatelessWidget {
  final LearningModule module;
  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    final pct = module.completionPercentage;
    final isDone = pct == 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight,
          width: 0.8,
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ModuleDetailsScreen(module: module)),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Emoji icon box
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppTheme.cyanTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    module.thumbnailEmoji,
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${module.lessons.length} lessons',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    // Progress bar
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: pct / 100,
                              backgroundColor: AppTheme.cyanTint,
                              color: isDone
                                  ? AppTheme.tealColor
                                  : AppTheme.accentColor,
                              minHeight: 5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isDone ? '✓' : '${pct.toInt()}%',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isDone
                                ? AppTheme.tealColor
                                : AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded,
                  size: 20, color: Color(0xFFB0C8D4)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyModules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.cyanTint,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.school_outlined,
                size: 36,
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No modules yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Your learning modules will appear here.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
