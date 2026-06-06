// lib/screens/settings_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../state/app_state.dart';
import '../state/appearance_notifier.dart';
import '../theme/app_theme.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isOnline = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySub;

  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then((results) {
      if (mounted) {
        setState(() => _isOnline = !results.contains(ConnectivityResult.none));
      }
    });
    _connectivitySub = Connectivity().onConnectivityChanged.listen((results) {
      if (mounted) {
        setState(() => _isOnline = !results.contains(ConnectivityResult.none));
      }
    });
  }

  @override
  void dispose() {
    _connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ───────────────────────────────────────────────
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
                    height: 36,
                    width: 36,
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
              ),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isOnline
                              ? Icons.wifi_rounded
                              : Icons.wifi_off_rounded,
                          size: 20,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _isOnline ? 'Online' : 'Offline',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Section: Appearance ──────────────────────────────────
            const SliverToBoxAdapter(
              child: _SectionLabel(title: 'Appearance'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const _AppearanceTile(),
                ),
              ),
            ),

            // ── Section: Notifications ───────────────────────────────
            const SliverToBoxAdapter(
              child: _SectionLabel(title: 'Notifications'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const _NotificationsTile(),
                ),
              ),
            ),

            // ── Section: Account ─────────────────────────────────────
            const SliverToBoxAdapter(
              child: _SectionLabel(title: 'Account'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      _SettingsTile(
                        icon: Icons.edit_outlined,
                        label: 'Edit Profile',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfileScreen()),
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
              ),
            ),

            // ── Section: Connectivity ────────────────────────────────
            const SliverToBoxAdapter(
              child: _SectionLabel(title: 'Connectivity'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                AppTheme.primaryColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            _isOnline
                                ? Icons.wifi_rounded
                                : Icons.wifi_off_rounded,
                            size: 20,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Network status',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              const SizedBox(height: 2),
                              Text(
                                _isOnline ? 'Connected' : 'No connection',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _isOnline
                                ? AppTheme.primaryColor.withValues(alpha: 0.10)
                                : Colors.red.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _isOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _isOnline
                                  ? AppTheme.primaryColor
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Section: About ───────────────────────────────────────
            const SliverToBoxAdapter(
              child: _SectionLabel(title: 'About'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.info_outline_rounded,
                                  size: 20, color: AppTheme.primaryColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('App version',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  const SizedBox(height: 2),
                                  Text('ARNET v1.0.0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 52,
                        color: Theme.of(context).dividerTheme.color,
                      ),
                      _SettingsTile(
                        icon: Icons.description_outlined,
                        label: 'Licenses',
                        onTap: () => showLicensePage(context: context),
                      ),
                    ],
                  ),
                ),
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

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9AA0A8),
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Appearance tile ───────────────────────────────────────────────────────────

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
                  Text('Appearance',
                      style: Theme.of(context).textTheme.titleSmall),
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

// ── Notifications tile ────────────────────────────────────────────────────────

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
      title:
          Text('Notifications', style: Theme.of(context).textTheme.titleSmall),
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

// ── Appearance option ─────────────────────────────────────────────────────────

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

// ── Settings tile ─────────────────────────────────────────────────────────────

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
