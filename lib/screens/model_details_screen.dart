// lib/screens/model_details_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/app_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../data/network_svgs.dart';
import '../data/model_assets.dart';
import 'module_details_screen.dart';

class ModelDetailsScreen extends StatefulWidget {
  final Model3D model;
  const ModelDetailsScreen({super.key, required this.model});

  @override
  State<ModelDetailsScreen> createState() => _ModelDetailsScreenState();
}

class _ModelDetailsScreenState extends State<ModelDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().recordModelViewed(widget.model.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final modules = context.read<AppState>().modules;
    final relatedModule = modules.firstWhere(
      (m) => m.id == model.relatedModuleId,
      orElse: () => modules.first,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── Sticky App Bar ─────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.greenTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            title: Text(
              '3D Model',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 0.8,
                color: Theme.of(context).dividerTheme.color ??
                    AppTheme.borderColorLight,
              ),
            ),
          ),

          // ── Large Preview ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _ModelPreview(model: model),
          ),

          // ── Model Name ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                model.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // ── Description ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Text(
                model.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),

          // ── Model Information ────────────────────────────────────────
          const SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Model Information',
              trailing: null,
            ),
          ),
          SliverToBoxAdapter(
            child: _ModelInfoCard(model: model, relatedModule: relatedModule),
          ),

          // ── Action Buttons ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _RelatedLessonButton(relatedModule: relatedModule),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: _ARLaunchButton(),
            ),
          ),

          // ── Bottom safe padding ─────────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 96 + MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Model Preview ─────────────────────────────────────────────────────────────
// Renders the real asset image at assets/images/models/{id}.png. Falls back
// to the matching NetworkSvgs outline icon (then a generic icon) if the
// asset is missing, same pattern used in the models grid.

class _ModelPreview extends StatelessWidget {
  final Model3D model;
  const _ModelPreview({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                ModelAssets.pathFor(model.id),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  final fallbackSvg = NetworkSvgs.forId(model.id);
                  return Center(
                    child: fallbackSvg != null
                        ? SvgPicture.string(
                            fallbackSvg,
                            width: 80,
                            height: 80,
                            colorFilter: const ColorFilter.mode(
                              AppTheme.primaryColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : Icon(
                            Icons.view_in_ar_rounded,
                            size: 64,
                            color: AppTheme.primaryColor.withValues(alpha: 0.5),
                          ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              model.category,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
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
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          if (trailing != null)
            Text(
              trailing!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
        ],
      ),
    );
  }
}

// ── Model Info Card ───────────────────────────────────────────────────────────

class _ModelInfoCard extends StatelessWidget {
  final Model3D model;
  final LearningModule relatedModule;
  const _ModelInfoCard({
    required this.model,
    required this.relatedModule,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(label: 'Model Name', value: model.name),
            Divider(
                height: 20,
                color: Theme.of(context).dividerTheme.color ??
                    AppTheme.borderColorLight),
            _InfoRow(label: 'Category', value: model.category),
            Divider(
                height: 20,
                color: Theme.of(context).dividerTheme.color ??
                    AppTheme.borderColorLight),
            _InfoRow(
                label: 'Learning Objective', value: model.learningObjective),
            Divider(
                height: 20,
                color: Theme.of(context).dividerTheme.color ??
                    AppTheme.borderColorLight),
            _InfoRow(label: 'Related Module', value: relatedModule.title),
          ],
        ),
      ),
    );
  }
}

// ── Info Row ──────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.titleSmall?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Related Lesson Button ─────────────────────────────────────────────────────

class _RelatedLessonButton extends StatelessWidget {
  final LearningModule relatedModule;
  const _RelatedLessonButton({required this.relatedModule});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ModuleDetailsScreen(module: relatedModule),
        ),
      ),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.greenTint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.menu_book_outlined,
                color: AppTheme.primaryColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Open Related Lesson',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    relatedModule.title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: isDark
                  ? AppTheme.textQuaternaryDark
                  : AppTheme.textQuaternaryLight,
            ),
          ],
        ),
      ),
    );
  }
}

// ── AR Launch Button ──────────────────────────────────────────────────────────

class _ARLaunchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<AppState>().incrementArSessions();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('AR session started — Unity integration pending'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        icon: const Icon(Icons.view_in_ar_rounded),
        label: const Text(
          'Start AR Experience',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
