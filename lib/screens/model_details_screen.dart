// lib/screens/model_details_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
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
      backgroundColor: AppTheme.surfaceColor,
      appBar: AppBar(
          title:
              Text(model.name, style: Theme.of(context).textTheme.titleLarge)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large preview
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 220,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.thumbnailEmoji,
                        style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(model.category,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(model.description,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),
                  // Info section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Model Information',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 12),
                          _InfoRow(label: 'Model Name', value: model.name),
                          const Divider(height: 20, thickness: 0.5),
                          _InfoRow(label: 'Category', value: model.category),
                          const Divider(height: 20, thickness: 0.5),
                          _InfoRow(
                              label: 'Learning Objective',
                              value: model.learningObjective),
                          const Divider(height: 20, thickness: 0.5),
                          _InfoRow(
                              label: 'Related Module',
                              value: relatedModule.title),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Open related lesson
                  OutlinedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ModuleDetailsScreen(module: relatedModule)),
                    ),
                    icon: const Icon(Icons.menu_book_outlined, size: 18),
                    label: const Text('Open Related Lesson'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      foregroundColor: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AppState>().incrementArSessions();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'AR session started — Unity integration pending'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.view_in_ar),
                    label: const Text('Start AR Experience',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(label,
              style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primaryDark)),
        ),
      ],
    );
  }
}
