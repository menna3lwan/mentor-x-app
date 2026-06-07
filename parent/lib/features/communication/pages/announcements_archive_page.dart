import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/communication_bloc.dart';
import 'package:intl/intl.dart';

final class AnnouncementsArchivePage extends StatelessWidget {
  final CommunicationStatus status;
  final String? errorMessage;
  final List<AnnouncementEntity> announcements;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;

  const AnnouncementsArchivePage({
    super.key,
    required this.status,
    required this.errorMessage,
    required this.announcements,
    required this.onRefresh,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          _buildContent(context, t),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic t) {
    if (status == CommunicationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == CommunicationStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? t.unableToLoad,
        onRetry: onRetry,
      );
    }

    return RefreshIndicator(
      displacement: MediaQuery.paddingOf(context).top + 80,
      color: context.brandPrimaryColor,
      onRefresh: () async => onRefresh(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(MediaQuery.paddingOf(context).top + 12),
                  _buildHeader(context, t),
                  const Gap(32),

                  if (announcements.isEmpty)
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: AppEmptyView(
                        title: 'No Announcements',
                        message: 'Stay tuned! School announcements will appear here.',
                        icon: Icons.campaign_rounded,
                        onAction: onRefresh,
                        actionLabel: 'Refresh',
                      ),
                    )
                  else
                    ...announcements.asMap().entries.map(
                      (entry) => _AnnouncementCard(announcement: entry.value, index: entry.key),
                    ),

                  const Gap(100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            style: IconButton.styleFrom(
              backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              t.announcements,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;
  final int index;

  const _AnnouncementCard({required this.announcement, required this.index});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(announcement.createdAt);

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: context.borderPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: InkWell(
          onTap: () {
            // Navigate to details
          },
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.campaign_rounded, color: context.brandPrimaryColor, size: 22),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Text(
                        announcement.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Text(
                  announcement.preview ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: context.textTertiaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Read More',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: context.brandPrimaryColor,
                          ),
                        ),
                        const Gap(4),
                        Icon(Icons.arrow_forward_rounded, color: context.brandPrimaryColor, size: 14),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          left: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 350,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
