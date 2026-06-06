// lib/screens/main_shell.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'models_screen.dart';
import 'ar_screen.dart';
import 'profile_screen.dart';
import '../theme/app_theme.dart';
import 'dart:ui';

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

class _ARNetNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _ARNetNavBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<_ARNetNavBar> createState() => _ARNetNavBarState();
}

class _ARNetNavBarState extends State<_ARNetNavBar> {
  double _dragStartX = 0;
  int _dragStartIndex = 0;
  double _pillOverride = -1;

  // AR is screen index 2; nav bar only has 3 items (0=Home,1=Models,2=Profile)
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
        icon: Icons.person_outline,
        activeIcon: Icons.person_rounded,
        label: 'Profile'),
  ];

  // nav index 0,1 → screen 0,1 | nav index 2 → screen 3
  int _toScreenIndex(int navIndex) => navIndex >= 2 ? navIndex + 1 : navIndex;
  int _toNavIndex(int screenIndex) =>
      screenIndex > 2 ? screenIndex - 1 : screenIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navSelected =
        widget.selectedIndex == 2 ? 3 : _toNavIndex(widget.selectedIndex);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        child: Row(
          children: [
            // ── Main pill bar (Home / Models / Profile) ──────────────
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withValues(alpha: isDark ? 0.00 : 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      height: 74,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.borderColorDark : Colors.white,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final itemWidth =
                              constraints.maxWidth / _items.length;

                          final pillLeft = _pillOverride >= 0
                              ? _pillOverride
                              : itemWidth * navSelected + 14;

                          return GestureDetector(
                            onHorizontalDragStart: (d) {
                              _dragStartX = d.localPosition.dx;
                              _dragStartIndex = navSelected;
                              setState(() => _pillOverride =
                                  itemWidth * _dragStartIndex + 14);
                            },
                            onHorizontalDragUpdate: (d) {
                              final delta = d.localPosition.dx - _dragStartX;
                              final raw =
                                  itemWidth * _dragStartIndex + 14 + delta;
                              final clamped = raw.clamp(
                                14.0,
                                constraints.maxWidth - itemWidth + 14,
                              );
                              setState(() => _pillOverride = clamped);
                            },
                            onHorizontalDragEnd: (d) {
                              final pillCenter =
                                  _pillOverride + (itemWidth - 28) / 2;
                              final nearest = (pillCenter / itemWidth)
                                  .floor()
                                  .clamp(0, _items.length - 1);
                              setState(() => _pillOverride = -1);
                              widget.onDestinationSelected(
                                  _toScreenIndex(nearest));
                              HapticFeedback.selectionClick();
                            },
                            child: Stack(
                              children: [
                                // ── Glass pill ────────────────────────
                                AnimatedPositioned(
                                  duration: _pillOverride >= 0
                                      ? Duration.zero
                                      : const Duration(milliseconds: 380),
                                  curve: Curves.easeOutCubic,
                                  left: pillLeft,
                                  top: 10,
                                  bottom: 10,
                                  width: itemWidth - 28,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppTheme.primaryColor
                                              .withValues(alpha: 0.22)
                                          : AppTheme.primaryColor
                                              .withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                ),

                                // ── Nav items ─────────────────────────
                                Row(
                                  children:
                                      List.generate(_items.length, (index) {
                                    final item = _items[index];
                                    final isSelected = index == navSelected;

                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          widget.onDestinationSelected(
                                              _toScreenIndex(index));
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedScale(
                                              duration: const Duration(
                                                  milliseconds: 220),
                                              curve: Curves.easeOutBack,
                                              scale: isSelected ? 1.15 : 1.0,
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 220),
                                                transitionBuilder:
                                                    (child, anim) =>
                                                        FadeTransition(
                                                  opacity: anim,
                                                  child: ScaleTransition(
                                                      scale: anim,
                                                      child: child),
                                                ),
                                                child: Icon(
                                                  isSelected
                                                      ? item.activeIcon
                                                      : item.icon,
                                                  key: ValueKey(
                                                      '${item.label}_$isSelected'),
                                                  size: 22,
                                                  color: isSelected
                                                      ? AppTheme.primaryColor
                                                      : (isDark
                                                          ? Colors.white
                                                              .withValues(
                                                                  alpha: 0.35)
                                                          : const Color(
                                                              0xFF9AA0A8)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            AnimatedDefaultTextStyle(
                                              duration: const Duration(
                                                  milliseconds: 220),
                                              curve: Curves.easeOut,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                color: isSelected
                                                    ? AppTheme.primaryColor
                                                    : (isDark
                                                        ? Colors.white
                                                            .withValues(
                                                                alpha: 0.35)
                                                        : const Color(
                                                            0xFF9AA0A8)),
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // ── AR button ────────────────────────────────────────────
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.00 : 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onDestinationSelected(2);
                    },
                    child: Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.view_in_ar_outlined,
                              size: 32, color: AppTheme.surfaceColorLight),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
