import 'package:flutter/material.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';
import 'package:nodos_chain_app/widgets/common/custom_bottom_nav_bar.dart';

/// Alışkanlıklar ve tüm zincirlerin yönetildiği modern liste ekranı.
class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Tümü (4)', 'Aktif (3)', 'Tamamlanan (1)'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Üst Başlık & Filtreler
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Zincirlerim',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurfaceSecondary
                                : AppColors.lightNavPill,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.link_rounded,
                                size: 16,
                                color: AppColors.accent,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '3 Aktif',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Devam eden zincirlerini incele ve ilerlemeni takip et.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Filtreleme Sekmeleri
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(_filters.length, (index) {
                          final isSelected = _selectedFilter == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFilter = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.nodosDark
                                    : (isDark
                                          ? AppColors.darkSurface
                                          : Colors.white),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.nodosDark
                                      : (isDark
                                            ? AppColors.darkBorder
                                            : AppColors.lightBorder),
                                ),
                                boxShadow: [
                                  if (isSelected)
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                ],
                              ),
                              child: Text(
                                _filters[index],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Alışkanlık İlerleme Kartları
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _habitProgressCard(
                    context: context,
                    title: 'Sabah Yürüyüşü',
                    category: 'Sağlık & Zindelik',
                    streak: 12,
                    goalDays: 30,
                    icon: Icons.directions_walk_rounded,
                    color: const Color(0xFF1ABC9C),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                  _habitProgressCard(
                    context: context,
                    title: 'Su İçme (2.5L)',
                    category: 'Sağlıklı Yaşam',
                    streak: 7,
                    goalDays: 14,
                    icon: Icons.water_drop_rounded,
                    color: const Color(0xFF3498DB),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                  _habitProgressCard(
                    context: context,
                    title: 'Kitap Okuma (20 sf)',
                    category: 'Kişisel Gelişim',
                    streak: 3,
                    goalDays: 21,
                    icon: Icons.menu_book_rounded,
                    color: const Color(0xFFE67E22),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                  _habitProgressCard(
                    context: context,
                    title: 'Meditasyon & Nefes',
                    category: 'Zihinsel Sağlık',
                    streak: 14,
                    goalDays: 14,
                    icon: Icons.self_improvement_rounded,
                    color: const Color(0xFF9B59B6),
                    isDark: isDark,
                  ),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _habitProgressCard({
    required BuildContext context,
    required String title,
    required String category,
    required int streak,
    required int goalDays,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    final progress = (streak / goalDays).clamp(0.0, 1.0);
    final isGoalReached = streak >= goalDays;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isGoalReached
              ? AppColors.accent.withValues(alpha: 0.5)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: isGoalReached ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextMuted
                            : AppColors.lightTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isGoalReached
                      ? AppColors.accent.withValues(alpha: 0.15)
                      : (isDark
                            ? AppColors.darkSurfaceSecondary
                            : AppColors.lightNavPill),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isGoalReached
                          ? Icons.emoji_events_rounded
                          : Icons.local_fire_department_rounded,
                      size: 15,
                      color: isGoalReached
                          ? AppColors.accent
                          : const Color(0xFFFF6B4A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$streak gün',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: isGoalReached
                            ? AppColors.accent
                            : (isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Hedef İlerleme Çubuğu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hedef: $goalDays Günlük Zincir',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              Text(
                '%${(progress * 100).toInt()}',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.5,
              backgroundColor: isDark
                  ? AppColors.darkSurfaceSecondary
                  : AppColors.lightNavPill,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
