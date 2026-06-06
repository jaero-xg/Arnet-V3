// lib/services/version_checker.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

/// Holds data fetched from your remote version manifest.
class VersionInfo {
  final String latestVersion;
  final String downloadUrl;
  final String releaseNotes;

  const VersionInfo({
    required this.latestVersion,
    required this.downloadUrl,
    required this.releaseNotes,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
        latestVersion: json['latest_version'] as String,
        downloadUrl: json['download_url'] as String,
        releaseNotes: json['release_notes'] as String? ?? '',
      );
}

class VersionChecker {
  // ─── Replace with your hosted JSON URL ───────────────────────────────────
  // Example hosted on GitHub Pages or Firebase Hosting:
  // https://yourusername.github.io/arnet/version.json
  //
  // The JSON file should look like:
  // {
  //   "latest_version": "1.1.0",
  //   "download_url": "https://yoursite.com/download",
  //   "release_notes": "Bug fixes and performance improvements."
  // }
  static const String _versionManifestUrl =
      'https://raw.githubusercontent.com/jaero-xg/Arnet-V3/main/version.json';

  /// Fetches the current installed version via package_info_plus.
  static Future<String> getCurrentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version; // e.g. "1.0.0"
  }

  /// Fetches the remote version manifest. Throws on network or parse error.
  static Future<VersionInfo> fetchLatestVersion() async {
    final response = await http
        .get(Uri.parse(_versionManifestUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Server returned ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return VersionInfo.fromJson(json);
  }

  /// Returns true if [latest] is strictly newer than [current].
  /// Compares semantic version strings, e.g. "1.2.0" vs "1.0.0".
  static bool isNewer(String latest, String current) {
    List<int> parse(String v) =>
        v.split('.').map((s) => int.tryParse(s) ?? 0).toList();

    final l = parse(latest);
    final c = parse(current);

    for (int i = 0; i < l.length; i++) {
      final li = i < l.length ? l[i] : 0;
      final ci = i < c.length ? c[i] : 0;
      if (li > ci) return true;
      if (li < ci) return false;
    }
    return false;
  }

  /// Convenience method: checks both the current and latest version, then
  /// returns a [UpdateCheckResult] with all the info your UI needs.
  static Future<UpdateCheckResult> checkForUpdate() async {
    final current = await getCurrentVersion();
    final info = await fetchLatestVersion();
    return UpdateCheckResult(
      currentVersion: current,
      latestVersion: info.latestVersion,
      downloadUrl: info.downloadUrl,
      releaseNotes: info.releaseNotes,
      updateAvailable: isNewer(info.latestVersion, current),
    );
  }
}

class UpdateCheckResult {
  final String currentVersion;
  final String latestVersion;
  final String downloadUrl;
  final String releaseNotes;
  final bool updateAvailable;

  const UpdateCheckResult({
    required this.currentVersion,
    required this.latestVersion,
    required this.downloadUrl,
    required this.releaseNotes,
    required this.updateAvailable,
  });
}
