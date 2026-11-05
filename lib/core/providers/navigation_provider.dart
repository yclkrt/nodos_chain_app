import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Uygulama genelinde seçili bottom nav sekmesini tutar.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// Bottom nav sekme sabitleri (Görseldeki 5 slotlu modele uygun).
enum BottomNavSection { home, habits, add, reports, settings }

/// Her sekme için başlık, ikon ve rota tanımları.
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

  /// Görseldeki Model 1'e uygun 4 standart sekme (Merkezi buton ayrıca render edilir)
  static const List<BottomNavItemData> items = [
    BottomNavItemData(
      label: 'Home',
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today_rounded,
      section: BottomNavSection.home,
      route: '/',
    ),
    BottomNavItemData(
      label: 'Habits',
      icon: Icons.format_list_bulleted_rounded,
      activeIcon: Icons.format_list_bulleted_rounded,
      section: BottomNavSection.habits,
      route: '/habits',
    ),
    BottomNavItemData(
      label: 'Reports',
      icon: Icons.bar_chart_rounded,
      activeIcon: Icons.bar_chart_rounded,
      section: BottomNavSection.reports,
      route: '/stats',
    ),
    BottomNavItemData(
      label: 'Settings',
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      section: BottomNavSection.settings,
      route: '/profile',
    ),
  ];
}
