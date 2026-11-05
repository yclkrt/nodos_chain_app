import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodos_chain_app/core/providers/navigation_provider.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';

/// Modern, şık ve glassmorphism tabanlı bottom navigation bar.
/// Alışkanlık takibi (zinciri kırma) konseptine uygun olarak tasarlanmıştır.
class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.92)
            : AppColors.lightSurface.withValues(alpha: 0.92),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
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
              _buildAddButton(
                context: context,
                isSelected: location == '/add-habit',
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
    return GestureDetector(
      onTap: () {
        ref.read(bottomNavIndexProvider.notifier).state = index;
        context.go(item.route);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? AppColors.accent.withValues(alpha: 0.18)
                  : AppColors.accent.withValues(alpha: 0.12))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              size: 24,
              color: isSelected
                  ? AppColors.accent
                  : (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.accent
                    : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton({
    required BuildContext context,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        context.go('/add-habit');
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticOut,
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.accent,
              AppColors.accentLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: isSelected ? 0.6 : 0.4),
              blurRadius: isSelected ? 20 : 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
