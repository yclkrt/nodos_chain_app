import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodos_chain_app/core/providers/navigation_provider.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';

/// Ultra modern, şık ve minimal bottom navigation bar.
/// Seçili sekme için "kapsül" (pill) arka plan efekti kullanılmıştır.
/// "Ekle" butonu burada yok; istediğiniz sayfada ayrı bir FAB olarak
/// konumlandırabilirsiniz.
class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 85,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.92)
            : AppColors.lightSurface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.10),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              ref: ref,
              item: BottomNavItemData.items[0],
              index: 0,
              isSelected: location == '/',
              isDark: isDark,
            ),
            _buildNavItem(
              context: context,
              ref: ref,
              item: BottomNavItemData.items[1],
              index: 1,
              isSelected: location == '/stats',
              isDark: isDark,
            ),
            _buildNavItem(
              context: context,
              ref: ref,
              item: BottomNavItemData.items[2],
              index: 2,
              isSelected: location == '/profile',
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required WidgetRef ref,
    required BottomNavItemData item,
    required int index,
    required bool isSelected,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(bottomNavIndexProvider.notifier).state = index;
          context.go(item.route);
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? item.activeIcon : item.icon,
                size: 24,
                color: isSelected ? Colors.white : _inactiveColor(isDark),
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : _inactiveColor(isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _inactiveColor(bool isDark) {
    return isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  }
}
