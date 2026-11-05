import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodos_chain_app/core/providers/navigation_provider.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';

/// NODOS - Zinciri Kırma konseptine ve paylaşılan tasarım görseline (Model 1)
/// birebir uygun modern, minimalist ve ergonomik bottom navigation bar.
class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
            blurRadius: 18,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 74,
          child: Row(
            children: [
              // 1. Home (Takvim / Bugün)
              Expanded(
                child: _buildNavItem(
                  context: context,
                  ref: ref,
                  label: 'Home',
                  icon: Icons.calendar_today_outlined,
                  activeIcon: Icons.calendar_today_rounded,
                  route: '/',
                  isSelected: location == '/',
                  isDark: isDark,
                  index: 0,
                ),
              ),

              // 2. Habits (Alışkanlıklar Listesi)
              Expanded(
                child: _buildNavItem(
                  context: context,
                  ref: ref,
                  label: 'Habits',
                  icon: Icons.format_list_bulleted_rounded,
                  activeIcon: Icons.format_list_bulleted_rounded,
                  route: '/habits',
                  isSelected: location == '/habits',
                  isDark: isDark,
                  index: 1,
                ),
              ),

              // 3. New Habit (Merkezi Koyu Dairesel ND Butonu)
              Expanded(
                child: _buildCenterButton(
                  context: context,
                  isSelected: location == '/add-habit',
                  isDark: isDark,
                ),
              ),

              // 4. Reports (İstatistikler / Raporlar)
              Expanded(
                child: _buildNavItem(
                  context: context,
                  ref: ref,
                  label: 'Reports',
                  icon: Icons.bar_chart_rounded,
                  activeIcon: Icons.bar_chart_rounded,
                  route: '/stats',
                  isSelected: location == '/stats',
                  isDark: isDark,
                  index: 2,
                ),
              ),

              // 5. Settings (Ayarlar / Profil)
              Expanded(
                child: _buildNavItem(
                  context: context,
                  ref: ref,
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings_rounded,
                  route: '/profile',
                  isSelected: location == '/profile',
                  isDark: isDark,
                  index: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Görseldeki gibi aktifken yumuşak hap (pill) arka planı olan sekme butonu
  Widget _buildNavItem({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required IconData icon,
    required IconData activeIcon,
    required String route,
    required bool isSelected,
    required bool isDark,
    required int index,
  }) {
    final activeTextColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final inactiveTextColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return GestureDetector(
      onTap: () {
        ref.read(bottomNavIndexProvider.notifier).state = index;
        context.go(route);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // İkon ve Aktif Pill Arka Planı
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark ? AppColors.darkNavPill : AppColors.lightNavPill)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              size: 22,
              color: isSelected ? activeTextColor : inactiveTextColor,
            ),
          ),
          const SizedBox(height: 3),
          // Sekme Metni
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? activeTextColor : inactiveTextColor,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  /// Görseldeki merkezi yükseltilmiş, dairesel koyu renkli NODOS "ND" Butonu
  Widget _buildCenterButton({
    required BuildContext context,
    required bool isSelected,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        context.go('/add-habit');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, -6), // Görseldeki gibi hafifçe yukarı taşma
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.nodosDark,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.accent
                      : (isDark ? AppColors.darkBorder : Colors.white),
                  width: isSelected ? 2.5 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.nodosDark.withValues(
                      alpha: isSelected ? 0.45 : 0.25,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: _NodosMonogramIcon(
                  isSelected: isSelected,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -4),
            child: Text(
              'New Habit',
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? AppColors.accent
                    : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Görseldeki merkezi "ND" zincir monogramını temsil eden logo bileşeni.
class _NodosMonogramIcon extends StatelessWidget {
  const _NodosMonogramIcon({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/images/nodos_app_logo.jpg',
        width: 32,
        height: 32,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Vektörel yedek ikon: Zincir bağlantısı (Link)
          return const Icon(
            Icons.link_rounded,
            color: Colors.white,
            size: 24,
          );
        },
      ),
    );
  }
}
