import 'package:flutter/material.dart';
import 'package:nodos_chain_app/core/theme/app_colors.dart';
import 'package:nodos_chain_app/widgets/common/custom_bottom_nav_bar.dart';
import 'package:nodos_chain_app/widgets/common/nodos_logo.dart';

/// Modern Ana Ekran: Günlük zincir takibi, haftalık takvim şeridi ve interaktif halkalar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Alışkanlık tamamlama durumları
  final Map<int, bool> _completedState = {0: true, 1: true, 2: false, 3: false};

  int _selectedDayIndex = 4; // Bugün (Cumartesi veya mevcut gün)

  final List<Map<String, String>> _weekDays = [
    {'day': 'Pzt', 'date': '2'},
    {'day': 'Sal', 'date': '3'},
    {'day': 'Çar', 'date': '4'},
    {'day': 'Per', 'date': '5'},
    {'day': 'Cum', 'date': '6'},
    {'day': 'Cmt', 'date': '7'},
    {'day': 'Paz', 'date': '8'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final completedCount = _completedState.values.where((v) => v).length;
    final totalCount = _completedState.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true, // Floating nav bar'ın arkasında içerik zarifçe aksın
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Üst Marka & Profil Barı
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.3 : 0.04,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: NodosLogo(
                        size: 26,
                        color: isDark ? Colors.white : AppColors.nodosDark,
                        chainColor: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'NODOS',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.2,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.lightTextPrimary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'ZİNCİR',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.accent,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Zinciri Kırma, Alışkanlığını Kazan',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Seri rozeti (Streak Flame)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            size: 17,
                            color: Color(0xFFFF6B4A),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '12 Gün',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Haftalık İnteraktif Zincir Takvimi Şeridi
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.25 : 0.03,
                        ),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: List.generate(_weekDays.length, (index) {
                      final item = _weekDays[index];
                      final isSelected = _selectedDayIndex == index;
                      final isPastCompleted = index < _selectedDayIndex;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDayIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.nodosDark
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item['day']!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white.withValues(alpha: 0.8)
                                        : (isDark
                                              ? AppColors.darkTextMuted
                                              : AppColors.lightTextMuted),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['date']!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected
                                        ? Colors.white
                                        : (isDark
                                              ? AppColors.darkTextPrimary
                                              : AppColors.lightTextPrimary),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // Zincir halkası noktası
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? AppColors.accent
                                        : (isPastCompleted
                                              ? AppColors.accent
                                              : (isDark
                                                    ? AppColors.darkBorder
                                                    : AppColors.lightBorder)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            // 3. Günlük İlerleme Hero Kartı (Bugünkü Zincir Durumu)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF1E2430), const Color(0xFF161A22)]
                          : [const Color(0xFF222834), const Color(0xFF181B23)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.link_rounded,
                            color: AppColors.accent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Bugünkü Zincir Durumu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$completedCount / $totalCount Tamamlandı',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // İlerleme Çubuğu
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              progress >= 1.0
                                  ? '🎉 Harika! Bugünkü zincirler korundu!'
                                  : 'Bugün ${totalCount - completedCount} halka daha ekle, zinciri kırma!',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '%${(progress * 100).toInt()}',
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. Bölüm Başlığı
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 4, 22, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alışkanlıklarım',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    Text(
                      'Tümünü Gör',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 5. İnteraktif Alışkanlık Kartları
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _chainHabitCard(
                    index: 0,
                    title: 'Sabah Yürüyüşü (30 dk)',
                    category: 'Sağlık',
                    icon: Icons.directions_walk_rounded,
                    streak: 12,
                    goal: '30 gün',
                    recentStreak: [true, true, true, true, true],
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _chainHabitCard(
                    index: 1,
                    title: 'Su İçme (2.5 Litre)',
                    category: 'Beslenme',
                    icon: Icons.water_drop_rounded,
                    streak: 7,
                    goal: '14 gün',
                    recentStreak: [true, true, true, true, true],
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _chainHabitCard(
                    index: 2,
                    title: 'Kitap Okuma (20 sf)',
                    category: 'Gelişim',
                    icon: Icons.menu_book_rounded,
                    streak: 3,
                    goal: '21 gün',
                    recentStreak: [true, true, false, true, false],
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _chainHabitCard(
                    index: 3,
                    title: 'Yazılım / Kodlama (1 Saat)',
                    category: 'Kariyer',
                    icon: Icons.code_rounded,
                    streak: 5,
                    goal: '30 gün',
                    recentStreak: [true, true, true, false, false],
                    isDark: isDark,
                  ),
                ]),
              ),
            ),

            // Alt boşluk (Floating bar için bol alan)
            const SliverToBoxAdapter(child: SizedBox(height: 130)),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  /// Modern Zincir Görselleştiricili Alışkanlık Kartı
  Widget _chainHabitCard({
    required int index,
    required String title,
    required String category,
    required IconData icon,
    required int streak,
    required String goal,
    required List<bool> recentStreak,
    required bool isDark,
  }) {
    final isDone = _completedState[index] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _completedState[index] = !isDone;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDone
                ? AppColors.accent.withValues(alpha: 0.55)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isDone ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDone
                  ? AppColors.accent.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // İkon Kutusu
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: isDone
                        ? AppColors.accent.withValues(alpha: 0.15)
                        : (isDark
                              ? AppColors.darkSurfaceSecondary
                              : AppColors.lightNavPill),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: isDone
                        ? AppColors.accent
                        : (isDark ? Colors.white : AppColors.nodosDark),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: isDone
                              ? (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary)
                              : (isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppColors.darkTextMuted
                                  : AppColors.lightTextMuted,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? AppColors.darkTextMuted
                                  : AppColors.lightTextMuted,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Hedef: $goal',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tamamlama onay butonu
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: isDone ? AppColors.accent : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDone
                          ? AppColors.accent
                          : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                      width: 1.8,
                    ),
                  ),
                  child: isDone
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 22,
                        )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Alt Zincir Görselleştiricisi (Son 5 Günün Zincir Halkaları)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceSecondary.withValues(alpha: 0.6)
                    : AppColors.lightSurfaceSecondary.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.link_rounded,
                    size: 15,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '${isDone ? streak + 1 : streak} Günlük Zincir',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Zincir Halkaları (5 node)
                  Row(
                    children: List.generate(5, (nodeIndex) {
                      final isLast = nodeIndex == 4;
                      final nodeFilled = isLast
                          ? isDone
                          : (recentStreak.length > nodeIndex
                                ? recentStreak[nodeIndex]
                                : false);

                      return Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: nodeFilled
                                  ? AppColors.accent
                                  : Colors.transparent,
                              border: Border.all(
                                color: nodeFilled
                                    ? AppColors.accent
                                    : (isDark
                                          ? AppColors.darkBorder
                                          : AppColors.lightBorder),
                                width: 1.5,
                              ),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 8,
                              height: 1.5,
                              color:
                                  (nodeFilled &&
                                      (recentStreak.length > nodeIndex + 1
                                          ? recentStreak[nodeIndex + 1]
                                          : false))
                                  ? AppColors.accent
                                  : (isDark
                                        ? AppColors.darkBorder
                                        : AppColors.lightBorder),
                            ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
