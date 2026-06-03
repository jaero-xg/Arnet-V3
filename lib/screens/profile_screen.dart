// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    if (profile == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProfileHeader(profile: profile),
          const SizedBox(height: 20),
          const _SectionTitle(title: 'Progress Overview'),
          const SizedBox(height: 10),
          _ProgressCards(profile: profile),
          const SizedBox(height: 20),
          if (profile.recentLessons.isNotEmpty) ...[
            const _SectionTitle(title: 'Recent Lessons'),
            const SizedBox(height: 10),
            _ActivityList(
                activities: profile.recentLessons.take(5).toList(),
                icon: Icons.menu_book_outlined),
            const SizedBox(height: 20),
          ],
          if (profile.quizRecords.isNotEmpty) ...[
            const _SectionTitle(title: 'Recent Quiz Records'),
            const SizedBox(height: 10),
            _QuizRecordList(records: profile.quizRecords.take(5).toList()),
            const SizedBox(height: 20),
          ],
          if (profile.recentModels.isNotEmpty) ...[
            const _SectionTitle(title: 'Recent 3D Models'),
            const SizedBox(height: 10),
            _ActivityList(
                activities: profile.recentModels.take(5).toList(),
                icon: Icons.view_in_ar_outlined),
            const SizedBox(height: 20),
          ],
          if (profile.achievements.isNotEmpty) ...[
            const _SectionTitle(title: 'Achievements'),
            const SizedBox(height: 10),
            _AchievementsSection(achievements: profile.achievements),
            const SizedBox(height: 20),
          ],
          const _SectionTitle(title: 'Settings'),
          const SizedBox(height: 10),
          _SettingsSection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final LearnerProfile profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppTheme.primaryColor.withValues(alpha: .1),
              child: Text(
                avatarList[profile.avatarIndex]['emoji'],
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'Joined ${DateFormat('MMM d, yyyy').format(profile.dateCreated)}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressCards extends StatelessWidget {
  final LearnerProfile profile;
  const _ProgressCards({required this.profile});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
          color: AppTheme.successColor,
        ),
        _ProgressCard(
          icon: Icons.view_in_ar_outlined,
          label: 'AR Sessions',
          value: '${profile.arSessions}',
          color: Colors.deepPurple,
        ),
        _ProgressCard(
          icon: Icons.quiz_outlined,
          label: 'Avg. Quiz Score',
          value: '${profile.averageQuizScore.toInt()}%',
          color: AppTheme.warningColor,
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ProgressCard(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 22),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color)),
                Text(label,
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    maxLines: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _ActivityList extends StatelessWidget {
  final List<RecentActivity> activities;
  final IconData icon;

  const _ActivityList({required this.activities, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: activities.asMap().entries.map((e) {
          final isLast = e.key == activities.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Icon(icon, color: AppTheme.primaryLight, size: 20),
                title: Text(e.value.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                trailing: Text(
                  DateFormat('MMM d').format(e.value.date),
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                dense: true,
              ),
              if (!isLast)
                Divider(height: 1, indent: 52, color: Colors.grey[100]),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _QuizRecordList extends StatelessWidget {
  final List<QuizRecord> records;
  const _QuizRecordList({required this.records});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: records.asMap().entries.map((e) {
          final record = e.value;
          final isLast = e.key == records.length - 1;
          final color = record.percentage >= 80
              ? AppTheme.successColor
              : record.percentage >= 60
                  ? AppTheme.warningColor
                  : Colors.redAccent;
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.quiz_outlined,
                    color: AppTheme.primaryLight, size: 20),
                title: Text(record.title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                subtitle: Text(DateFormat('MMM d, yyyy').format(record.date),
                    style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${record.percentage.toInt()}%',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                ),
                dense: true,
              ),
              if (!isLast)
                Divider(height: 1, indent: 52, color: Colors.grey[100]),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _AchievementsSection extends StatelessWidget {
  final List<String> achievements;
  const _AchievementsSection({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: achievements.map((a) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(a,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryDark)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.edit_outlined,
            label: 'Edit Profile',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            ),
          ),
          Divider(height: 1, indent: 52, color: Colors.grey[100]),
          _SettingsTile(
            icon: Icons.refresh,
            label: 'Reset Progress',
            isDestructive: true,
            onTap: () => _confirmReset(context),
          ),
        ],
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
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

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
    final color = isDestructive ? Colors.red : AppTheme.primaryDark;
    return ListTile(
      leading: Icon(icon,
          color: isDestructive ? Colors.red : AppTheme.primaryLight, size: 20),
      title: Text(label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: color)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400], size: 18),
      onTap: onTap,
      dense: true,
    );
  }
}
