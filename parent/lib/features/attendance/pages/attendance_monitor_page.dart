import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:parent/core/core.dart';
import '../bloc/attendance_bloc.dart';

class AttendanceMonitorPage extends StatelessWidget {
  final String childId;

  const AttendanceMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return BlocProvider(
      create: (context) => AttendanceBloc(
        repository: context.read<ParentAttendanceRepository>(),
      )..add(AttendanceStarted(childId)),
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: palette.backgroundPrimary,
            body: Column(
              children: [
                // Premium Header
                _BuildHeader(palette: palette, childId: childId),
                
                Expanded(
                  child: _buildBody(context, state, palette),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AttendanceState state, MentorXThemeColorPalette palette) {
    if (state.status == AttendanceBlocStatus.loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(palette.brandPrimary),
        ),
      );
    }

    if (state.status == AttendanceBlocStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomIn(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: palette.statusDanger.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.error_outline_rounded, size: 48, color: palette.statusDanger),
                ),
              ),
              const Gap(24),
              Text(
                state.errorMessage ?? 'Failed to load attendance data',
                textAlign: TextAlign.center,
                style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const Gap(24),
              MentorXButton(
                onPressed: () => context.read<AttendanceBloc>().add(AttendanceStarted(childId)),
                label: 'Retry',
                size: MentorXButtonSize.small,
              ),
            ],
          ),
        ),
      );
    }

    if (state.attendanceRecords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: palette.backgroundSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.calendar_month_outlined, size: 48, color: palette.textTertiary.withValues(alpha: 0.2)),
            ),
            const Gap(16),
            Text(
              'No attendance records found',
              style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: palette.brandPrimary,
      backgroundColor: Colors.white,
      onRefresh: () async {
        context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId));
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          if (state.attendanceSummary != null) ...[
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: _BuildSummaryCard(summary: state.attendanceSummary!, palette: palette),
            ),
            const Gap(40),
          ],
          
          FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child: Text(
              'Attendance Log',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Gap(16),
          
          ...state.attendanceRecords.asMap().entries.map(
            (entry) => FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 50 * entry.key),
              child: _AttendanceRecordCard(record: entry.value, palette: palette),
            ),
          ),
          
          const Gap(40),
        ],
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final String childId;
  const _BuildHeader({required this.palette, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 24,
        left: 12,
        right: 12,
      ),
      color: palette.backgroundPrimary,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: palette.textPrimary, size: 20),
          ),
          const Expanded(
            child: Text(
              'Attendance Monitor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
          ),
          IconButton(
            onPressed: () => context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId)),
            icon: Icon(Icons.refresh_rounded, color: palette.brandPrimary, size: 24),
          ),
        ],
      ),
    );
  }
}

class _BuildSummaryCard extends StatelessWidget {
  final AttendanceSummaryEntity summary;
  final MentorXThemeColorPalette palette;

  const _BuildSummaryCard({required this.summary, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                (summary.attendanceRate * 100).toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: palette.brandPrimary,
                  letterSpacing: -2.0,
                ),
              ),
              Text(
                '%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: palette.brandPrimary.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            'Overall Attendance Rate',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: palette.textSecondary,
            ),
          ),
          const Gap(32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: palette.backgroundSecondary.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatMiniItem(label: 'Present', value: summary.present.toString(), color: palette.statusSuccess),
                _StatMiniItem(label: 'Absent', value: summary.absent.toString(), color: palette.statusDanger),
                _StatMiniItem(label: 'Late', value: summary.late.toString(), color: palette.statusWarning),
                _StatMiniItem(label: 'Excused', value: summary.excused.toString(), color: palette.brandPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatMiniItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatMiniItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: MentorXThemeColorPalette.light.textTertiary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _AttendanceRecordCard extends StatelessWidget {
  final AttendanceRecordEntity record;
  final MentorXThemeColorPalette palette;

  const _AttendanceRecordCard({required this.record, required this.palette});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(record.status, palette);
    final statusLabel = record.status.name.toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.event_available_rounded, color: statusColor, size: 24),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.courseName ?? 'Regular Session',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                  ),
                ),
                const Gap(4),
                Text(
                  '${record.sessionTitle ?? "General Academic"} • ${record.date.toString().split(" ").first}',
                  style: TextStyle(
                    fontSize: 13,
                    color: palette.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(
                color: statusColor,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AttendanceStatus status, MentorXThemeColorPalette palette) {
    switch (status) {
      case AttendanceStatus.present: return palette.statusSuccess;
      case AttendanceStatus.absent: return palette.statusDanger;
      case AttendanceStatus.late: return palette.statusWarning;
      case AttendanceStatus.excused: return palette.brandPrimary;
    }
  }
}
