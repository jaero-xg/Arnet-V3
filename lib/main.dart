// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'state/appearance_notifier.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'screens/create_profile_screen.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.initialize();
  await NotificationService.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => AppearanceNotifier()),
      ],
      child: const EduARApp(),
    ),
  );
}

class EduARApp extends StatelessWidget {
  const EduARApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceNotifier>(
      builder: (context, appearance, _) => MaterialApp(
        title: 'EduAR',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appearance.themeMode,
        home: const _AppRouter(),
      ),
    );
  }
}

class _AppRouter extends StatelessWidget {
  const _AppRouter();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (state.hasProfile) {
      return const MainShell();
    }
    return const CreateProfileScreen();
  }
}
