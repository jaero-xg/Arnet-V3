// lib/screens/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late int _selectedAvatarIndex;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<AppState>().profile!;
    _nameController = TextEditingController(text: profile.name);
    _selectedAvatarIndex = profile.avatarIndex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Name cannot be empty')));
      return;
    }
    setState(() => _isLoading = true);
    await context.read<AppState>().updateProfile(name, _selectedAvatarIndex);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 36,
                backgroundColor: AppTheme.accentColor.withValues(alpha: .1),
                child: Text(
                  avatarList[_selectedAvatarIndex]['emoji'],
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Choose Avatar',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: avatarList.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedAvatarIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAvatarIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.accentColor.withValues(alpha: .1)
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.accentColor
                                : Colors.transparent,
                            width: 1,
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
            Text('Your Name', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                prefixIcon:
                    Icon(Icons.person_outline, color: AppTheme.primaryLight),
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _isLoading ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : const Text('Save Changes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
