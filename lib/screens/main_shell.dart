import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'models_screen.dart';
import 'ar_screen.dart';
import 'profile_screen.dart';
import '../theme/app_theme.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        onGoToModels: () => _onDestinationSelected(1),
        onGoToAR: () => _onDestinationSelected(2),
      ),
      const ModelsScreen(),
      const ARScreen(),
      const ProfileScreen(),
    ];
  }

  void _onDestinationSelected(int index) {
    if (index == _selectedIndex) return;
    HapticFeedback.selectionClick();
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: _ModernNavBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  MODERN NAV BAR — Messenger / Instagram style: icon-only, soft floating
//  pill indicator behind the active icon, simple and premium.
// ═══════════════════════════════════════════════════════════════════════════════

class _ModernNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _ModernNavBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  static const _navItems = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded),
    _NavItem(
        icon: Icons.grid_view_outlined, activeIcon: Icons.grid_view_rounded),
    _NavItem(
        icon: Icons.view_in_ar_outlined, activeIcon: Icons.view_in_ar_rounded),
    _NavItem(
        icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0B1320) : const Color(0xFFFFFFFF);
    final inactiveColor =
        isDark ? const Color(0xFF5C6B7E) : const Color(0xFFA0AAB6);
    final borderColor =
        isDark ? const Color(0xFF1C2733) : const Color(0xFFE7EAEE);
    const activeColor = AppTheme.primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: borderColor, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 54,
          child: Row(
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isSelected = index == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onDestinationSelected(index),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 160),
                      transitionBuilder: (child, anim) => ScaleTransition(
                        scale: anim,
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: Icon(
                        isSelected ? item.activeIcon : item.icon,
                        key: ValueKey('${index}_$isSelected'),
                        size: 27,
                        color: isSelected ? activeColor : inactiveColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  const _NavItem({required this.icon, required this.activeIcon});
}
