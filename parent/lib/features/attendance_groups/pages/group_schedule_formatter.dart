import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Pure helper that converts schedule entries to localized strings.
///
/// Lives in a separate file so it can be reused by both the list card
/// (one-line summary) and the detail page (full weekly table).
final class GroupScheduleFormatter {
  GroupScheduleFormatter._();

  /// Returns a short summary like "Mon 17:00 - 19:00" for the first entry
  /// in [schedule], or `null` when the schedule is empty.
  static String? firstScheduleLine(
    List<ParentGroupScheduleEntry> schedule, {
    required TranslationsParentEn t,
  }) {
    if (schedule.isEmpty) return null;
    final first = schedule.first;
    return '${_dayName(first.dayOfWeek, t)}  ${first.startTime} — ${first.endTime}';
  }

  /// Returns the localized day name for [dayOfWeek] (1..7).
  static String _dayName(int dayOfWeek, TranslationsParentEn t) {
    return switch (dayOfWeek) {
      1 => t.attendanceTracking.dayMonday,
      2 => t.attendanceTracking.dayTuesday,
      3 => t.attendanceTracking.dayWednesday,
      4 => t.attendanceTracking.dayThursday,
      5 => t.attendanceTracking.dayFriday,
      6 => t.attendanceTracking.daySaturday,
      7 => t.attendanceTracking.daySunday,
      _ => t.attendanceTracking.dayMonday,
    };
  }

  /// Localized day name (public passthrough so detail page can reuse).
  static String dayName(int dayOfWeek, TranslationsParentEn t) =>
      _dayName(dayOfWeek, t);
}
