import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class TenantSelectionPage extends StatefulWidget {
  final CacheRepository cacheRepository;

  const TenantSelectionPage({
    super.key,
    required this.cacheRepository,
  });

  @override
  State<TenantSelectionPage> createState() => _TenantSelectionPageState();
}

final class _TenantSelectionPageState extends State<TenantSelectionPage> {
  final TextEditingController _searchController = TextEditingController();

  static const List<_TenantItem> _tenants = [
    _TenantItem(
      id: '1',
      name: 'Mr. Ahmed Physics',
      tagline: 'Physics made simple',
      studentsCount: '1.2K students',
      logoEmoji: 'PH',
      isVerified: true,
      primaryColorHex: '#183764',
      accentColorHex: '#F59239',
    ),
    _TenantItem(
      id: '2',
      name: 'Ms. Sara Math',
      tagline: 'Math with confidence',
      studentsCount: '980 students',
      logoEmoji: 'MA',
      isVerified: true,
      primaryColorHex: '#0F4C5C',
      accentColorHex: '#E36414',
    ),
    _TenantItem(
      id: '3',
      name: 'Dr. Youssef Chemistry',
      tagline: 'Chemistry explained clearly',
      studentsCount: '730 students',
      logoEmoji: 'CH',
      isVerified: false,
      primaryColorHex: '#1E5128',
      accentColorHex: '#D8E9A8',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSelectTenant(_TenantItem tenant) async {
    await widget.cacheRepository.put(CacheKeys.tenantId, tenant.id);
    await widget.cacheRepository.put(CacheKeys.tenantName, tenant.name);
    await widget.cacheRepository.put(CacheKeys.tenantLogoUrl, tenant.logoEmoji);
    await widget.cacheRepository.put(
      CacheKeys.tenantPrimaryColor,
      tenant.primaryColorHex,
    );
    await widget.cacheRepository.put(
      CacheKeys.tenantAccentColor,
      tenant.accentColorHex,
    );

    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _tenants.where((tenant) {
      if (query.isEmpty) return true;
      return tenant.name.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Teacher'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search by teacher name...',
                  filled: true,
                  fillColor: palette.backgroundSecondary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: palette.brandPrimary, width: 1.5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No teachers found. Try a different name.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: palette.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, index) =>
                        const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final tenant = filtered[index];
                        return GradientCard(
                          colors: [
                            palette.backgroundSecondary,
                            palette.backgroundSecondary.withValues(alpha: 0.9),
                          ],
                          padding: EdgeInsets.zero,
                          borderRadius: 20,
                          onTap: () => _onSelectTenant(tenant),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        palette.brandPrimary.withValues(alpha: 0.2),
                                        palette.brandPrimary.withValues(alpha: 0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: palette.brandPrimary.withValues(alpha: 0.1),
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    tenant.logoEmoji,
                                    style: TextStyle(
                                      color: palette.brandPrimary,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              tenant.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: palette.textPrimary,
                                                  ),
                                            ),
                                          ),
                                          if (tenant.isVerified)
                                            Container(
                                              margin: const EdgeInsets.only(left: 4),
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: palette.brandPrimary.withValues(alpha: 0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.verified,
                                                color: palette.brandPrimary,
                                                size: 14,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        tenant.tagline,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: palette.textSecondary,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: palette.brandPrimary.withValues(alpha: 0.08),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          tenant.studentsCount,
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: palette.brandPrimary,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: palette.textSecondary.withValues(alpha: 0.5),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Support flow will be connected next.'),
                    ),
                  );
                },
                child: const Text("Can't find your teacher?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _TenantItem {
  final String id;
  final String name;
  final String tagline;
  final String studentsCount;
  final String logoEmoji;
  final bool isVerified;
  final String primaryColorHex;
  final String accentColorHex;

  const _TenantItem({
    required this.id,
    required this.name,
    required this.tagline,
    required this.studentsCount,
    required this.logoEmoji,
    required this.isVerified,
    required this.primaryColorHex,
    required this.accentColorHex,
  });
}
