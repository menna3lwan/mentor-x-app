import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/score_circle.dart';
import 'bloc/attendance_history_page_bloc.dart';

final class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Builder(
      builder: (context) {
        final loadingState = context.select<
          AttendanceHistoryPageBloc,
          LoadingState
        >((bloc) => bloc.state.loadingState);
        final records = context.select<
          AttendanceHistoryPageBloc,
          List<AttendanceRecordEntity>
        >((bloc) => bloc.state.records);
        final presentCount = context.select<AttendanceHistoryPageBloc, int>(
          (bloc) => bloc.state.presentCount,
        );
        final totalCount = context.select<AttendanceHistoryPageBloc, int>(
          (bloc) => bloc.state.totalCount,
        );
        final absentCount = context.select<AttendanceHistoryPageBloc, int>(
          (bloc) => bloc.state.absentCount,
        );

        final isLoading = loadingState == LoadingState.loading;

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          body: Stack(
            children: [
              const _BackgroundDecorations(),
              isLoading && records.isEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      itemCount: 8,
                      itemBuilder: (_, _) => const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: MentorXSkeleton(height: 100, borderRadius: 28),
                      ),
                    )
                  : RefreshIndicator(
                      color: context.brandPrimaryColor,
                      onRefresh: () async {
                        context.read<AttendanceHistoryPageBloc>().add(
                          const AttendanceHistoryPageLoadEvent(),
                        );
                      },
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 120,
                            collapsedHeight: 80,
                            pinned: true,
                            floating: true,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            surfaceTintColor: Colors.transparent,
                            flexibleSpace: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: FlexibleSpaceBar(
                                  centerTitle: true,
                                  title: Text(
                                    t['attendanceHistory']!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: context.textPrimaryColor,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      color: context.backgroundSecondaryColor
                                          .withValues(alpha: 0.45),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: context.borderPrimaryColor
                                              .withValues(alpha: 0.1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                              child: FadeInDown(
                                duration: const Duration(milliseconds: 600),
                                child: _StatsHeader(
                                  presentCount: presentCount,
                                  totalCount: totalCount,
                                  absentCount: absentCount,
                                  t: t,
                                ),
                              ),
                            ),
                          ),
                          if (records.isEmpty)
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: AppEmptyView(
                                title: t['noAttendance'] ?? 'No attendance records yet',
                                message: 'Your attendance history will appear here',
                                icon: Icons.event_busy_rounded,
                              ),
                            )
                          else
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, i) {
                                    return FadeInUp(
                                      duration: const Duration(milliseconds: 500),
                                      delay: Duration(milliseconds: 50 * i),
                                      child: _AttendanceItem(
                                        record: records[i],
                                        t: t,
                                      ),
                                    );
                                  },
                                  childCount: records.length,
                                ),
                              ),
                            ),
                          const SliverToBoxAdapter(child: Gap(100)),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

final class _StatsHeader extends StatelessWidget {
  final int presentCount;
  final int totalCount;
  final int absentCount;
  final dynamic t;

  const _StatsHeader({
    required this.presentCount,
    required this.totalCount,
    required this.absentCount,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                ScoreCircle(
                  score: presentCount,
                  total: totalCount,
                  radius: 80,
                  lineWidth: 16,
                  activeColor: context.brandPrimaryColor,
                  backgroundColor: context.backgroundPrimaryColor.withValues(alpha: 0.5),
                ),
                const Gap(32),
                Text(
                  t['attendanceRate'] ?? 'Attendance Rate',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const Gap(32),
                Row(
                  children: [
                    Expanded(
                      child: _StatMiniCard(
                        label: t['present'] ?? 'Present',
                        value: presentCount.toString(),
                        color: context.statusSuccessColor,
                        icon: Icons.check_circle_rounded,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: _StatMiniCard(
                        label: t['absent'] ?? 'Absent',
                        value: absentCount.toString(),
                        color: context.statusDangerColor,
                        icon: Icons.cancel_rounded,
                      ),
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

final class _StatMiniCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatMiniCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Gap(16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: context.textTertiaryColor,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

final class _AttendanceItem extends StatelessWidget {
  const _AttendanceItem({
    required this.record,
    required this.t,
  });
  final AttendanceRecordEntity record;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final present = record.status == AttendanceStatus.present;
    final formattedDate = DateFormat('dd MMM yyyy').format(record.date);
    final statusColor = present ? context.statusSuccessColor : context.statusDangerColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              statusColor.withValues(alpha: 0.2),
                              statusColor.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Icon(
                          present ? Icons.check_rounded : Icons.close_rounded,
                          size: 22,
                          color: statusColor,
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.courseName ?? t['session'] ?? 'Session',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: context.textPrimaryColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const Gap(6),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  size: 14,
                                  color: context.textTertiaryColor,
                                ),
                                const Gap(8),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: context.textTertiaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (record.sessionTitle != null) ...[
                        const Gap(12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                          child: Text(
                            record.sessionTitle!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
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
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
