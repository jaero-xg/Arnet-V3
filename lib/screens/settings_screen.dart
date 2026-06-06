// lib/screens/settings_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/version_checker.dart';
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

  // ── Version state ──────────────────────────────────────────────
  String _currentVersion = '...';
  bool _isCheckingUpdate = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentVersion();

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

  Future<void> _loadCurrentVersion() async {
    final version = await VersionChecker.getCurrentVersion();
    if (mounted) setState(() => _currentVersion = version);
  }

  @override
  void dispose() {
    _connectivitySub.cancel();
    super.dispose();
  }

  // ── Update check ───────────────────────────────────────────────
  Future<void> _checkForUpdates() async {
    if (_isCheckingUpdate) return;
    setState(() => _isCheckingUpdate = true);

    try {
      final result = await VersionChecker.checkForUpdate();
      if (!mounted) return;

      if (result.updateAvailable) {
        _showUpdateAvailableDialog(result);
      } else {
        _showUpToDateDialog(result.currentVersion);
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackbar();
    } finally {
      if (mounted) setState(() => _isCheckingUpdate = false);
    }
  }

  void _showUpdateAvailableDialog(UpdateCheckResult result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.system_update_outlined,
                  size: 18, color: AppTheme.primaryColor),
            ),
            const SizedBox(width: 10),
            const Text('Update Available'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Version badge row
            Row(
              children: [
                _VersionBadge(label: 'Current', version: result.currentVersion),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward_rounded,
                      size: 14, color: Color(0xFF9AA0A8)),
                ),
                _VersionBadge(
                  label: 'Latest',
                  version: result.latestVersion,
                  highlight: true,
                ),
              ],
            ),
            if (result.releaseNotes.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                "What's new",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  result.releaseNotes,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.open_in_new_rounded, size: 16),
            label: const Text('Update Now'),
            onPressed: () async {
              Navigator.pop(context);
              final uri = Uri.parse(result.downloadUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showUpToDateDialog(String version) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle_outline_rounded,
                  size: 18, color: Colors.green),
            ),
            const SizedBox(width: 10),
            const Text("You're up to date"),
          ],
        ),
        content: Text(
          'ARNET v$version is the latest version.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Great'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.error_outline_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Could not check for updates. Try again later.'),
          ],
        ),
        backgroundColor: AppTheme.dangerColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                      // App version row
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
                                  Text(
                                    'ARNET v$_currentVersion',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
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
                      // Check for updates tile
                      _UpdateTile(
                        isOnline: _isOnline,
                        isChecking: _isCheckingUpdate,
                        onTap: _isOnline && !_isCheckingUpdate
                            ? _checkForUpdates
                            : null,
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

// ── Update tile ───────────────────────────────────────────────────────────────

class _UpdateTile extends StatelessWidget {
  final bool isOnline;
  final bool isChecking;
  final VoidCallback? onTap;

  const _UpdateTile({
    required this.isOnline,
    required this.isChecking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.system_update_outlined,
        color: isOnline
            ? Theme.of(context).textTheme.bodySmall?.color
            : const Color(0xFF9AA0A8),
        size: 20,
      ),
      title: Text(
        'Check for Updates',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isOnline
              ? Theme.of(context).textTheme.titleSmall?.color
              : const Color(0xFF9AA0A8),
        ),
      ),
      subtitle: !isOnline
          ? Text(
              'Connect to the internet to check for updates',
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      trailing: isChecking
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.primaryColor,
              ),
            )
          : const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9AA0A8),
              size: 20,
            ),
      onTap: onTap,
      dense: true,
    );
  }
}

// ── Version badge (used in update dialog) ─────────────────────────────────────

class _VersionBadge extends StatelessWidget {
  final String label;
  final String version;
  final bool highlight;

  const _VersionBadge({
    required this.label,
    required this.version,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF9AA0A8)),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: highlight
                ? AppTheme.primaryColor.withValues(alpha: 0.12)
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: highlight
                ? Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3))
                : null,
          ),
          child: Text(
            'v$version',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: highlight
                  ? AppTheme.primaryColor
                  : Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ),
      ],
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
