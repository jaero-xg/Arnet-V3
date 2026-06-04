// lib/screens/create_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'main_shell.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _nameController = TextEditingController();
  int _selectedAvatarIndex = 0;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _createProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await context.read<AppState>().createProfile(name, _selectedAvatarIndex);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              // Logo
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('ARNET',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.primaryLight,
                      letterSpacing: 2)),
              const SizedBox(height: 32),
              Text('Create Profile',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Select an avatar and enter your name to begin.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              // Selected avatar display
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFF455A64).withValues(alpha: .1),
                child: Text(
                  avatarList[_selectedAvatarIndex]['emoji'],
                  style: const TextStyle(fontSize: 36),
                ),
              ),
              const SizedBox(height: 6),
              Text('Select an avatar',
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 16),
              // Avatar grid
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: avatarList.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedAvatarIndex == index;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedAvatarIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primaryColor.withValues(alpha: .12)
                                : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(avatarList[index]['emoji'],
                                  style: const TextStyle(fontSize: 28)),
                              const SizedBox(height: 4),
                              Text(
                                avatarList[index]['label'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected
                                      ? AppTheme.primaryColor
                                      : Theme.of(context).textTheme.bodySmall?.color,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  hintText: 'Enter your full name',
                  prefixIcon:
                      Icon(Icons.person_outline, color: AppTheme.primaryLight),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _isLoading ? null : _createProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Create Profile',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
