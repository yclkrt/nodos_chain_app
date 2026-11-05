import 'package:flutter/material.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';
import 'package:nodos_chain_app/widgets/common/custom_bottom_nav_bar.dart';

/// Profil ve ayarlar ekranı.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(child: _ProfileBody()),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.accent.withValues(alpha: 0.15),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 44,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kullanıcı',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'nodos_chain_app',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: 32),
                _menuItem(
                  context: context,
                  icon: Icons.notifications_rounded,
                  label: 'Bildirimler',
                  isDark: isDark,
                ),
                _menuItem(
                  context: context,
                  icon: Icons.dark_mode_rounded,
                  label: 'Koyu Tema',
                  isDark: isDark,
                ),
                _menuItem(
                  context: context,
                  icon: Icons.info_rounded,
                  label: 'Hakkında',
                  isDark: isDark,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
            size: 22,
          ),
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.lightTextSecondary,
          size: 22,
        ),
      ),
    );
  }
}
