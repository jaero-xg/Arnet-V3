class NetworkSvgs {
  // ── Existing icons (upgraded to outline-only) ─────────────────────────────

  static const String modem = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="12" y="30" width="40" height="18" rx="4" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <circle cx="22" cy="39" r="2.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="32" cy="39" r="2.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="42" cy="39" r="2.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <path d="M18 26 Q32 12 46 26" stroke="#4a90e2" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M23 30 Q32 20 41 30" stroke="#4a90e2" stroke-width="2" fill="none" stroke-linecap="round"/>
</svg>
''';

  static const String networkSwitch = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="10" y="22" width="44" height="20" rx="4" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <rect x="16" y="29" width="4" height="6" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <rect x="24" y="29" width="4" height="6" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <rect x="32" y="29" width="4" height="6" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <rect x="40" y="29" width="4" height="6" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <polyline points="22,14 32,22 42,14" fill="none" stroke="#4a90e2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

  static const String hub = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <circle cx="32" cy="32" r="10" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <line x1="32" y1="10" x2="32" y2="22" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="32" y1="42" x2="32" y2="54" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="10" y1="32" x2="22" y2="32" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="42" y1="32" x2="54" y2="32" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="17" y1="17" x2="25" y2="25" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="39" y1="39" x2="47" y2="47" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="47" y1="17" x2="39" y2="25" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="25" y1="39" x2="17" y2="47" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
</svg>
''';

  static const String repeater = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="22" y="24" width="20" height="16" rx="3" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <line x1="10" y1="32" x2="22" y2="32" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="42" y1="32" x2="54" y2="32" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <path d="M16 22 Q32 8 48 22" stroke="#4a90e2" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M20 18 Q32 4 44 18" stroke="#4a90e2" stroke-width="1.5" fill="none" stroke-linecap="round"/>
  <circle cx="32" cy="32" r="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
</svg>
''';

  static const String rj45 = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <path d="M22 12 H42 V28 L36 36 H28 L22 28 Z" fill="none" stroke="#4a90e2" stroke-width="2" stroke-linejoin="round"/>
  <line x1="26" y1="16" x2="26" y2="24" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="30" y1="16" x2="30" y2="24" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="34" y1="16" x2="34" y2="24" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="38" y1="16" x2="38" y2="24" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <rect x="28" y="36" width="8" height="14" rx="1" fill="none" stroke="#4a90e2" stroke-width="2"/>
</svg>
''';

  // ── New icons ─────────────────────────────────────────────────────────────

  static const String coaxialCable = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <line x1="8" y1="32" x2="22" y2="32" stroke="#4a90e2" stroke-width="3" stroke-linecap="round"/>
  <line x1="42" y1="32" x2="56" y2="32" stroke="#4a90e2" stroke-width="3" stroke-linecap="round"/>
  <circle cx="32" cy="32" r="14" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <circle cx="32" cy="32" r="8" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <circle cx="32" cy="32" r="3" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <line x1="22" y1="32" x2="29" y2="32" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="35" y1="32" x2="42" y2="32" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
</svg>
''';

  static const String opticalFiber = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <path d="M8 20 C20 20 20 44 32 44 C44 44 44 20 56 20" fill="none" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <path d="M8 28 C20 28 20 36 32 36 C44 36 44 28 56 28" fill="none" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round" stroke-dasharray="4 2"/>
  <path d="M8 32 L18 32" fill="none" stroke="#4a90e2" stroke-width="2.5" stroke-linecap="round"/>
  <path d="M46 32 L56 32" fill="none" stroke="#4a90e2" stroke-width="2.5" stroke-linecap="round"/>
  <rect x="14" y="26" width="8" height="12" rx="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <rect x="42" y="26" width="8" height="12" rx="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
</svg>
''';

  static const String smartphone = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="18" y="8" width="28" height="48" rx="5" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <line x1="18" y1="16" x2="46" y2="16" stroke="#4a90e2" stroke-width="1.5"/>
  <line x1="18" y1="48" x2="46" y2="48" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="32" cy="53" r="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <line x1="28" y1="12" x2="36" y2="12" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <rect x="22" y="20" width="20" height="24" rx="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
</svg>
''';

  static const String serverRack = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="14" y="8" width="36" height="48" rx="3" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <rect x="18" y="14" width="28" height="7" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <rect x="18" y="25" width="28" height="7" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <rect x="18" y="36" width="28" height="7" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="40" cy="17.5" r="1.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="40" cy="28.5" r="1.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="40" cy="39.5" r="1.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <line x1="20" y1="17.5" x2="34" y2="17.5" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="20" y1="28.5" x2="34" y2="28.5" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="20" y1="39.5" x2="34" y2="39.5" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="20" y1="48" x2="44" y2="48" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="20" y1="51" x2="44" y2="51" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
</svg>
''';

  static const String laptop = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="12" y="14" width="40" height="28" rx="3" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <rect x="16" y="18" width="32" height="20" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <path d="M8 42 H56 L54 50 H10 Z" fill="none" stroke="#4a90e2" stroke-width="2" stroke-linejoin="round"/>
  <line x1="26" y1="46" x2="38" y2="46" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
</svg>
''';

  static const String desktop = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="8" y="10" width="48" height="32" rx="3" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <rect x="12" y="14" width="40" height="24" rx="1" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <line x1="32" y1="42" x2="32" y2="50" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="22" y1="50" x2="42" y2="50" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <circle cx="32" cy="38" r="1.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
</svg>
''';

  static const String router = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="10" y="28" width="44" height="16" rx="4" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <line x1="20" y1="28" x2="20" y2="16" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="32" y1="28" x2="32" y2="10" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <line x1="44" y1="28" x2="44" y2="16" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <circle cx="22" cy="37" r="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="30" cy="37" r="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="38" cy="37" r="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <line x1="46" y1="34" x2="50" y2="34" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
  <line x1="46" y1="38" x2="50" y2="38" stroke="#4a90e2" stroke-width="1.5" stroke-linecap="round"/>
</svg>
''';

  static const String wirelessAccessPoint = '''
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect x="18" y="40" width="28" height="10" rx="3" fill="none" stroke="#4a90e2" stroke-width="2"/>
  <line x1="32" y1="40" x2="32" y2="36" stroke="#4a90e2" stroke-width="2" stroke-linecap="round"/>
  <path d="M14 32 Q32 18 50 32" stroke="#4a90e2" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M20 26 Q32 16 44 26" stroke="#4a90e2" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M26 20 Q32 14 38 20" stroke="#4a90e2" stroke-width="2" fill="none" stroke-linecap="round"/>
  <circle cx="32" cy="36" r="2" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="26" cy="45" r="1.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
  <circle cx="38" cy="45" r="1.5" fill="none" stroke="#4a90e2" stroke-width="1.5"/>
</svg>
''';
}
