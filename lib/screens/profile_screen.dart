// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';
import '../state/appearance_notifier.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'edit_profile_screen.dart';

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
            SliverToBoxAdapter(child: _ProfileInfoCard(profile: profile)),
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
            const SliverToBoxAdapter(
              child: _SectionHeader(title: 'Settings', trailing: null),
            ),
            SliverToBoxAdapter(child: _SettingsSection()),
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

class _ProfileHeader extends StatelessWidget {
  final LearnerProfile profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppTheme.accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile', style: Theme.of(context).textTheme.titleLarge),
              Text(
                'Your learning stats and settings',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Profile Info Card ─────────────────────────────────────────────────────────

class _ProfileInfoCard extends StatelessWidget {
  final LearnerProfile profile;
  const _ProfileInfoCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppTheme.accentColor.withValues(alpha: 0.15),
              child: Text(
                avatarList[profile.avatarIndex]['emoji'],
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Joined ${DateFormat('MMM d, yyyy').format(profile.dateCreated)}',
                    style: Theme.of(context).textTheme.bodySmall,
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

// ── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if (trailing != null)
            Text(
              '$trailing total',
              style: Theme.of(context).textTheme.labelSmall,
            ),
        ],
      ),
    );
  }
}

// ── Progress Cards ────────────────────────────────────────────────────────────

class _ProgressCards extends StatelessWidget {
  final LearnerProfile profile;
  const _ProgressCards({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
            color: AppTheme.primaryColor,
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
        borderRadius: BorderRadius.circular(16),
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
              borderRadius: BorderRadius.circular(10),
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
// FIX: clipBehavior: Clip.hardEdge on the outer container prevents ListTile's
// tileColor (set via listTileTheme) from bleeding past the rounded corners.

class _ActivityList extends StatelessWidget {
  final List<RecentActivity> activities;
  final IconData icon;

  const _ActivityList({required this.activities, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        clipBehavior: Clip.hardEdge, // ← fixes border-radius bleed
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: activities.asMap().entries.map((e) {
            final isLast = e.key == activities.length - 1;
            return Column(
              children: [
                ListTile(
                  leading: Icon(
                    icon,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    size: 20,
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
// FIX: same clipBehavior: Clip.hardEdge fix applied here.

class _QuizRecordList extends StatelessWidget {
  final List<QuizRecord> records;
  const _QuizRecordList({required this.records});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        clipBehavior: Clip.hardEdge, // ← fixes border-radius bleed
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: records.asMap().entries.map((e) {
            final record = e.value;
            final isLast = e.key == records.length - 1;
            final color = record.percentage >= 80
                ? AppTheme.primaryColor
                : record.percentage >= 60
                    ? AppTheme.warningColor
                    : AppTheme.dangerColor;
            return Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.quiz_outlined,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    size: 20,
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
                      borderRadius: BorderRadius.circular(20),
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

class _AchievementsSection extends StatelessWidget {
  final List<String> achievements;
  const _AchievementsSection({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: achievements.map((a) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Flexible(
                  // ← add this
                  child: Text(
                    a,
                    style: Theme.of(context).textTheme.titleSmall,
                    softWrap: true, // ← wraps instead of overflowing
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

// ── Settings Section ──────────────────────────────────────────────────────────
// FIX: clipBehavior: Clip.hardEdge applied here too — ListTile rows inside
// were bleeding past the container's rounded corners identically.

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        clipBehavior: Clip.hardEdge, // ← fixes border-radius bleed
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _AppearanceTile(),
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).dividerTheme.color,
            ),
            const _NotificationsTile(),
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).dividerTheme.color,
            ),
            _SettingsTile(
              icon: Icons.edit_outlined,
              label: 'Edit Profile',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              ),
            ),
            Divider(
              height: 1,
              indent: 52,
              color: Theme.of(context).dividerTheme.color,
            ),
            _SettingsTile(
              icon: Icons.refresh,
              label: 'Reset Progress',
              isDestructive: true,
              onTap: () => _confirmReset(context),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reset Progress'),
        content: const Text(
            'This will clear all your progress and quiz records. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AppState>().resetProgress();
            },
            child: const Text('Reset',
                style: TextStyle(color: AppTheme.dangerColor)),
          ),
        ],
      ),
    );
  }
}

// ── Appearance Tile ───────────────────────────────────────────────────────────

class _AppearanceTile extends StatelessWidget {
  const _AppearanceTile();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceNotifier>(
      builder: (context, appearance, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.brightness_medium_outlined,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  'Match your device or switch between light and dark mode.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _AppearanceOption(
                      icon: Icons.phone_android_rounded,
                      label: 'System',
                      isSelected: appearance.mode == AppearanceMode.system,
                      onTap: () => appearance.setMode(AppearanceMode.system),
                    ),
                    _AppearanceOption(
                      icon: Icons.wb_sunny_outlined,
                      label: 'Light',
                      isSelected: appearance.mode == AppearanceMode.light,
                      onTap: () => appearance.setMode(AppearanceMode.light),
                    ),
                    _AppearanceOption(
                      icon: Icons.dark_mode_outlined,
                      label: 'Dark',
                      isSelected: appearance.mode == AppearanceMode.dark,
                      onTap: () => appearance.setMode(AppearanceMode.dark),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Notifications Toggle Tile ─────────────────────────────────────────────────

class _NotificationsTile extends StatelessWidget {
  const _NotificationsTile();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final enabled = appState.notificationsEnabled;

    return ListTile(
      leading: Icon(
        enabled
            ? Icons.notifications_active_outlined
            : Icons.notifications_off_outlined,
        color: Theme.of(context).textTheme.bodySmall?.color,
        size: 20,
      ),
      title: Text(
        'Notifications',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        enabled
            ? 'Daily reminders and achievements enabled'
            : 'Notifications are turned off',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Switch.adaptive(
        value: enabled,
        onChanged: (value) => appState.setNotificationsEnabled(value),
        activeTrackColor: AppTheme.primaryColor,
      ),
      dense: true,
    );
  }
}

// ── Appearance Option Button ──────────────────────────────────────────────────

class _AppearanceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AppearanceOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).cardTheme.color
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                scale: isSelected ? 1.0 : 0.9,
                child: Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? Theme.of(context).textTheme.titleSmall?.color
                      : Theme.of(context).textTheme.bodySmall?.color,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Settings Tile ─────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppTheme.dangerColor
        : Theme.of(context).textTheme.titleSmall?.color;

    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? AppTheme.dangerColor
            : Theme.of(context).textTheme.bodySmall?.color,
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF9AA0A8),
        size: 20,
      ),
      onTap: onTap,
      dense: true,
    );
  }
}
