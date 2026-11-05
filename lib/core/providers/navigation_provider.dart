import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Uygulama genelinde seçili bottom nav sekmesini tutar.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// Bottom nav sekme sabitleri.
enum BottomNavSection { home, stats, profile }

/// Her sekme için başlık ve ikon tanımları.
class BottomNavItemData {
  const BottomNavItemData({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.section,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final BottomNavSection section;
  final String route;

  static const List<BottomNavItemData> items = [
    BottomNavItemData(
      label: 'Ana Sayfa',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      section: BottomNavSection.home,
      route: '/',
    ),
    BottomNavItemData(
      label: 'Zincirler',
      icon: Icons.track_changes_outlined,
      activeIcon: Icons.track_changes_rounded,
      section: BottomNavSection.stats,
      route: '/stats',
    ),
    BottomNavItemData(
      label: 'Profil',
      icon: Icons.person_outline,
      activeIcon: Icons.person_rounded,
      section: BottomNavSection.profile,
      route: '/profile',
    ),
  ];
}
