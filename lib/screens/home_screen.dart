// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'module_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onGoToModels;
  final VoidCallback? onGoToAR;
  const HomeScreen({super.key, this.onGoToModels, this.onGoToAR});

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

            // ── Greeting ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _Greeting(
                greeting: greeting,
                name: profile?.name ?? 'Learner',
              ),
            ),

            // ── Hero banner ─────────────────────────────────────────────
            const SliverToBoxAdapter(
              child: _HeroBanner(),
            ),

            // ── Quick action cards ─────────────────────────────────────
            SliverToBoxAdapter(
              child: _QuickActions(
                modules: modules,
                onGoToModels: onGoToModels,
                onGoToAR: onGoToAR,
              ),
            ),

            // ── "Your Modules" section header ──────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  children: [
                    Text(
                      'Your modules',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      '${modules.length} total',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            // ── Module list ────────────────────────────────────────────
            modules.isEmpty
                ? const SliverToBoxAdapter(
                    child: _EmptyModules(),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _ModuleCard(module: modules[index]),
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

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final dynamic profile;
  const _TopBar({required this.profile});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = _formatDate(now);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          // Date
          Text(
            dateStr.toUpperCase(),
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppTheme.textTertiaryDark
                  : AppTheme.textTertiaryLight,
              letterSpacing: 0.9,
            ),
          ),
          const Spacer(),
          // ── Avatar ──────────────────────────────────────────────
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                avatarList[profile?.avatarIndex ?? 0]['emoji'],
                style: const TextStyle(fontSize: 19),
              ),
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
      'Sunday',
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
      'December',
    ];
    return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
  }
}

// ── Greeting ──────────────────────────────────────────────────────────────────

class _Greeting extends StatelessWidget {
  final String greeting;
  final String name;
  const _Greeting({required this.greeting, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).textTheme.headlineMedium?.color,
            letterSpacing: -0.2,
          ),
          children: [
            TextSpan(text: '$greeting, '),
            TextSpan(
              text: '$name',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hero Banner ───────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppTheme.primaryColor,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned(
              right: -24,
              top: -24,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              right: 36,
              bottom: -36,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ARNET',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Interactive AR modules, 3D models, and hands-on lessons — built for focused learning.",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.82),
                            fontSize: 12.5,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
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
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────────

class _QuickActions extends StatefulWidget {
  final List<LearningModule> modules;
  final VoidCallback? onGoToModels;
  final VoidCallback? onGoToAR;
  const _QuickActions({
    required this.modules,
    this.onGoToModels,
    this.onGoToAR,
  });

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
    if (!hasCards) return const SizedBox(height: 4);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Column(
        children: [
          if (_showContinue && inProgress != null)
            _ActionCard(
              icon: Icons.play_circle_outline_rounded,
              iconColor: AppTheme.primaryColor,
              iconBg: AppTheme.greenTint,
              title: 'Continue learning',
              subtitle:
                  '${inProgress.title} · ${inProgress.completionPercentage.toInt()}% complete',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModuleDetailsScreen(module: inProgress),
                ),
              ),
              onDismiss: () => setState(() => _showContinue = false),
            ),
          if (_showAR)
            _ActionCard(
              icon: Icons.view_in_ar_rounded,
              iconColor: AppTheme.accentColor,
              iconBg: AppTheme.infoLight,
              title: 'Try an AR model',
              subtitle:
                  'Point your camera at a surface and bring lessons to life.',
              onTap: widget.onGoToAR,
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
  final VoidCallback? onTap;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onDismiss,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
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
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 3),
                      Text(subtitle,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  size: 20,
                  color: isDark
                      ? AppTheme.textQuaternaryDark
                      : AppTheme.textQuaternaryLight),
              GestureDetector(
                onTap: onDismiss,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.close_rounded,
                      size: 16,
                      color: isDark
                          ? AppTheme.textQuaternaryDark
                          : AppTheme.textQuaternaryLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Module Card ───────────────────────────────────────────────────────────────

class _ModuleCard extends StatelessWidget {
  final LearningModule module;
  const _ModuleCard({required this.module});

  static const _moduleIcons = <String, IconData>{
    'Module 1': Icons.wifi_rounded,
    'Module 2': Icons.cable_rounded,
    'Module 3': Icons.router_rounded,
    'Module 4': Icons.settings_ethernet_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final pct = module.completionPercentage;
    final isDone = pct == 100;
    final icon = _moduleIcons[module.id] ?? Icons.school_outlined;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ModuleDetailsScreen(module: module)),
          ),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDone ? AppTheme.successLight : AppTheme.greenTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isDone ? Icons.check_rounded : icon,
                    size: 22,
                    color:
                        isDone ? AppTheme.successColor : AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(module.title,
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 3),
                      Text('${module.lessons.length} lessons',
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
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
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isDone ? 'Done' : '${pct.toInt()}%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isDone
                                  ? AppTheme.successColor
                                  : AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.chevron_right_rounded,
                    size: 20,
                    color: isDark
                        ? AppTheme.textQuaternaryDark
                        : AppTheme.textQuaternaryLight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyModules extends StatelessWidget {
  const _EmptyModules();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.greenTint,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.school_outlined,
                size: 34,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            Text('No modules yet',
                style: Theme.of(context).textTheme.titleMedium),
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
