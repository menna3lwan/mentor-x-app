import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';


final class AttendanceHistoryPagePage extends StatelessWidget {
  final LoadingState loadingState;
  final List<AttendanceRecordEntity> records;
  final int presentCount;
  final int totalCount;
  final int absentCount;
  final VoidCallback onRefresh;

  const AttendanceHistoryPagePage({
    super.key,
    required this.loadingState,
    required this.records,
    required this.presentCount,
    required this.totalCount,
    required this.absentCount,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
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
                        child: MentorXSkeleton(height: 100, borderRadius: 24),
                      ),
                    )
                  : RefreshIndicator(
                      color: context.brandPrimaryColor,
                      onRefresh: () async => onRefresh(),
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Gap(MediaQuery.paddingOf(context).top + 20),
                                _buildHeader(context, t),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
                              ],
                            ),
                          ),
                          if (records.isEmpty)
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: AppEmptyView(
                                title: t['noAttendance'] ?? 'No attendance records yet',
                                message: 'Your attendance history will appear here',
                                icon: Icons.event_available_rounded,
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
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'ENGAGEMENT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    t['attendanceHistory'] ?? 'Attendance',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
    final rate = totalCount == 0 ? 0 : (presentCount / totalCount * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['attendanceRate'] ?? 'Attendance Rate',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: context.textSecondaryColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$rate',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                            letterSpacing: -1.0,
                          ),
                        ),
                        const Gap(4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: context.brandPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: CircularProgressIndicator(
                  value: totalCount == 0 ? 0 : presentCount / totalCount,
                  strokeWidth: 6,
                  color: context.brandPrimaryColor,
                  backgroundColor: context.brandPrimaryColor.withValues(alpha: 0.1),
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),
          const Gap(24),
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
              const Gap(12),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const Gap(12),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: context.textTertiaryColor,
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            present ? Icons.check_rounded : Icons.close_rounded,
            size: 20,
            color: statusColor,
          ),
        ),
        title: Text(
          record.courseName ?? t['session'] ?? 'Session',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
            letterSpacing: -0.3,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 12,
              color: context.textTertiaryColor,
            ),
            const Gap(6),
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: context.textTertiaryColor,
              ),
            ),
          ],
        ),
        trailing: record.sessionTitle != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  record.sessionTitle!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: context.textSecondaryColor,
                  ),
                ),
              )
            : null,
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
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 350,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
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
