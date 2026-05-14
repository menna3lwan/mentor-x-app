part of '../mentorx_ui.dart';

class AppHeroCard extends StatelessWidget {
  const AppHeroCard({
    super.key,
    required this.title,
    required this.icon,
    required this.stats,
    this.colors,
  });

  final String title;
  final IconData icon;
  final List<AppHeroStatItem> stats;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      colors: colors ?? [
        context.brandPrimaryColor,
        context.brandPrimaryColor.withValues(alpha: 0.85),
      ],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.bodyPrimaryStyle.copyWith(
                      color: context.backgroundSecondaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: -0.4,
                    ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon, 
                  color: context.backgroundSecondaryColor, 
                  size: 20
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats.map((stat) => _StatItem(stat: stat)).toList(),
          ),
        ],
      ),
    );
  }
}

class AppHeroStatItem {
  final String label;
  final String value;
  final VoidCallback onTap;

  const AppHeroStatItem({
    required this.label,
    required this.value,
    required this.onTap,
  });
}

class _StatItem extends StatelessWidget {
  final AppHeroStatItem stat;

  const _StatItem({required this.stat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: stat.onTap,
      child: Column(
        children: [
          Text(
            stat.value,
            style: context.titleH2Style.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.backgroundSecondaryColor,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: context.smallTextStyle.copyWith(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.7),
                ),
          ),
        ],
      ),
    );
  }
}
