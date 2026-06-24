// lib/data/model_assets.dart
//
// Single source of truth for "which file in assets/images/models/ goes with
// which Model3D". Model3D.id values (mdl_modem, mdl_networkSwitch, ...) don't
// match the actual filenames on disk (modem.png, switch.png, ...), so this
// map bridges the two. Anything not listed here has no photo yet — the
// returned path will simply fail to load, and the screens fall back to the
// matching NetworkSvgs outline icon automatically.

class ModelAssets {
  static const Map<String, String> _fileById = {
    'mdl_modem': 'modem',
    'mdl_networkSwitch': 'switch',
    'mdl_hub': 'hub',
    'mdl_repeater': 'ext',
    'mdl_rj45': 'rj45',
    'mdl_opticalFiber': 'fiberoptic',
    'mdl_smartphone': 'smartphone',
    'mdl_serverRack': 'serverRack',
    'mdl_laptop': 'laptop',
    'mdl_desktop': 'desktop',
    'mdl_router': 'router',
    // 'mdl_coaxialCable' and 'mdl_access_point' have no asset yet.
  };

  /// Returns the asset path to try loading for [modelId]. If there's no
  /// mapped file, returns a guaranteed-missing path so Image.asset's
  /// errorBuilder fires and the SVG/icon fallback is shown instead.
  static String pathFor(String modelId) {
    final file = _fileById[modelId];
    if (file == null) {
      return 'assets/images/models/__no_asset__.png';
    }
    return 'assets/images/models/$file.png';
  }
}
