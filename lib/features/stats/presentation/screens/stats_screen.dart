import 'package:flutter/material.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';
import 'package:nodos_chain_app/widgets/common/custom_bottom_nav_bar.dart';

/// İstatistikler ve zincirlerin durumu ekranı.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(child: _StatsBody()),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zincir İstatistikleri',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Toplam 3 aktif zincrin var, en uzun olan 12 gün.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _statCard(
                context: context,
                title: 'Toplam Aktif Zincir',
                value: '3',
                subtitle: 'Devam eden alışkanlıklar',
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _statCard(
                context: context,
                title: 'En Uzun Zincir',
                value: '12 gün',
                subtitle: 'Sabah Yürüyüşü',
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _statCard(
                context: context,
                title: 'Başarı Oranı',
                value: '%78',
                subtitle: 'Tamamlanan görevler / toplam',
                isDark: isDark,
              ),
            ]),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  Widget _statCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required bool isDark,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.accent,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }
}
