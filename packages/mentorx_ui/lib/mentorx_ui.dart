import 'dart:ui' as ui;

// import 'package:mentorx_ui/assets/gen/assets.gen.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

/// Utils
part 'utils/mentorx_platform_checker.dart';

/// Widgets
part 'widgets/mentorx_translation_provider.dart';

final class MentorXUI {
  MentorXUI._();

  static void showToast({required String message}) {
    Fluttertoast.showToast(msg: message);
  }
}
