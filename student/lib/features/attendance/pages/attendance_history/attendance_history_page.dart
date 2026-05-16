import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';


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
    final t = context.t.attendance;
    final isLoading = loadingState == LoadingState.loading;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: isLoading && records.isEmpty
          ? _buildLoadingState(context)
          : RefreshIndicator(
              color: context.brandPrimaryColor,
              onRefresh: () async => onRefresh(),
              child: Column(
                children: [
                  _buildHeader(context, t),
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
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
                              title: t.noAttendance,
                              message: t.attendanceHistoryDesc,
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
            ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Column(
      children: [
        Gap(MediaQuery.paddingOf(context).top + 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: MentorXSkeleton(height: 80, borderRadius: 24),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: 8,
            itemBuilder: (_, _) => const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: MentorXSkeleton(height: 100, borderRadius: 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ENGAGEMENT',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.attendanceHistory,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(24),
        $box.borderRadius(32),
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
                      t.attendanceRate,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$rate',
                          style: context.titleH1Style.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                          ),
                        ),
                        const Gap(4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '%',
                            style: context.titleH3Style.copyWith(
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
                  label: t.present,
                  value: presentCount.toString(),
                  color: context.statusSuccessColor,
                  icon: Icons.check_circle_rounded,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _StatMiniCard(
                  label: t.absent,
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
    return MentorXGlassCard(
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(20),
        $box.color(context.backgroundPrimaryColor.withValues(alpha: 0.3)),
        $box.border.all.color(color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const Gap(12),
          Text(
            value,
            style: context.titleH2Style.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            label,
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
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

    return MentorXGlassCard(
      style: Style(
        $box.margin.bottom(12),
        $box.borderRadius(24),
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
          record.courseName ?? t.session,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.bodyPrimaryStyle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w900,
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
              style: context.bodySecondaryStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        trailing: record.sessionTitle != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  record.sessionTitle!,
                  style: context.bodySecondaryStyle.copyWith(
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
