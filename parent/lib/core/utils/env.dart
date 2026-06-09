import 'package:mentorx_core/mentorx_core.dart';

/// Compile-time environment configuration for the Parent app.
///
/// Values come from `--dart-define` / `--dart-define-from-file=.env` so they
/// are constant at run time. To switch the entire app back to Mock during
/// local development, ship a `.env.local` (or use `--dart-define-from-file`)
/// that sets every `*_REPOSITORY_MODE=mock` — see `.env.example`.
///
/// Production defaults:
/// - Every repository defaults to `prod`. This guarantees the app talks to a
///   real backend even when no env file is provided, which is what we want
///   for release builds.
/// - `MENTORX_API_BASE_URL` defaults to the official production backend.
///   Builds can still override it with `--dart-define` for staging or local
///   contract testing.
final class Env {
  Env._();

  // ───────────────────────── Application ──────────────────────────────────
  static const String defaultLanguageCode = String.fromEnvironment(
    'DEFAULT_LANGUAGE_CODE',
    defaultValue: 'ar',
  );

  static const int defaultOtpCodeLength = int.fromEnvironment(
    'DEFAULT_OTP_CODE_LENGTH',
    defaultValue: 6,
  );

  // ───────────────────────── Network ──────────────────────────────────────
  static const String officialApiBaseUrl = 'https://api.foudz.store/';

  static const String mentorXBaseUrl = String.fromEnvironment(
    'MENTORX_API_BASE_URL',
    defaultValue: officialApiBaseUrl,
  );

  static bool get hasMentorXBaseUrl => mentorXBaseUrl.trim().isNotEmpty;

  // ─────────────────── Repository switches (default: prod) ────────────────
  // The Parent app ships every repository in `prod` mode by default so that
  // a vanilla `flutter run` against a configured backend exercises the real
  // network stack. Override per-repository to `mock` via `.env` to develop
  // against fixtures.
  static final RepositoryMode authenticationRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'AUTHENTICATION_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode homeRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'HOME_REPOSITORY_MODE',
      defaultValue: 'prod',
    ),
  );

  static final RepositoryMode childrenRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'CHILDREN_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode financialRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'FINANCIAL_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode courseRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'COURSE_REPOSITORY_MODE',
      defaultValue: 'prod',
    ),
  );

  static final RepositoryMode attendanceRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'ATTENDANCE_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode gradeRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'GRADE_REPOSITORY_MODE',
      defaultValue: 'prod',
    ),
  );

  static final RepositoryMode communicationRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'COMMUNICATION_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode notificationRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'NOTIFICATION_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode profileRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'PROFILE_REPOSITORY_MODE',
      defaultValue: 'prod',
    ),
  );

  static final RepositoryMode analyticsRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'ANALYTICS_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode attendanceGroupsRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'ATTENDANCE_GROUPS_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode devicesRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'DEVICES_REPOSITORY_MODE',
      defaultValue: 'prod',
    ),
  );

  static final RepositoryMode accountStatusRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'ACCOUNT_STATUS_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  static final RepositoryMode accountDeletionRepositoryMode =
      RepositoryMode.fromString(
        const String.fromEnvironment(
          'ACCOUNT_DELETION_REPOSITORY_MODE',
          defaultValue: 'prod',
        ),
      );

  // ──────────────────────── Mock-only knobs ───────────────────────────────
  static const int _mockDelayDurationInSeconds = int.fromEnvironment(
    'MOCK_DELAY_IN_SECONDS',
    defaultValue: 1,
  );

  static Duration get mockDelayDuration =>
      const Duration(seconds: _mockDelayDurationInSeconds);

  static const String mockPhoneNumber = String.fromEnvironment(
    'MOCK_USER_PHONE_NUMBER',
    defaultValue: '01000000000',
  );

  static const String mockOTP = String.fromEnvironment(
    'MOCK_OTP_CODE',
    defaultValue: '123456',
  );

  static const String mockUserName = String.fromEnvironment(
    'MOCK_USER_NAME',
    defaultValue: 'John Doe',
  );

  // ─────────────────────── Convenience getters ────────────────────────────
  /// `true` when at least one repository is in prod mode and therefore the
  /// real `HttpClient` (and `MENTORX_API_BASE_URL`) is required.
  static bool get usesAnyProdRepository =>
      authenticationRepositoryMode == RepositoryMode.prod ||
      homeRepositoryMode == RepositoryMode.prod ||
      childrenRepositoryMode == RepositoryMode.prod ||
      financialRepositoryMode == RepositoryMode.prod ||
      courseRepositoryMode == RepositoryMode.prod ||
      attendanceRepositoryMode == RepositoryMode.prod ||
      gradeRepositoryMode == RepositoryMode.prod ||
      communicationRepositoryMode == RepositoryMode.prod ||
      notificationRepositoryMode == RepositoryMode.prod ||
      profileRepositoryMode == RepositoryMode.prod ||
      analyticsRepositoryMode == RepositoryMode.prod ||
      attendanceGroupsRepositoryMode == RepositoryMode.prod ||
      devicesRepositoryMode == RepositoryMode.prod ||
      accountStatusRepositoryMode == RepositoryMode.prod ||
      accountDeletionRepositoryMode == RepositoryMode.prod;
}
