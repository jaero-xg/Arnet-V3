// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'settings_screen.dart';

// ── Profile Screen ────────────────────────────────────────────────────────────

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    if (profile == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _ProfileHeader(profile: profile)),
            const SliverToBoxAdapter(
              child: _SectionHeader(title: 'Progress Overview', trailing: null),
            ),
            SliverToBoxAdapter(child: _ProgressCards(profile: profile)),
            if (profile.recentLessons.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Recent Lessons',
                  trailing: '${profile.recentLessons.take(5).length}',
                ),
              ),
              SliverToBoxAdapter(
                child: _ActivityList(
                  activities: profile.recentLessons.take(5).toList(),
                  icon: Icons.menu_book_outlined,
                ),
              ),
            ],
            if (profile.quizRecords.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Recent Quiz Records',
                  trailing: '${profile.quizRecords.take(5).length}',
                ),
              ),
              SliverToBoxAdapter(
                child: _QuizRecordList(
                    records: profile.quizRecords.take(5).toList()),
              ),
            ],
            if (profile.recentModels.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Recent 3D Models',
                  trailing: '${profile.recentModels.take(5).length}',
                ),
              ),
              SliverToBoxAdapter(
                child: _ActivityList(
                  activities: profile.recentModels.take(5).toList(),
                  icon: Icons.view_in_ar_outlined,
                ),
              ),
            ],
            if (profile.achievements.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Achievements',
                  trailing: '${profile.achievements.length}',
                ),
              ),
              SliverToBoxAdapter(
                child: _AchievementsSection(achievements: profile.achievements),
              ),
            ],
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

// ── Profile Header ────────────────────────────────────────────────────────────
// Mirrors Home's _TopBar avatar treatment: greenTint background, radius 12,
// transparent over scaffold (no separate card surface), 20px padding.

class _ProfileHeader extends StatelessWidget {
  final LearnerProfile profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                avatarList[profile.avatarIndex]['emoji'],
                style: const TextStyle(fontSize: 21),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Joined ${DateFormat('MMM d, yyyy').format(profile.dateCreated)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.greenTint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.settings_outlined,
                size: 20,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────
// Mirrors Home's "Your modules" row exactly: 20px horizontal padding,
// titleLarge + primaryColor labelSmall trailing.

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if (trailing != null)
            Text(
              '$trailing total',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
        ],
      ),
    );
  }
}

// ── Progress Cards ────────────────────────────────────────────────────────────
// Same shell as Home's _ModuleCard / Models' _ModelCard: cardTheme.color,
// radius 18, greenTint icon container, radius 12. Color now only varies the
// icon/value accent (success green, warning amber, primary) — never the
// background tint, which stays greenTint throughout for consistency.

class _ProgressCards extends StatelessWidget {
  final LearnerProfile profile;
  const _ProgressCards({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
        children: [
          _ProgressCard(
            icon: Icons.school_outlined,
            label: 'Modules Completed',
            value: '${profile.modulesCompleted}',
            color: AppTheme.successColor,
          ),
          _ProgressCard(
            icon: Icons.menu_book_outlined,
            label: 'Lessons Completed',
            value: '${profile.lessonsCompleted}',
            color: AppTheme.primaryColor,
          ),
          _ProgressCard(
            icon: Icons.view_in_ar_outlined,
            label: 'AR Sessions',
            value: '${profile.arSessions}',
            color: AppTheme.primaryColor,
          ),
          _ProgressCard(
            icon: Icons.quiz_outlined,
            label: 'Avg. Quiz Score',
            value: '${profile.averageQuizScore.toInt()}%',
            color: AppTheme.warningColor,
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ProgressCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Activity List ─────────────────────────────────────────────────────────────
// Same shell radius (18) and 20px outer padding as the rest of the screen.
// clipBehavior: Clip.hardEdge keeps ListTile's tileColor from bleeding past
// the rounded corners.

class _ActivityList extends StatelessWidget {
  final List<RecentActivity> activities;
  final IconData icon;

  const _ActivityList({required this.activities, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: activities.asMap().entries.map((e) {
            final isLast = e.key == activities.length - 1;
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.greenTint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.primaryColor,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    e.value.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: Text(
                    DateFormat('MMM d').format(e.value.date),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  dense: true,
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 52,
                    color: Theme.of(context).dividerTheme.color,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ── Quiz Record List ──────────────────────────────────────────────────────────
// Same shell radius (18) as the rest of the screen. Score pill now uses
// successColor / warningColor / dangerColor — same trio used in Home's
// _ModuleCard for done/in-progress states — instead of primaryColor for
// "good" scores.

class _QuizRecordList extends StatelessWidget {
  final List<QuizRecord> records;
  const _QuizRecordList({required this.records});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: records.asMap().entries.map((e) {
            final record = e.value;
            final isLast = e.key == records.length - 1;
            final color = record.percentage >= 80
                ? AppTheme.successColor
                : record.percentage >= 60
                    ? AppTheme.warningColor
                    : AppTheme.dangerColor;
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.greenTint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.quiz_outlined,
                      color: AppTheme.primaryColor,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    record.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    DateFormat('MMM d, yyyy').format(record.date),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${record.percentage.toInt()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                  dense: true,
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 52,
                    color: Theme.of(context).dividerTheme.color,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ── Achievements Section ──────────────────────────────────────────────────────
// Chip radius now 12 (was 10) to align with the icon-container radius used
// everywhere else, and sits on cardTheme.color like every other surface.

class _AchievementsSection extends StatelessWidget {
  final List<String> achievements;
  const _AchievementsSection({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: achievements.map((a) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    a,
                    style: Theme.of(context).textTheme.titleSmall,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
