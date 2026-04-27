import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/communication_bloc.dart';
import 'package:intl/intl.dart';

class AnnouncementsArchivePage extends StatelessWidget {
  final String childId;

  const AnnouncementsArchivePage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => CommunicationBloc(
        repository: context.read<ParentCommunicationRepository>(),
      )..add(CommunicationStarted(childId)),
      child: BlocBuilder<CommunicationBloc, CommunicationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Column(
              children: [
                // Premium Header
                _BuildHeader(palette: palette, childId: childId, title: t.announcements),
                
                Expanded(
                  child: _buildBody(context, state, palette, t),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CommunicationState state, MentorXThemeColorPalette palette, TranslationsParentEn t) {
    if (state.status == CommunicationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == CommunicationStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger),
              const SizedBox(height: 16),
              Text(
                state.errorMessage ?? t.unableToLoad,
                textAlign: TextAlign.center,
                style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 120,
                child: MentorXButton(
                  onPressed: () => context.read<CommunicationBloc>().add(CommunicationStarted(childId)),
                  text: t.retry,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.announcements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.campaign_rounded, size: 64, color: palette.textTertiary.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              t.noData,
              style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: palette.brandPrimary,
      onRefresh: () async {
        context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: state.announcements.length,
        itemBuilder: (context, index) {
          final announcement = state.announcements[index];
          return _AnnouncementCard(announcement: announcement, palette: palette);
        },
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final String childId;
  final String title;
  const _BuildHeader({required this.palette, required this.childId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 24,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () => context.read<CommunicationBloc>().add(CommunicationRefreshRequested(childId)),
            icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;
  final MentorXThemeColorPalette palette;

  const _AnnouncementCard({required this.announcement, required this.palette});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(announcement.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: palette.brandPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.campaign_rounded, color: palette.brandPrimary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  announcement.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            announcement.preview ?? '',
            style: TextStyle(
              fontSize: 13,
              color: palette.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: palette.textTertiary,
                ),
              ),
              Text(
                'Read More',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: palette.brandPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
