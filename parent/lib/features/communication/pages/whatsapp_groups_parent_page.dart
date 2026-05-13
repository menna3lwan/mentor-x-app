import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:parent/core/core.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/communication_bloc.dart';

class WhatsAppGroupsParentPage extends StatelessWidget {
  final String childId;

  const WhatsAppGroupsParentPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc(
        analyticsService: context.read<AnalyticsService>(),
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Stack(
          children: [
            const _BackgroundDecorations(),
            _WhatsAppGroupsBody(childId: childId),
          ],
        ),
      ),
    );
  }
}

class _WhatsAppGroupsBody extends StatelessWidget {
  const _WhatsAppGroupsBody({required this.childId});

  final String childId;

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (CommunicationBloc bloc) => bloc.state.status,
    );
    final errorMessage = context.select(
      (CommunicationBloc bloc) => bloc.state.errorMessage,
    );
    final whatsAppGroups = context.select(
      (CommunicationBloc bloc) => bloc.state.whatsAppGroups,
    );

    if (status == CommunicationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == CommunicationStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? 'Failed to load groups',
        onRetry: () => context.read<CommunicationBloc>().add(
          CommunicationStarted(childId),
        ),
      );
    }

    return RefreshIndicator(
      displacement: MediaQuery.paddingOf(context).top + 80,
      color: context.brandPrimaryColor,
      onRefresh: () async {
        context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
      },
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
                  _buildHeader(context),
                  const Gap(32),

                  if (whatsAppGroups.isEmpty)
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: AppEmptyView(
                        title: 'No Groups',
                        message: 'No WhatsApp groups available for this child.',
                        icon: Icons.forum_outlined,
                        onAction: () => context.read<CommunicationBloc>().add(
                          CommunicationRefreshRequested(childId),
                        ),
                        actionLabel: 'Refresh',
                      ),
                    )
                  else
                    ...whatsAppGroups.asMap().entries.map(
                      (entry) => _GroupCard(group: entry.value, index: entry.key),
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

  Widget _buildHeader(BuildContext context) {
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
              'WhatsApp Groups',
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
              onPressed: () => context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId)),
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final dynamic group;
  final int index;

  const _GroupCard({required this.group, required this.index});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.borderPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.statusSuccessColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.chat_rounded, color: context.statusSuccessColor, size: 24),
          ),
          title: Text(
            group.name,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              fontSize: 15,
              letterSpacing: -0.2,
            ),
          ),
          subtitle: Text(
            'Join to get the latest updates',
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_ios_rounded, color: context.textTertiaryColor, size: 12),
          ),
          onTap: () async {
            final url = Uri.parse(group.url);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
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
          right: -100,
          child: _BlurredBlob(
            color: context.statusSuccessColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -100,
          left: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
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
