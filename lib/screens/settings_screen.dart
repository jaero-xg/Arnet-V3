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
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.greenTint,
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
            Row(
              children: [
                _VersionBadge(label: 'Current', version: result.currentVersion),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward_rounded,
                      size: 14, color: AppTheme.textTertiaryLight),
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
              Text("What's new", style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(result.releaseNotes,
                    style: Theme.of(context).textTheme.bodySmall),
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
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.successLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle_outline_rounded,
                  size: 18, color: AppTheme.successColor),
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
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // No SafeArea wrapper — SliverAppBar handles the top inset,
      // and we add bottom padding explicitly in the trailing SizedBox.
      body: CustomScrollView(
        slivers: [
          // ── App Bar — same pattern as Module Details / Lesson Reader ──
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              'Settings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  height: 32,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isOnline ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                        size: 14,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _isOnline ? 'Online' : 'Offline',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Appearance ─────────────────────────────────────────────
          const SliverToBoxAdapter(child: _SectionLabel(title: 'Appearance')),
          SliverToBoxAdapter(
            child: _SettingsGroup(
              children: [const _AppearanceTile()],
            ),
          ),

          // ── Notifications ──────────────────────────────────────────
          const SliverToBoxAdapter(
              child: _SectionLabel(title: 'Notifications')),
          SliverToBoxAdapter(
            child: _SettingsGroup(
              children: [const _NotificationsTile()],
            ),
          ),

          // ── Account ────────────────────────────────────────────────
          const SliverToBoxAdapter(child: _SectionLabel(title: 'Account')),
          SliverToBoxAdapter(
            child: _SettingsGroup(
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
                const _GroupDivider(),
                _SettingsTile(
                  icon: Icons.refresh_rounded,
                  label: 'Reset Progress',
                  isDestructive: true,
                  onTap: () => _confirmReset(context),
                ),
              ],
            ),
          ),

          // ── About ──────────────────────────────────────────────────
          const SliverToBoxAdapter(child: _SectionLabel(title: 'About')),
          SliverToBoxAdapter(
            child: _SettingsGroup(
              children: [
                // Version info — using same _SettingsTile layout for
                // consistent icon + text alignment across all rows
                _InfoTile(
                  icon: Icons.info_outline_rounded,
                  label: 'App version',
                  value: 'ARNET v$_currentVersion',
                ),
                const _GroupDivider(),
                _UpdateTile(
                  isOnline: _isOnline,
                  isChecking: _isCheckingUpdate,
                  onTap:
                      _isOnline && !_isCheckingUpdate ? _checkForUpdates : null,
                ),
                const _GroupDivider(),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  label: 'Licenses',
                  onTap: () => showLicensePage(context: context),
                ),
              ],
            ),
          ),

          // Bottom clearance — safe area aware
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32 + MediaQuery.of(context).padding.bottom,
            ),
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
            child: const Text('Reset',
                style: TextStyle(color: AppTheme.dangerColor)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  SETTINGS GROUP — card container matching app's borderRadius language
//  BorderRadius.circular(14) to match _LessonCard / _SectionCard
// ═══════════════════════════════════════════════════════════════════════════════

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

// ── Thin divider between rows inside a group ──────────────────────────────────

class _GroupDivider extends StatelessWidget {
  const _GroupDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      // 20 (card padding) + 40 (icon) + 14 (gap) = 74 to align under text
      indent: 74,
      endIndent: 0,
      color: Theme.of(context).dividerTheme.color,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  SECTION LABEL — spaced to align with 20px card horizontal padding
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      // Matches the 20px horizontal padding of _SettingsGroup
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark
                  ? AppTheme.textTertiaryDark
                  : AppTheme.textTertiaryLight,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  SETTINGS TILE — icon badge + label + chevron
//  Uses explicit layout (not ListTile) for pixel-perfect alignment
// ═══════════════════════════════════════════════════════════════════════════════

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;
    final iconColor =
        isDestructive ? AppTheme.dangerColor : AppTheme.primaryColor;
    final iconTint = isDestructive ? AppTheme.dangerLight : AppTheme.greenTint;
    final labelColor = isDestructive
        ? AppTheme.dangerColor
        : theme.textTheme.titleSmall?.color;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Icon badge — same 40×40 / radius-10 as _SectionCard
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: labelColor,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: tertiaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  INFO TILE — read-only row (icon + label + value), no chevron
//  Used for version display so it aligns with _SettingsTile rows
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(value, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  UPDATE TILE — same layout as _SettingsTile with conditional trailing
// ═══════════════════════════════════════════════════════════════════════════════

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;
    final labelColor =
        isOnline ? theme.textTheme.titleSmall?.color : tertiaryText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.greenTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.system_update_outlined,
                  size: 20,
                  color: isOnline ? AppTheme.primaryColor : tertiaryText,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check for Updates',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: labelColor),
                    ),
                    if (!isOnline) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Connect to the internet to check',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              if (isChecking)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.primaryColor,
                  ),
                )
              else
                Icon(Icons.chevron_right_rounded,
                    size: 18, color: tertiaryText),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  VERSION BADGE — used in update dialog
// ═══════════════════════════════════════════════════════════════════════════════

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(color: tertiaryText),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color:
                highlight ? AppTheme.greenTint : theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: highlight
                ? Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3))
                : null,
          ),
          child: Text(
            'v$version',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: highlight ? AppTheme.primaryColor : tertiaryText,
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  APPEARANCE TILE — theme switcher
// ═══════════════════════════════════════════════════════════════════════════════

class _AppearanceTile extends StatelessWidget {
  const _AppearanceTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<AppearanceNotifier>(
      builder: (context, appearance, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.greenTint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.brightness_medium_outlined,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Appearance', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 2),
                        Text(
                          'Match your device or choose a mode.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
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

// ═══════════════════════════════════════════════════════════════════════════════
//  NOTIFICATIONS TILE
// ═══════════════════════════════════════════════════════════════════════════════

class _NotificationsTile extends StatefulWidget {
  const _NotificationsTile();

  @override
  State<_NotificationsTile> createState() => _NotificationsTileState();
}

class _NotificationsTileState extends State<_NotificationsTile> {
  late bool _enabled;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _enabled = context.read<AppState>().notificationsEnabled;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;

    // Badge tint + icon color react to toggle state:
    //   enabled  → greenTint bg + primaryColor icon  (same as all other tiles)
    //   disabled → muted bg    + tertiary icon        (visually "off")
    // Badge tint + icon color react to toggle state:
    //   enabled  → greenTint bg + primaryColor icon  (same as all other tiles)
    //   disabled → muted bg    + tertiary icon        (visually "off")
    final badgeTint = _enabled
        ? AppTheme.greenTint
        : (isDark ? AppTheme.borderColorDark : AppTheme.borderColorLight);
    final iconColor = _enabled ? AppTheme.primaryColor : tertiaryText;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: badgeTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _enabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notifications', style: theme.textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(
                  _enabled
                      ? 'Daily reminders and achievements on'
                      : 'Notifications are turned off',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _enabled,
            onChanged: (value) {
              setState(() => _enabled = value);
              context.read<AppState>().setNotificationsEnabled(value);
            },
            activeTrackColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  APPEARANCE OPTION — animated segment inside the switcher track
// ═══════════════════════════════════════════════════════════════════════════════

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiaryText =
        isDark ? AppTheme.textTertiaryDark : AppTheme.textTertiaryLight;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.cardTheme.color : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                scale: isSelected ? 1.0 : 0.88,
                child: Icon(
                  icon,
                  size: 18,
                  color: isSelected ? AppTheme.primaryColor : tertiaryText,
                ),
              ),
              const SizedBox(width: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected
                      ? theme.textTheme.titleSmall?.color
                      : tertiaryText,
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
