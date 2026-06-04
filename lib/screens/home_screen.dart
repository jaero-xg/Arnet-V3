// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'module_details_screen.dart';
import 'model_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.surfaceColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: AppTheme.primaryColor,
                  unselectedLabelColor: Colors.grey[400],
                  indicatorColor: AppTheme.primaryColor,
                  indicatorWeight: 2.5,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                  tabs: const [
                    Tab(text: 'Modules'),
                    Tab(text: '3D Models'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    _ModulesTab(),
                    _ModelsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppTheme.primaryColor.withValues(alpha: .1),
            child: Text(
              avatarList[profile?.avatarIndex ?? 0]['emoji'],
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(fontSize: 11, color: Colors.grey[400]),
              ),
              Text(
                profile?.name ?? 'Learner',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryDark,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off, size: 12, color: AppTheme.primaryColor),
                SizedBox(width: 4),
                Text(
                  'Offline',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModulesTab extends StatelessWidget {
  const _ModulesTab();

  @override
  Widget build(BuildContext context) {
    final modules = context.watch<AppState>().modules;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      itemCount: modules.length,
      itemBuilder: (context, index) => _ModuleCard(module: modules[index]),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final LearningModule module;
  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    final pct = module.completionPercentage;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ModuleDetailsScreen(module: module)),
        ),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(module.thumbnailEmoji,
                      style: const TextStyle(fontSize: 26)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(module.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 1),
                    Text(
                      '${module.lessons.length} Lessons',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: pct / 100,
                              backgroundColor: Colors.grey[200],
                              color: pct == 100
                                  ? AppTheme.successColor
                                  : AppTheme.primaryColor,
                              minHeight: 4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${pct.toInt()}%',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModelsTab extends StatelessWidget {
  const _ModelsTab();

  @override
  Widget build(BuildContext context) {
    final models = context.watch<AppState>().models;
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: models.length,
      itemBuilder: (context, index) => _ModelCard(model: models[index]),
    );
  }
}

class _ModelCard extends StatelessWidget {
  final Model3D model;
  const _ModelCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModelDetailsScreen(model: model)),
        ),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: .07),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.string(
                    model.thumbnailSvg,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                model.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryDark),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                model.category,
                style: TextStyle(fontSize: 11, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
