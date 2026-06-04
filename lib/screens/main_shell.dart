// lib/screens/main_shell.dart

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

  final List<Widget> _screens = const [
    HomeScreen(),
    ModelsScreen(),
    ARScreen(),
    ProfileScreen(),
  ];

  void _onDestinationSelected(int index) {
    HapticFeedback.lightImpact();
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _ARNetNavBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _ARNetNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _ARNetNavBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  static const _items = [
    _NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home'),
    _NavItem(
        icon: Icons.layers_outlined,
        activeIcon: Icons.layers_rounded,
        label: 'Models'),
    _NavItem(
        icon: Icons.view_in_ar_outlined,
        activeIcon: Icons.view_in_ar_rounded,
        label: 'AR'),
    _NavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person_rounded,
        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / _items.length;

              return Stack(
                children: [
                  // Sliding active pill
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    left: itemWidth * selectedIndex + 6,
                    top: 6,
                    bottom: 6,
                    width: itemWidth - 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  // Navigation Items
                  Row(
                    children: List.generate(_items.length, (index) {
                      final item = _items[index];
                      final isSelected = index == selectedIndex;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => onDestinationSelected(index),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedScale(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutBack,
                                scale: isSelected ? 1.12 : 1.0,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    isSelected ? item.activeIcon : item.icon,
                                    key: ValueKey('${item.label}_$isSelected'),
                                    size: 22,
                                    color: isSelected
                                        ? AppTheme.accentColor
                                        : const Color(0xFF8BAAB8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? AppTheme.accentColor
                                      : const Color(0xFF8BAAB8),
                                ),
                                child: Text(item.label),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
