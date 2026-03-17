# PRODUCTION BLUEPRINT — Part 2: Patterns 6–8

---

## PATTERN 6: CACHE REPOSITORY (`flutter_secure_storage_cache_repository`)

### 6.1 Package structure

```
packages/common/flutter_secure_storage_cache_repository/
├── pubspec.yaml
└── lib/
    ├── flutter_secure_storage_cache_repository.dart   # Barrel
    └── src/
        └── flutter_secure_storage_cache_repository.dart
```

### 6.2 `pubspec.yaml`

```yaml
name: flutter_secure_storage_cache_repository
description: "Secure storage implementation of CacheRepository."
version: 1.0.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.8.1

dependencies:
  flutter_secure_storage: ^9.2.4
  {{project_name}}_core:
    path: ../../{{project_name}}_core

dev_dependencies:
  lints: ^6.0.0
  test: ^1.24.0
```

### 6.3 Implementation template

```dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';

final class FlutterSecureStorageCacheRepository implements CacheRepository {
  late final FlutterSecureStorage _storage;

  FlutterSecureStorageCacheRepository();

  @override
  Future<void> initialize() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> put(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  /// Convenience: save location to history
  Future<void> saveHistoryLocation(LocationEntity location) async {
    final historyJson = await get(CacheKeys.historyLocations);
    List<dynamic> history = [];
    if (historyJson != null) {
      history = jsonDecode(historyJson) as List<dynamic>;
    }
    // Remove duplicate
    history.removeWhere(
      (item) => (item as Map<String, dynamic>)['id'] == location.id,
    );
    // Prepend and limit
    history.insert(0, location.toJson());
    if (history.length > 10) history = history.sublist(0, 10);
    await put(CacheKeys.historyLocations, jsonEncode(history));
  }
}
```

**Cache repository rules**:

- Implements `CacheRepository` from core (no Flutter dependency in the interface)
- Uses `flutter_secure_storage` for encrypted key-value storage
- `initialize()` creates the storage instance with platform-appropriate options
- All values stored as `String` — use `jsonEncode`/`jsonDecode` for complex objects
- Domain-specific convenience methods (like `saveHistoryLocation`) can be added

---

## PATTERN 7: MOCK DATA (`mock_data`)

A centralized package that generates realistic, localized mock data for all entities.

### 7.1 Package structure

```
packages/mock_data/
├── pubspec.yaml
└── lib/
    ├── mock_data.dart                    # Barrel (uses standard exports, NOT part)
    └── src/
        ├── clients/
        │   └── mock_localized_client.dart
        ├── config/
        │   └── mock_data_config.dart
        ├── generators/                    # One per entity type
        │   ├── base_generator.dart
        │   ├── category_generator.dart
        │   ├── vendor_generator.dart
        │   ├── service_generator.dart
        │   ├── event_generator.dart
        │   ├── notification_generator.dart
        │   └── ...
        ├── localization/
        │   ├── localized_data_manager.dart
        │   └── models/                    # Bilingual data containers
        │       ├── localized_category_data.dart
        │       ├── localized_vendor_data.dart
        │       └── ...
        ├── cache/
        │   ├── mock_cache_manager.dart
        │   ├── cache_keys.dart
        │   ├── mock_caching_strategy.dart   # enum: inMemory, secureStorage
        │   ├── in_memory_cache_store.dart
        │   └── serialization_helpers.dart
        ├── state/
        │   ├── mock_data_store.dart
        │   ├── relationship_manager.dart
        │   └── id_generator.dart
        └── utils/
            ├── faker_extensions.dart
            └── qatar_data_helpers.dart
```

### 7.2 `pubspec.yaml`

```yaml
name: mock_data
description: "Centralized mock data with multi-language support."
version: 1.0.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  {{project_name}}_core:
    path: ../{{project_name}}_core
  faker: ^2.1.0
  equatable: ^2.0.7

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.4
  lints: ^6.0.0
  test: ^1.26.3
```

### 7.3 Barrel file (`mock_data.dart`)

```dart
library;

// Clients
export 'src/clients/mock_localized_client.dart';

// Configuration
export 'src/config/mock_data_config.dart';

// Generators
export 'src/generators/base_generator.dart';
export 'src/generators/category_generator.dart';
export 'src/generators/vendor_generator.dart';
export 'src/generators/service_generator.dart';
export 'src/generators/event_generator.dart';
export 'src/generators/notification_generator.dart';

// Localization
export 'src/localization/localized_data_manager.dart';
export 'src/localization/models/localized_category_data.dart';
export 'src/localization/models/localized_vendor_data.dart';

// Cache
export 'src/cache/mock_cache_manager.dart';
export 'src/cache/mock_caching_strategy.dart';
export 'src/cache/in_memory_cache_store.dart';

// State
export 'src/state/mock_data_store.dart';
export 'src/state/relationship_manager.dart';
export 'src/state/id_generator.dart';
```

**Key difference from core/UI**: `mock_data` uses regular `export` statements, NOT the `part` pattern. This is because it's a utility package composed of many independent classes.

### 7.4 MockLocalizedClient

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';

final class MockLocalizedClient implements LocalizedClient {
  String _languageCode;

  MockLocalizedClient({required String languageCode})
      : _languageCode = languageCode;

  @override
  String get languageCode => _languageCode;

  @override
  set languageCode(String code) => _languageCode = code;
}
```

### 7.5 MockCachingStrategy

```dart
enum MockCachingStrategy {
  inMemory,
  secureStorage;

  static MockCachingStrategy fromString(String value) {
    for (final strategy in values) {
      if (strategy.name.toLowerCase() == value.toLowerCase()) {
        return strategy;
      }
    }
    return MockCachingStrategy.inMemory;
  }
}
```

### 7.6 Localized data model template

```dart
import 'package:equatable/equatable.dart';

final class Localized{{Entity}}Data extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;
  final String? descriptionEn;
  final String? descriptionAr;
  // Add more bilingual fields as needed

  const Localized{{Entity}}Data({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
  });

  String name(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;

  String? description(String languageCode) =>
      languageCode == 'ar' ? descriptionAr : descriptionEn;

  @override
  List<Object?> get props => [id, nameEn, nameAr];
}
```

### 7.7 Generator template

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:faker/faker.dart';
import '../localization/models/localized_{{entity}}_data.dart';

final class {{Entity}}Generator {
  {{Entity}}Generator._();

  static final _faker = Faker();

  /// Pre-defined localized data (hand-crafted for realism)
  static const List<Localized{{Entity}}Data> _localizedData = [
    Localized{{Entity}}Data(
      id: '{{entity}}_001',
      nameEn: 'English Name Here',
      nameAr: 'الاسم بالعربي هنا',
      descriptionEn: 'English description',
      descriptionAr: 'الوصف بالعربي',
    ),
    // Add more entries...
  ];

  static List<{{Entity}}Entity> generate({
    required String languageCode,
    int? count,
  }) {
    final data = count != null
        ? _localizedData.take(count).toList()
        : _localizedData;
    return data.map((localized) => {{Entity}}Entity(
      id: localized.id,
      name: localized.name(languageCode),
      createdAt: DateTime.now().subtract(
        Duration(days: _faker.randomGenerator.integer(365)),
      ),
      updatedAt: DateTime.now(),
    )).toList();
  }
}
```

**Mock data rules**:

- Hand-crafted bilingual data (not random Faker strings) for entities that need realism
- Faker for supplementary/randomized fields (dates, numbers, etc.)
- Each generator is stateless with static methods
- `LocalizedClient` tracks which language mock repos should use
- `MockCachingStrategy` allows env-configurable persistence (in-memory vs secure storage)
- All mock repos reference this package instead of generating their own data

---

## PATTERN 8: UI KIT (`{{project_name}}_ui`)

A shared Flutter UI library providing theming, localization, and 50+ reusable widgets. **This is the visual system.**

### 8.1 Package structure

```
packages/{{project_name}}_ui/
├── pubspec.yaml
├── build.yaml                  # Code gen config (FlutterGen, slang)
├── slang.yaml                  # Localization config
└── lib/
    ├── {{project_name}}_ui.dart   # Single library barrel (all others are `part`)
    ├── assets/
    │   ├── gen/                   # FlutterGen output (auto-generated)
    │   │   └── assets.gen.dart
    │   ├── images/
    │   ├── svgs/                  # Vector graphics (auto-compiled)
    │   └── icons/                 # Icon SVGs (auto-compiled)
    ├── localization/
    │   ├── generated/             # Slang output (auto-generated)
    │   │   ├── strings.g.dart
    │   │   ├── strings_en.g.dart
    │   │   └── strings_ar.g.dart
    │   └── sources/               # Slang input (hand-written)
    │       ├── strings_en.json
    │       └── strings_ar.json
    ├── theming/
    │   ├── {{project_name}}_theme_color_palette.dart
    │   ├── {{project_name}}_theme_extension.dart
    │   ├── {{project_name}}_theme_provider.dart
    │   ├── {{project_name}}_theme_tokens.dart
    │   └── {{project_name}}_themes.dart
    ├── extensions/
    │   ├── context_extensions.dart
    │   ├── form_validation_extensions.dart
    │   ├── country_extensions.dart
    │   ├── {{project_name}}_exception_extensions.dart
    │   ├── num_extensions.dart
    │   ├── string_extensions.dart
    │   └── assets_extensions.dart
    ├── utils/
    │   └── {{project_name}}_platform_checker.dart
    └── widgets/
        ├── {{project_name}}_button.dart
        ├── {{project_name}}_bottom_sheet.dart
        ├── {{project_name}}_bottom_navigation_bar.dart
        ├── {{project_name}}_main_app_bar.dart
        ├── {{project_name}}_text_form_field.dart
        ├── {{project_name}}_dynamic_image.dart
        ├── {{project_name}}_paginated_list.dart
        ├── {{project_name}}_translation_provider.dart
        ├── {{project_name}}_skeleton_provider.dart
        ├── {{project_name}}_error_indicator.dart
        ├── {{project_name}}_vendor_card.dart
        ├── {{project_name}}_service_card.dart
        ├── {{project_name}}_category_card.dart
        ├── {{project_name}}_event_card.dart
        ├── {{project_name}}_setting_tile.dart
        └── ... (50+ widgets)
```

### 8.2 `pubspec.yaml`

```yaml
name: {{project_name}}_ui
description: "Shared UI library: theming, localization, widgets."
version: 0.0.1
publish_to: none
resolution: workspace

environment:
  sdk: ^3.9.2
  flutter: ">=1.17.0"

dependencies:
  flutter:
    sdk: flutter

  # Theming
  mix: ^1.7.0

  # Utils
  intl: ^0.20.2
  equatable: ^2.0.7
  geolocator: ^14.0.2
  permission_handler: ^12.0.1

  # Image caching
  cached_network_image: ^3.4.1

  # Vector graphics
  vector_graphics: ^1.1.19

  # UI helpers
  gap: ^3.0.1
  fluttertoast: ^9.0.0
  country_flags: ^4.1.0
  google_maps_flutter: ^2.13.1
  skeletonizer: ^2.1.0+1
  url_launcher: ^6.2.4
  flutter_animate: ^4.5.2

  # Localization
  slang: ^4.8.1
  slang_flutter: ^4.8.0

  # Domain types
  {{project_name}}_core:
    path: ../{{project_name}}_core

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  flutter_gen_runner: ^5.12.0
  slang_build_runner: ^4.8.1
  build_runner: ^2.7.1

flutter:
  assets:
    - lib/assets/images/
    - path: lib/assets/svgs/
      transformers:
        - package: vector_graphics_compiler
    - path: lib/assets/icons/
      transformers:
        - package: vector_graphics_compiler

flutter_gen:
  output: lib/assets/gen/
  line_length: 80
  fonts:
    enabled: false
  colors:
    enabled: false
  assets:
    enabled: true
    outputs:
      class_name: AppAssets
      package_parameter_enabled: true
```

### 8.3 `build.yaml`

```yaml
targets:
  $default:
    builders:
      slang_build_runner:
        enabled: false     # Use CLI instead: dart run slang
      flutter_gen_runner:
        enabled: true      # Auto-generates asset references
```

### 8.4 `slang.yaml`

```yaml
output_directory: lib/localization/generated
input_file_pattern: .json
input_directory: lib/localization/sources
paramCase: camel
base_locale: en
```

### 8.5 Barrel file (`{{project_name}}_ui.dart`)

```dart
import 'dart:ui' as ui;
import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:equatable/equatable.dart';
import 'package:{{project_name}}_ui/assets/gen/assets.gen.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mix/mix.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter_animate/flutter_animate.dart';

import 'localization/generated/strings.g.dart';

// Re-export commonly used types so app doesn't need direct dependency
export 'localization/generated/strings.g.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:vector_graphics/vector_graphics.dart'
    show VectorGraphic, AssetBytesLoader;
export 'package:flutter_animate/flutter_animate.dart';

/// Extensions
part 'extensions/context_extensions.dart';
part 'extensions/form_validation_extensions.dart';
part 'extensions/country_extensions.dart';
part 'extensions/{{project_name}}_exception_extensions.dart';
part 'extensions/num_extensions.dart';
part 'extensions/string_extensions.dart';
part 'extensions/assets_extensions.dart';

/// Theming
part 'theming/{{project_name}}_theme_color_palette.dart';
part 'theming/{{project_name}}_theme_extension.dart';
part 'theming/{{project_name}}_theme_provider.dart';
part 'theming/{{project_name}}_theme_tokens.dart';
part 'theming/{{project_name}}_themes.dart';

/// Utils
part 'utils/{{project_name}}_platform_checker.dart';

/// Widgets (one part per widget)
part 'widgets/{{project_name}}_button.dart';
part 'widgets/{{project_name}}_bottom_sheet.dart';
part 'widgets/{{project_name}}_bottom_navigation_bar.dart';
part 'widgets/{{project_name}}_main_app_bar.dart';
// ... add all widget parts here
```

**Key rule**: The UI kit is a **single library** (`library;`) where all files use `part of`. The only exception is `{{project_name}}_conditional_wrapper.dart` which uses a regular `import` where needed.

### 8.6 Design Token System (Mix)

The theming system has 5 layers:

#### Layer 1: Color Palette

```dart
part of '../{{project_name}}_ui.dart';

final class {{Project}}ThemeColorPalette {
  // Brand colors
  final Color brandPrimary;
  final Color brandPressed;
  final Color brandTransparent;
  final Color brandSecondary;
  final Color brandTertiary;
  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textForeground;
  // Background colors
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color backgroundPrimaryTransparent;
  final Color backgroundElevatedSurface;
  final Color backgroundElevatedSurfaceShadow;
  // Status colors
  final Color statusDanger;
  final Color statusSuccess;
  final Color statusWarning;

  const {{Project}}ThemeColorPalette({
    required this.brandPrimary,
    required this.brandPressed,
    required this.brandTransparent,
    required this.brandSecondary,
    required this.brandTertiary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textForeground,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.backgroundPrimaryTransparent,
    required this.backgroundElevatedSurface,
    required this.backgroundElevatedSurfaceShadow,
    required this.statusDanger,
    required this.statusSuccess,
    required this.statusWarning,
  });

  static const light = {{Project}}ThemeColorPalette(
    brandPrimary: Color(0xff67314F),
    // ... fill with your light palette
  );

  static const dark = {{Project}}ThemeColorPalette(
    brandPrimary: Color(0xff67314F),
    // ... fill with your dark palette
  );
}
```

#### Layer 2: Design tokens

```dart
part of '../{{project_name}}_ui.dart';

const ${{project_name}}Token = {{Project}}Token();

final class {{Project}}Token {
  const {{Project}}Token();
  final color = const {{Project}}ColorToken();
  final textStyle = const {{Project}}TextStyleToken();
  final radius = const {{Project}}RadiusToken();
}

final class {{Project}}ColorToken {
  const {{Project}}ColorToken();
  ColorToken get brandPrimary => const ColorToken('brandPrimary');
  ColorToken get brandPressed => const ColorToken('brandPressed');
  // ... one getter per color
}

final class {{Project}}TextStyleToken {
  const {{Project}}TextStyleToken();
  TextStyleToken get titleH1 => const TextStyleToken('titleH1');
  TextStyleToken get titleH2 => const TextStyleToken('titleH2');
  TextStyleToken get titleH3 => const TextStyleToken('titleH3');
  TextStyleToken get titleH4 => const TextStyleToken('titleH4');
  TextStyleToken get titleH5 => const TextStyleToken('titleH5');
  TextStyleToken get body => const TextStyleToken('body');
  TextStyleToken get bodyBold => const TextStyleToken('bodyBold');
  TextStyleToken get bodyLarge => const TextStyleToken('bodyLarge');
  TextStyleToken get bodyLargeBold => const TextStyleToken('bodyLargeBold');
  TextStyleToken get bodySmall => const TextStyleToken('bodySmall');
  TextStyleToken get bodySmallBold => const TextStyleToken('bodySmallBold');
  TextStyleToken get bodyExtraSmall => const TextStyleToken('bodyExtraSmall');
  TextStyleToken get bodyExtraSmallBold => const TextStyleToken('bodyExtraSmallBold');
}

final class {{Project}}RadiusToken {
  const {{Project}}RadiusToken();
  RadiusToken get thin => const RadiusToken('thin');
  RadiusToken get extraSmall => const RadiusToken('extraSmallRadius');
  RadiusToken get small => const RadiusToken('smallRadius');
  RadiusToken get medium => const RadiusToken('mediumRadius');
  RadiusToken get large => const RadiusToken('largeRadius');
}
```

#### Layer 3: Theme factory (maps palette → MixThemeData)

```dart
part of '../{{project_name}}_ui.dart';

final class {{Project}}Themes {
  {{Project}}Themes._();

  static final MixThemeData light = fromColorPalette(
    {{Project}}ThemeColorPalette.light,
    brightness: Brightness.light,
  );
  static final MixThemeData dark = fromColorPalette(
    {{Project}}ThemeColorPalette.dark,
    brightness: Brightness.dark,
  );

  static MixThemeData fromBrightness(Brightness brightness) =>
      brightness == Brightness.light ? light : dark;

  static MixThemeData fromColorPalette(
    {{Project}}ThemeColorPalette palette, {
    Brightness? brightness,
    Map<ColorToken, Color> colorOverrides = const {},
    Map<RadiusToken, Radius> radiusOverrides = const {},
    Map<TextStyleToken, TextStyle> textStyleOverrides = const {},
  }) {
    final colorTokens = ${{project_name}}Token.color;
    final radiusTokens = ${{project_name}}Token.radius;
    final styleTokens = ${{project_name}}Token.textStyle;
    final fontFamily = '{{CustomFontFamily}}';
    final fallbackFontFamily = '{{FallbackFontFamily}}';

    return MixThemeData(
      colors: {
        colorTokens.brandPrimary: palette.brandPrimary,
        colorTokens.brandPressed: palette.brandPressed,
        // ... map all color tokens to palette values
      }..addAll(colorOverrides),
      textStyles: {
        styleTokens.titleH1: TextStyle(
          height: 1.15, fontSize: 44,
          fontFamily: fontFamily, fontWeight: FontWeight.w700,
          color: palette.textPrimary,
          fontFamilyFallback: [fallbackFontFamily],
        ),
        styleTokens.titleH2: TextStyle(
          height: 1.15, fontSize: 28,
          fontFamily: fontFamily, fontWeight: FontWeight.w700,
          color: palette.textPrimary,
          fontFamilyFallback: [fallbackFontFamily],
        ),
        // ... map all text style tokens
        styleTokens.body: TextStyle(
          height: 1.4, fontSize: 17,
          fontFamily: fontFamily, fontWeight: FontWeight.w400,
          color: palette.textPrimary,
          fontFamilyFallback: [fallbackFontFamily],
        ),
        styleTokens.bodySmall: TextStyle(
          height: 1.4, fontSize: 14,
          fontFamily: fontFamily, fontWeight: FontWeight.w400,
          color: palette.textPrimary,
          fontFamilyFallback: [fallbackFontFamily],
        ),
      }..addAll(textStyleOverrides),
      radii: {
        radiusTokens.thin: const Radius.circular(2),
        radiusTokens.extraSmall: const Radius.circular(4),
        radiusTokens.small: const Radius.circular(8),
        radiusTokens.medium: const Radius.circular(16),
        radiusTokens.large: const Radius.circular(32),
      }..addAll(radiusOverrides),
    );
  }

  /// Bridge from Mix → Material ThemeData
  static ThemeData materialThemeDataFromTheme(
    MixThemeData theme, BuildContext context, Brightness brightness,
  ) {
    final defaultThemeData = Theme.of(context);
    final backgroundColor = context.backgroundPrimaryColor;
    final primaryColor = context.brandPrimaryColor;
    final focusedBorderSide = BorderSide(color: primaryColor, width: 1);
    final focusedBorder = OutlineInputBorder(
      borderSide: focusedBorderSide,
      borderRadius: BorderRadius.all(context.mediumRadius.topLeft),
    );
    return defaultThemeData.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      appBarTheme: AppBarThemeData(
        elevation: 0, scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: context.backgroundSecondaryColor,
        focusedBorder: focusedBorder,
        enabledBorder: focusedBorder.copyWith(
          borderSide: focusedBorderSide.copyWith(
            color: context.backgroundSecondaryColor,
          ),
        ),
        // ... error, disabled borders
      ),
      canvasColor: backgroundColor,
    );
  }
}
```

#### Layer 4: Context extension (token → concrete value)

```dart
part of '../{{project_name}}_ui.dart';

extension {{Project}}ThemeExtension on BuildContext {
  MixThemeData get theme => MixTheme.of(this);

  // Color accessors
  Color get brandPrimaryColor => theme.colors[${{project_name}}Token.color.brandPrimary]!;
  Color get brandPressedColor => theme.colors[${{project_name}}Token.color.brandPressed]!;
  Color get brandTransparentColor => theme.colors[${{project_name}}Token.color.brandTransparent]!;
  Color get textPrimaryColor => theme.colors[${{project_name}}Token.color.textPrimary]!;
  Color get textSecondaryColor => theme.colors[${{project_name}}Token.color.textSecondary]!;
  Color get backgroundPrimaryColor => theme.colors[${{project_name}}Token.color.backgroundPrimary]!;
  Color get backgroundSecondaryColor => theme.colors[${{project_name}}Token.color.backgroundSecondary]!;
  Color get statusDangerColor => theme.colors[${{project_name}}Token.color.statusDanger]!;
  Color get statusSuccessColor => theme.colors[${{project_name}}Token.color.statusSuccess]!;
  // ... all other colors

  // TextStyle accessors
  TextStyle get titleH1TextStyle => theme.textStyles[${{project_name}}Token.textStyle.titleH1]!;
  TextStyle get titleH2TextStyle => theme.textStyles[${{project_name}}Token.textStyle.titleH2]!;
  TextStyle get bodyTextStyle => theme.textStyles[${{project_name}}Token.textStyle.body]!;
  TextStyle get bodyBoldTextStyle => theme.textStyles[${{project_name}}Token.textStyle.bodyBold]!;
  TextStyle get bodySmallTextStyle => theme.textStyles[${{project_name}}Token.textStyle.bodySmall]!;
  // ... all other text styles

  // Radius accessors
  BorderRadius get extraSmallRadius =>
      BorderRadius.circular(theme.radii[${{project_name}}Token.radius.extraSmall]!.x);
  BorderRadius get smallRadius =>
      BorderRadius.circular(theme.radii[${{project_name}}Token.radius.small]!.x);
  BorderRadius get mediumRadius =>
      BorderRadius.circular(theme.radii[${{project_name}}Token.radius.medium]!.x);
  BorderRadius get largeRadius =>
      BorderRadius.circular(theme.radii[${{project_name}}Token.radius.large]!.x);
}
```

**Usage anywhere in the app**: `context.brandPrimaryColor`, `context.bodyTextStyle`, `context.mediumRadius`

#### Layer 5: ThemeProvider widget

```dart
part of '../{{project_name}}_ui.dart';

final class {{Project}}ThemeProvider extends StatelessWidget {
  final Widget child;
  final Brightness brightness;
  final MixThemeData? darkTheme;
  final MixThemeData? lightTheme;

  const {{Project}}ThemeProvider({
    required this.child,
    this.brightness = Brightness.light,
    this.darkTheme,
    this.lightTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLightTheme = lightTheme ?? {{Project}}Themes.fromBrightness(Brightness.light);
    final appDarkTheme = darkTheme ?? {{Project}}Themes.fromBrightness(Brightness.dark);
    return MixTheme(
      data: brightness == Brightness.light ? appLightTheme : appDarkTheme,
      child: child,
    );
  }
}
```

### 8.7 Localization System (Slang)

#### Source files (`lib/localization/sources/strings_en.json`)

```json
{
  "core": {
    "appName": "{{AppDisplayName}}",
    "currency": "QAR"
  },
  "login": {
    "header": "Phone Number",
    "signIn": "Sign In",
    "continueAsGuest": "Continue as Guest",
    "wall": {
      "header": "Welcome Back",
      "description": "Sign in to access your account",
      "tryAnotherNumber": "Try another number?"
    },
    "otp": {
      "header": "Verification Code",
      "description": "We sent a code to your phone",
      "confirm": "Confirm",
      "resend": "Resend code",
      "otpWasVerifiedSuccessfully": "Code verified!",
      "otpWasResentSuccessfully": "New code sent!"
    }
  },
  "home": {
    "location": {
      "doha": "Doha"
    },
    "categories": {
      "label": "Categories"
    },
    "main": {
      "home": "Home",
      "favorites": "Favorites",
      "assistance": "Assistance",
      "cart": "Cart",
      "me": "Me"
    }
  },
  "notifications": {
    "countFormat": {
      "moreThanTen": "10+"
    }
  }
}
```

#### Generate with: `dart run slang`

#### Access anywhere: `t.login.signIn`, `t.home.main.cart`, `t.core.appName`

The `t` accessor is globally available because `strings.g.dart` is exported from the barrel.

### 8.8 Context Extensions (beyond theming)

```dart
part of '../{{project_name}}_ui.dart';

extension ContextExtensions on BuildContext {
  // Locale
  String get languageCode => LocaleSettings.currentLocale.languageCode;
  List<String> get supportedLocales => LocaleSettings.instance.supportedLocalesRaw;

  // Keyboard
  bool get isKeyboardOpened => MediaQuery.viewInsetsOf(this).bottom > 0;

  // Screen size
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
  bool get isTablet => width >= 600;
  bool get isDarkMode => Theme.brightnessOf(this) == Brightness.dark;

  // Locale switching
  void updateLocale([String? languageCode]) async {
    final newCode = languageCode ?? nextLanguageCode;
    await LocaleSettings.instance.setLocaleRaw(newCode);
  }

  // Number localization (Arabic-aware)
  String localizeNumbers(num number, {String pattern = '#'}) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern(
      languageCode == 'ar' ? 'ar_EG' : languageCode,
    );
    return numberFormat.format(number);
  }

  String price(num price) =>
      '${localizeNumbers(price, pattern: '#.##')} ${t.core.currency}';

  // Platform-adaptive bottom sheet
  Future<T?> showBottomSheet<T>({
    required WidgetBuilder builder,
    bool enableDrag = true,
    bool useRootNavigator = true,
    bool isScrollControlled = true,
  }) {
    if ({{Project}}PlatformChecker.isIOS) {
      return showCupertinoSheet<T>(
        context: this,
        enableDrag: enableDrag,
        builder: (context) => CupertinoPopupSurface(
          isSurfacePainted: true,
          child: builder(context),
        ),
      );
    } else {
      return showModalBottomSheet<T>(
        context: this,
        enableDrag: enableDrag,
        useRootNavigator: useRootNavigator,
        isScrollControlled: isScrollControlled,
        builder: builder,
      );
    }
  }

  // Platform-adaptive alert dialog
  Future<T?> showAlertDialog<T>({
    String? title,
    String? content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    if ({{Project}}PlatformChecker.isIOS) {
      return showCupertinoDialog<T>(
        context: this,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: [
            if (cancelText != null) CupertinoDialogAction(
              onPressed: () { Navigator.pop(context); onCancel?.call(); },
              child: Text(cancelText),
            ),
            if (confirmText != null) CupertinoDialogAction(
              onPressed: () { Navigator.pop(context); onConfirm?.call(); },
              child: Text(confirmText),
            ),
          ],
        ),
      );
    } else {
      return showDialog<T>(
        context: this,
        builder: (context) => AlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: [
            if (cancelText != null) TextButton(
              onPressed: () { Navigator.pop(context); onCancel?.call(); },
              child: Text(cancelText),
            ),
            if (confirmText != null) TextButton(
              onPressed: () { Navigator.pop(context); onConfirm?.call(); },
              child: Text(confirmText),
            ),
          ],
        ),
      );
    }
  }
}
```

### 8.9 Widget template (Mix-based button)

```dart
part of '../{{project_name}}_ui.dart';

enum {{Project}}ButtonSize { normal, small }
enum {{Project}}ButtonType { filled, outlined, text }

final class {{Project}}Button extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final bool isDisabled;
  final {{Project}}ButtonSize size;
  final {{Project}}ButtonType type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;

  const {{Project}}Button({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.size = {{Project}}ButtonSize.normal,
    this.type = {{Project}}ButtonType.filled,
    this.prefixIcon,
    this.suffixIcon,
  });

  // Mix Variants for state-based styling
  static const Variant _smallVariant = Variant('small');
  static const Variant _outlinedVariant = Variant('outlined');
  static const Variant _textVariant = Variant('text');
  static const Variant _loadingVariant = Variant('loading');
  static const Variant _disabledVariant = Variant('disabled');

  @override
  Widget build(BuildContext context) {
    final activeVariants = <Variant>[
      if (size == {{Project}}ButtonSize.small) _smallVariant,
      if (type == {{Project}}ButtonType.outlined) _outlinedVariant,
      if (type == {{Project}}ButtonType.text) _textVariant,
      if (isLoading) _loadingVariant,
      if (isDisabled) _disabledVariant,
    ];

    final defaultColor = color ?? context.brandPrimaryColor;
    final defaultTextColor = textColor ?? context.backgroundSecondaryColor;

    return PressableBox(
      onPress: (isDisabled || isLoading || onTap == null) ? null : () {
        SystemSound.play(SystemSoundType.click).ignore();
        onTap!();
      },
      style: Style(
        $box.color(defaultColor),
        $box.alignment.center(),
        $box.height(52),
        $box.borderRadius.circular(context.mediumRadius.topLeft.x),
        $box.padding.vertical(10),
        $box.padding.horizontal(12),
        $text.style.as(context.bodyBoldTextStyle.copyWith(color: defaultTextColor)),
        $on.press($box.color(context.brandPressedColor)),

        _smallVariant(
          $box.height(44),
          $text.style.as(context.bodySmallBoldTextStyle.copyWith(color: defaultTextColor)),
        ),
        _outlinedVariant(
          $box.color(Colors.transparent),
          $box.border(color: defaultColor),
          $text.style.as(context.bodyBoldTextStyle.copyWith(color: textColor)),
        ),
        _loadingVariant(
          $box.color(defaultColor.withValues(alpha: 0.7)),
        ),
        _disabledVariant(
          $box.color(defaultColor.withValues(alpha: 0.5)),
        ),
      ).applyVariants(activeVariants)
       .animate(duration: const Duration(milliseconds: 150)),
      child: isLoading
          ? _LoadingIndicator()
          : StyledText(text),
    );
  }
}
```

**Widget rules**:

- All widgets use `part of` and belong to the single library
- Use Mix's `Style`, `Variant`, `PressableBox`, `StyledText` for variant-based styling
- Access design tokens via `context.brandPrimaryColor`, `context.bodyBoldTextStyle`
- Support `isLoading` and `isDisabled` states as standard parameters
- Use `SystemSound.play(SystemSoundType.click)` for tactile feedback
- Platform-adaptive where needed (iOS: Cupertino, Android: Material)

### 8.10 Asset generation

**FlutterGen** auto-generates `lib/assets/gen/assets.gen.dart` containing:

```dart
// Generated — DO NOT EDIT
class Assets {
  static final svgs = _Svgs();
  static final icons = _Icons();
  static final images = _Images();
}

class _Svgs {
  String get logoColored => 'packages/{{project_name}}_ui/assets/svgs/logo_colored.svg';
  // ...
}

class _Icons {
  String get homeOutlineIcon => 'packages/{{project_name}}_ui/assets/icons/home_outline.svg';
  String get homeFilledIcon => 'packages/{{project_name}}_ui/assets/icons/home_filled.svg';
  // ...
}
```

**Usage**: `Assets.svgs.logoColored`, `Assets.icons.homeOutlineIcon`

SVGs are pre-compiled to binary via `vector_graphics_compiler` transformer in the `flutter:` section of pubspec — zero runtime SVG parsing.

### 8.11 Code generation commands

```makefile
# In {{project_name}}_ui/makefile:

update_localization:
 dart run slang

generate:
 dart run build_runner build --delete-conflicting-outputs

clean_and_get:
 flutter clean && flutter pub get
```

---

## END OF PART 2

Say **"continue"** to receive **Part 3 — Patterns 9 (App Shell), 10 (Feature Modules)**.
