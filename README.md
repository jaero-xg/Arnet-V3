# EduAR — Offline AR eLearning Flutter App

## File Structure

```
ar_elearning/
├── pubspec.yaml
├── README.md
└── lib/
    ├── main.dart                          # App entry point + routing
    │
    ├── theme/
    │   └── app_theme.dart                 # Material 3 theme, colors, avatar list
    │
    ├── models/
    │   └── app_models.dart                # Data models: LearnerProfile, LearningModule,
    │                                      #   Lesson, QuizQuestion, Model3D, etc.
    │
    ├── data/
    │   └── sample_data.dart               # Pre-built sample modules, lessons, quizzes,
    │                                      #   3D models (Human Anatomy, Physics, Cell Biology)
    │
    ├── state/
    │   └── app_state.dart                 # ChangeNotifier: profile CRUD, progress tracking,
    │                                      #   quiz recording, AR session counter
    │
    └── screens/
        ├── create_profile_screen.dart     # Screen 1: Avatar grid + name input → create profile
        ├── main_shell.dart                # Bottom NavigationBar shell (Home / AR / Profile)
        ├── home_screen.dart               # TabBar: Modules list + 3D Models grid
        ├── module_details_screen.dart     # Module header, progress bar, lesson list
        ├── lesson_reader_screen.dart      # Scrollable lesson content + "Take Quiz" button
        ├── quiz_screen.dart               # Quiz: progress bar, question card, answer options
        ├── quiz_result_screen.dart        # Score circle, stats, Retry / Return actions
        ├── model_details_screen.dart      # 3D model info, AR launch button
        ├── ar_screen.dart                 # AR placeholder, "Launch AR Session" button
        ├── profile_screen.dart            # Progress cards, recent activity, achievements
        └── edit_profile_screen.dart       # Edit name + avatar
```

## Navigation Flow

```
App Launch
├── No profile → CreateProfileScreen
│                      ↓
└── Has profile → MainShell (BottomNav)
                  ├── [0] HomeScreen
                  │     ├── Modules Tab
                  │     │   └── ModuleCard → ModuleDetailsScreen
                  │     │                       └── LessonCard → LessonReaderScreen
                  │     │                                             └── QuizScreen
                  │     │                                                     └── QuizResultScreen
                  │     └── 3D Models Tab
                  │         └── ModelCard → ModelDetailsScreen
                  ├── [1] ARScreen
                  └── [2] ProfileScreen
                              └── EditProfileScreen
```

## Setup

### 1. Add Provider dependency

The app uses `provider` for state management. Add it to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  shared_preferences: ^2.2.2
  intl: ^0.19.0
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

## Key Design Decisions

| Decision | Choice | Reason |
|----------|--------|--------|
| State management | `provider` + `ChangeNotifier` | Lightweight, Flutter-native |
| Persistence | `shared_preferences` | Offline-first, no server |
| Theme | Material 3, blue-grey palette | Academic, professional look |
| Navigation | `NavigationBar` + `IndexedStack` | Preserves tab state |
| Data | In-memory + prefs serialization | Offline, no DB needed |

## AR Integration Notes

The AR screen and "Start AR Experience" buttons are intentionally minimal stubs.
To integrate Unity AR:
- Use the `flutter_unity_widget` package
- Replace the placeholder container in `ar_screen.dart` with `UnityWidget`
- Pass model IDs from `ModelDetailsScreen` to Unity via message channels

## Screens Summary

| Screen | File | Key Widgets |
|--------|------|-------------|
| Create Profile | `create_profile_screen.dart` | `GridView`, `TextField`, `ElevatedButton` |
| Home | `home_screen.dart` | `TabBar`, `ListView`, `GridView` |
| Module Details | `module_details_screen.dart` | `LinearProgressIndicator`, `ListView` |
| Lesson Reader | `lesson_reader_screen.dart` | `SingleChildScrollView`, sticky button |
| Quiz | `quiz_screen.dart` | `LinearProgressIndicator`, custom answer cards |
| Quiz Result | `quiz_result_screen.dart` | `CustomPainter` circle, stat cards |
| Model Details | `model_details_screen.dart` | Info rows, `ElevatedButton` |
| AR | `ar_screen.dart` | Placeholder container, Unity stub |
| Profile | `profile_screen.dart` | `GridView` cards, `ListView`, badges |
| Edit Profile | `edit_profile_screen.dart` | `GridView` avatar, `TextField` |
