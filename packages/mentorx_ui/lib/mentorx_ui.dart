import 'dart:ui' as ui;

// import 'package:mentorx_ui/assets/gen/assets.gen.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mix/mix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'localization/generated/strings.g.dart';

export 'localization/generated/strings.g.dart';

/// Extensions
part 'extensions/widget_extensions.dart';
part 'extensions/context_extensions.dart';
part 'extensions/mentorx_exception_extenions.dart';
part 'extensions/form_validation_extensions.dart';
part 'extensions/assets_extensions.dart';
part 'extensions/string_extensions.dart';

/// Theming
part 'theming/mentorx_theme_color_palette.dart';
part 'theming/mentorx_theme_extension.dart';
part 'theming/mentorx_theme_provider.dart';
part 'theming/mentorx_theme_tokens.dart';
part 'theming/mentorx_themes.dart';
part 'theming/app_colors.dart';

/// Utils
part 'utils/mentorx_platform_checker.dart';

/// Widgets
part 'widgets/mentorx_translation_provider.dart';
part 'widgets/empty_state.dart';
part 'widgets/section_header.dart';
part 'widgets/stat_card.dart';
part 'widgets/gradient_card.dart';
part 'widgets/mentorx_button.dart';
part 'widgets/mentorx_text_form_field.dart';
part 'widgets/mentorx_logo.dart';
part 'widgets/mentorx_clickable_text.dart';
part 'widgets/mentorx_skeleton.dart';
part 'widgets/mentorx_shimmer.dart';
part 'widgets/quick_action_item.dart';
part 'widgets/avatar_switcher_item.dart';
part 'widgets/app_logo_display.dart';
part 'widgets/app_hero_card.dart';
part 'widgets/announcement_card.dart';
part 'widgets/activity_list_tile.dart';
part 'widgets/auth_scaffold.dart';
part 'widgets/step_progress_indicator.dart';
part 'widgets/announcement_scroll_view.dart';
part 'widgets/app_dashboard_scaffold.dart';
part 'widgets/app_error_view.dart';
part 'widgets/app_empty_view.dart';
part 'widgets/announcement_list_item.dart';
part 'widgets/transaction_list_tile.dart';
part 'widgets/app_summary_card.dart';
part 'widgets/attendance_rate_card.dart';
part 'widgets/status_badge.dart';
part 'widgets/generic_list_tile.dart';

final class MentorXUI {
  MentorXUI._();

  static void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
    );
  }
}
