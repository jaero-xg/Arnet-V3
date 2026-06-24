// lib/screens/models_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import '../data/network_svgs.dart';
import '../data/model_assets.dart';
import 'model_details_screen.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({super.key});

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final models = context.watch<AppState>().models;

    final categories = [
      'All',
      ...{for (final m in models) m.category},
    ];

    final filtered = _selectedCategory == 'All'
        ? models
        : models.where((m) => m.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header (mirrors Home's top bar + greeting block) ─────────
            SliverToBoxAdapter(
              child: _ModelsHeader(modelCount: models.length),
            ),

            // ── Category chips ────────────────────────────────────────
            SliverToBoxAdapter(
              child: _CategoryChips(
                categories: categories,
                selected: _selectedCategory,
                onSelected: (cat) => setState(() => _selectedCategory = cat),
              ),
            ),

            // ── Section header (mirrors Home's "Your modules" row) ────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  children: [
                    Text(
                      _selectedCategory == 'All'
                          ? 'All models'
                          : _selectedCategory,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      '${filtered.length} model${filtered.length == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Model grid / empty state ───────────────────────────────
            filtered.isEmpty
                ? const SliverToBoxAdapter(child: _EmptyState())
                : SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      96 + MediaQuery.of(context).padding.bottom,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.95,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _ModelCard(model: filtered[index]),
                        childCount: filtered.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────
// Mirrors Home's _TopBar + _Greeting: transparent over scaffold bg, 20px
// horizontal padding, same date-style caption treatment.

class _ModelsHeader extends StatelessWidget {
  final int modelCount;
  const _ModelsHeader({required this.modelCount});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPLORE & VIEW IN AR'.toUpperCase(),
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppTheme.textTertiaryDark
                  : AppTheme.textTertiaryLight,
              letterSpacing: 0.9,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).textTheme.headlineMedium?.color,
                letterSpacing: -0.2,
              ),
              children: const [
                TextSpan(text: '3D '),
                TextSpan(
                  text: 'Models',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                _StatItem(
                  icon: Icons.view_in_ar_rounded,
                  label: '$modelCount',
                  sublabel: 'Models',
                ),
                _StatDivider(),
                const _StatItem(
                  icon: Icons.category_outlined,
                  label: 'Browse',
                  sublabel: 'Category',
                ),
                _StatDivider(),
                const _StatItem(
                  icon: Icons.touch_app_outlined,
                  label: 'Tap',
                  sublabel: 'View AR',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  const _StatItem({
    required this.icon,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  sublabel,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8,
      height: 30,
      color: Theme.of(context).dividerTheme.color ?? AppTheme.borderColorLight,
    );
  }
}

// ── Category Chips ────────────────────────────────────────────────────────────
// Same selected/unselected treatment as Home (solid primaryColor, no
// gradient), but on transparent background to match Home's section flow.

class _CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const _CategoryChips({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        height: 52,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final cat = categories[index];
            final isSelected = cat == selected;
            return GestureDetector(
              onTap: () => onSelected(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    cat,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                              ? AppTheme.textTertiaryDark
                              : AppTheme.textTertiaryLight),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Model Card ────────────────────────────────────────────────────────────────
// Rebuilt on the same shell as Home's _ModuleCard: cardTheme.color background,
// 18px radius, greenTint icon container with primaryColor accents, the "View"
// tag now uses the same pill treatment as Home's progress percentage label.

class _ModelCard extends StatelessWidget {
  final Model3D model;
  const _ModelCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ModelDetailsScreen(model: model)),
          ),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.greenTint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        ModelAssets.pathFor(model.id),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          final fallbackSvg = NetworkSvgs.forId(model.id);
                          return Center(
                            child: fallbackSvg != null
                                ? SvgPicture.string(
                                    fallbackSvg,
                                    width: 44,
                                    height: 44,
                                    colorFilter: const ColorFilter.mode(
                                      AppTheme.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : Icon(
                                    Icons.view_in_ar_rounded,
                                    size: 36,
                                    color: AppTheme.primaryColor
                                        .withValues(alpha: 0.5),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.category,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'View',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────
// Matches Home's _EmptyModules exactly: 72px greenTint icon block, radius 18,
// same spacing rhythm and typography roles.

class _EmptyState extends StatelessWidget {
  const _EmptyState();

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
                Icons.layers_outlined,
                size: 34,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            Text('No models found',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Try selecting a different category.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
