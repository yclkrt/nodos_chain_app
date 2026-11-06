import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodos_chain_app/core/providers/navigation_provider.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';
import 'package:nodos_chain_app/widgets/common/nodos_logo.dart';

/// NODOS - Zinciri Kırma için ultra-modern, yüzen (floating island / capsule dock)
/// glassmorphism tabanlı bottom navigation bar.
class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withValues(alpha: 0.88)
                    : Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(34),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.09)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDark ? 0.40 : 0.08,
                    ),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 1. Home
                  Expanded(
                    child: _BottomNavTab(
                      label: 'Home',
                      icon: Icons.calendar_today_outlined,
                      activeIcon: Icons.calendar_today_rounded,
                      route: '/',
                      isSelected: location == '/',
                      isDark: isDark,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 0;
                        context.go('/');
                      },
                    ),
                  ),

                  // 2. Habits
                  Expanded(
                    child: _BottomNavTab(
                      label: 'Habits',
                      icon: Icons.format_list_bulleted_rounded,
                      activeIcon: Icons.format_list_bulleted_rounded,
                      route: '/habits',
                      isSelected: location == '/habits',
                      isDark: isDark,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 1;
                        context.go('/habits');
                      },
                    ),
                  ),

                  // 3. New Habit (Merkezi Koyu ND Butonu)
                  Expanded(
                    child: _CenterActionTab(
                      isSelected: location == '/add-habit',
                      isDark: isDark,
                      onTap: () => context.go('/add-habit'),
                    ),
                  ),

                  // 4. Reports
                  Expanded(
                    child: _BottomNavTab(
                      label: 'Reports',
                      icon: Icons.bar_chart_rounded,
                      activeIcon: Icons.bar_chart_rounded,
                      route: '/stats',
                      isSelected: location == '/stats',
                      isDark: isDark,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 2;
                        context.go('/stats');
                      },
                    ),
                  ),

                  // 5. Settings
                  Expanded(
                    child: _BottomNavTab(
                      label: 'Settings',
                      icon: Icons.tune_rounded,
                      activeIcon: Icons.tune_rounded,
                      route: '/profile',
                      isSelected: location == '/profile',
                      isDark: isDark,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 3;
                        context.go('/profile');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Standart gezinme sekmesi (Modern pill vurgulu & mikro animasyonlu)
class _BottomNavTab extends StatefulWidget {
  const _BottomNavTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_BottomNavTab> createState() => _BottomNavTabState();
}

class _BottomNavTabState extends State<_BottomNavTab> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final activeTextColor = widget.isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final inactiveTextColor = widget.isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Yumuşak hap (pill) şeklindeki aktif ikon kutucuğu
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? (widget.isDark
                        ? AppColors.darkNavPill
                        : AppColors.lightNavPill)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.isSelected ? widget.activeIcon : widget.icon,
                size: 21,
                color: widget.isSelected ? activeTextColor : inactiveTextColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight:
                    widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                color: widget.isSelected ? activeTextColor : inactiveTextColor,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Merkezi, dairesel ve gölgeli NODOS "ND" Ekleme Butonu
class _CenterActionTab extends StatefulWidget {
  const _CenterActionTab({
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_CenterActionTab> createState() => _CenterActionTabState();
}

class _CenterActionTabState extends State<_CenterActionTab> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.88 : (widget.isSelected ? 1.05 : 1.0),
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutBack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dairesel Koyu Buton
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2C323E),
                    Color(0xFF1A1D24),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: widget.isSelected
                      ? AppColors.accent
                      : (widget.isDark
                          ? Colors.white.withValues(alpha: 0.15)
                          : Colors.white),
                  width: widget.isSelected ? 2 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected
                        ? AppColors.accent.withValues(alpha: 0.45)
                        : Colors.black.withValues(alpha: 0.35),
                    blurRadius: widget.isSelected ? 14 : 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: NodosLogo(
                  size: 22,
                  color: Colors.white,
                  chainColor: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'New Habit',
              style: TextStyle(
                fontSize: 9.5,
                fontWeight:
                    widget.isSelected ? FontWeight.w700 : FontWeight.w600,
                color: widget.isSelected
                    ? AppColors.accent
                    : (widget.isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
