import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/score_circle.dart';
import 'bloc/attendance_history_page_bloc.dart';

class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<AttendanceHistoryPageBloc, AttendanceHistoryPageState>(
      builder: (context, state) {
        final isLoading = state.loadingState == LoadingState.loading;
        final records = state.records;

        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    palette.brandPrimary,
                    palette.brandPrimary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: palette.brandPrimary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['attendanceHistory']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
          ),
          body: isLoading && records.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  color: palette.brandPrimary,
                  onRefresh: () async {
                    context.read<AttendanceHistoryPageBloc>().add(
                      const AttendanceHistoryPageLoadEvent(),
                    );
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                          child: FadeInDown(
                            duration: const Duration(milliseconds: 600),
                            child: _StatsHeader(
                              state: state,
                              palette: palette,
                              t: t,
                            ),
                          ),
                        ),
                      ),
                      if (records.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: FadeInUp(
                            child: _EmptyAttendance(t: t, palette: palette),
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
                                  delay: Duration(milliseconds: 100 * i),
                                  child: _AttendanceItem(
                                    record: records[i],
                                    t: t,
                                    palette: palette,
                                  ),
                                );
                              },
                              childCount: records.length,
                            ),
                          ),
                        ),
                      const SliverToBoxAdapter(child: Gap(40)),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _StatsHeader extends StatelessWidget {
  final AttendanceHistoryPageState state;
  final MentorXThemeColorPalette palette;
  final Map<String, String> t;

  const _StatsHeader({
    required this.state,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          ScoreCircle(
            score: state.presentCount,
            total: state.totalCount,
            radius: 75,
            lineWidth: 14,
            activeColor: palette.brandPrimary,
            backgroundColor: palette.backgroundSecondary,
          ),
          const Gap(24),
          Text(
            t['attendanceRate'] ?? 'Attendance Rate',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(24),
          Row(
            children: [
              Expanded(
                child: _StatMiniCard(
                  label: t['present'] ?? 'Present',
                  value: state.presentCount.toString(),
                  color: palette.statusSuccess,
                  icon: Icons.check_circle_rounded,
                ),
              ),
              const Gap(16),
              Expanded(
                child: _StatMiniCard(
                  label: t['absent'] ?? 'Absent',
                  value: state.absentCount.toString(),
                  color: palette.statusDanger,
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

class _StatMiniCard extends StatelessWidget {
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.12), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Gap(12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color.withValues(alpha: 0.8),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceItem extends StatelessWidget {
  const _AttendanceItem({
    required this.record,
    required this.t,
    required this.palette,
  });
  final AttendanceRecordEntity record;
  final Map<String, String> t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    final present = record.status == AttendanceStatus.present;
    final formattedDate = DateFormat('dd MMM yyyy').format(record.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        (present ? palette.statusSuccess : palette.statusDanger)
                            .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    present ? Icons.check_rounded : Icons.close_rounded,
                    size: 20,
                    color: present
                        ? palette.statusSuccess
                        : palette.statusDanger,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.courseName ?? t['session'] ?? 'Session',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: palette.textPrimary,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12,
                            color: palette.textTertiary,
                          ),
                          const Gap(4),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: palette.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (record.sessionTitle != null) ...[
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: palette.backgroundSecondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      record.sessionTitle!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: palette.textSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyAttendance extends StatelessWidget {
  const _EmptyAttendance({required this.t, required this.palette});
  final Map<String, String> t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(
              Icons.event_busy_rounded,
              size: 80,
              color: palette.textTertiary.withValues(alpha: 0.2),
            ),
          ),
          const Gap(24),
          Text(
            t['noAttendance'] ?? 'No attendance records yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(8),
          Text(
            'Your attendance history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: palette.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
