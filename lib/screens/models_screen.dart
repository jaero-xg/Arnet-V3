// lib/screens/models_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
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
            SliverToBoxAdapter(
              child: _ModelsHeader(modelCount: models.length),
            ),
            SliverToBoxAdapter(
              child: _CategoryChips(
                categories: categories,
                selected: _selectedCategory,
                onSelected: (cat) => setState(() => _selectedCategory = cat),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  children: [
                    Text(
                      _selectedCategory == 'All'
                          ? 'All models'
                          : _selectedCategory,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text(
                      '${filtered.length} model${filtered.length == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            filtered.isEmpty
                ? SliverToBoxAdapter(child: _EmptyState())
                : SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
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

class _ModelsHeader extends StatelessWidget {
  final int modelCount;
  const _ModelsHeader({required this.modelCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3D Models',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Explore and view in AR',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                _StatItem(
                  icon: Icons.view_in_ar_rounded,
                  iconColor: AppTheme.primaryColor,
                  label: '$modelCount',
                  sublabel: 'Models',
                ),
                _StatDivider(),
                const _StatItem(
                  icon: Icons.category_outlined,
                  iconColor: AppTheme.primaryColor,
                  label: 'Browse',
                  sublabel: 'Category',
                ),
                _StatDivider(),
                const _StatItem(
                  icon: Icons.touch_app_outlined,
                  iconColor: AppTheme.primaryColor,
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
  final Color iconColor;
  final String label;
  final String sublabel;
  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // ← don't stretch unnecessarily
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).cardTheme.color, // ← white, not scaffoldBg
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 8),
          Flexible(
            // ← lets text shrink/wrap
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis, // ← safety net
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
    return Container(
      color: Theme.of(context).cardTheme.color,
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 0.8,
            color: Theme.of(context).dividerTheme.color ??
                AppTheme.borderColorLight,
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : const Color(0xFF6C7078),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Model Card ────────────────────────────────────────────────────────────────

class _ModelCard extends StatelessWidget {
  final Model3D model;
  const _ModelCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModelDetailsScreen(model: model)),
        ),
        borderRadius: BorderRadius.circular(26),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: SvgPicture.string(
                      model.thumbnailSvg,
                      width: 56,
                      height: 56,
                      colorFilter: const ColorFilter.mode(
                        // ← explicit neutral tint
                        Color(0xFF8BAAB8),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                model.name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall, // ← was hardcoded primaryColor
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      model.category,
                      style:
                          Theme.of(context).textTheme.bodySmall, // ← use theme
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColorLight,
                borderRadius: BorderRadius.circular(26),
              ),
              child: const Icon(
                Icons.layers_outlined,
                size: 36,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No models found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
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
