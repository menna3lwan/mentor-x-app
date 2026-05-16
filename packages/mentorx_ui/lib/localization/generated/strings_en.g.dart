///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t_ui = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsWidgetsEn widgets = TranslationsWidgetsEn._(_root);
	late final TranslationsCoreEn core = TranslationsCoreEn._(_root);
	late final TranslationsParentEn parent = TranslationsParentEn._(_root);
	late final TranslationsFormsEn forms = TranslationsFormsEn._(_root);
	Map<String, dynamic> get exceptions => {
		'unknown': 'Unknown error',
		'AuthenticationRepositoryExceptionCode': TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(_root),
	};
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'View All'
	String get viewAll => 'View All';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Optional'
	String get optional => 'Optional';

	/// en: 'Customization'
	String get customization => 'Customization';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Back to Login'
	String get backToLogin => 'Back to Login';

	/// en: 'No results found'
	String get noResults => 'No results found';

	/// en: 'Opening: ${url}'
	String opening({required Object url}) => 'Opening: ${url}';

	/// en: 'Coming soon'
	String get comingSoon => 'Coming soon';

	/// en: 'Something went wrong'
	String get somethingWentWrong => 'Something went wrong';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Read More'
	String get readMore => 'Read More';

	/// en: 'Read Less'
	String get readLess => 'Read Less';
}

// Path: widgets
class TranslationsWidgetsEn {
	TranslationsWidgetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsWidgetsAnnouncementEn announcement = TranslationsWidgetsAnnouncementEn._(_root);
	late final TranslationsWidgetsAttendanceEn attendance = TranslationsWidgetsAttendanceEn._(_root);
	late final TranslationsWidgetsErrorEn error = TranslationsWidgetsErrorEn._(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'EGP'
	String get currency => 'EGP';
}

// Path: parent
class TranslationsParentEn {
	TranslationsParentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unable to load'
	String get unableToLoad => 'Unable to load';

	/// en: 'Child Wallet Balance'
	String get childWalletBalance => 'Child Wallet Balance';

	/// en: 'Transaction History'
	String get transactionHistory => 'Transaction History';

	/// en: 'Financial Monitor'
	String get financialMonitor => 'Financial Monitor';

	/// en: 'Announcements'
	String get announcements => 'Announcements';

	/// en: 'Overall Average'
	String get overallAverage => 'Overall Average';

	/// en: 'No Data'
	String get noData => 'No Data';

	/// en: 'Enrolled Courses'
	String get enrolledCourses => 'Enrolled Courses';

	/// en: 'Academic Monitor'
	String get academicMonitor => 'Academic Monitor';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Recent Activity'
	String get recentActivity => 'Recent Activity';

	/// en: 'Welcome Back'
	String get welcomeBack => 'Welcome Back';

	/// en: 'Account Info'
	String get accountInfo => 'Account Info';

	/// en: 'App Settings'
	String get appSettings => 'App Settings';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Sign Out'
	String get signOut => 'Sign Out';

	/// en: 'My Profile'
	String get myProfile => 'My Profile';
}

// Path: forms
class TranslationsFormsEn {
	TranslationsFormsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This field is required'
	String get required => 'This field is required';

	/// en: 'It must be ${length: int} letters long at least'
	String minLength({required int length}) => 'It must be ${length} letters long at least';

	/// en: 'The maximum limit is ${length: int} letters'
	String maxLength({required int length}) => 'The maximum limit is ${length} letters';

	/// en: 'It must be ${length: int} digits long at least'
	String minDigitsLength({required int length}) => 'It must be ${length} digits long at least';

	/// en: 'The maximum limit is ${length: int} digits'
	String maxDigitsLength({required int length}) => 'The maximum limit is ${length} digits';

	/// en: 'You must enter a valid email'
	String get youMustEnterAValidEmail => 'You must enter a valid email';
}

// Path: exceptions.AuthenticationRepositoryExceptionCode
class TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn {
	TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unknown error'
	String get unknown => 'Unknown error';

	/// en: 'Invalid phone number'
	String get invalidPhoneNumber => 'Invalid phone number';

	/// en: 'Invalid OTP'
	String get invalidOTP => 'Invalid OTP';

	/// en: 'Failed to initialize'
	String get failedToInitialize => 'Failed to initialize';

	/// en: 'Failed to send OTP'
	String get failedToSendOtp => 'Failed to send OTP';

	/// en: 'Failed to verify OTP'
	String get failedToVerifyOtp => 'Failed to verify OTP';
}

// Path: widgets.announcement
class TranslationsWidgetsAnnouncementEn {
	TranslationsWidgetsAnnouncementEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PINNED'
	String get pinned => 'PINNED';

	/// en: 'UPDATE'
	String get update => 'UPDATE';
}

// Path: widgets.attendance
class TranslationsWidgetsAttendanceEn {
	TranslationsWidgetsAttendanceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Attendance Rate'
	String get rate => 'Attendance Rate';
}

// Path: widgets.error
class TranslationsWidgetsErrorEn {
	TranslationsWidgetsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong'
	String get title => 'Something went wrong';

	/// en: 'Retry'
	String get retry => 'Retry';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.cancel' => 'Cancel',
			'common.ok' => 'OK',
			'common.viewAll' => 'View All',
			'common.required' => 'Required',
			'common.optional' => 'Optional',
			'common.customization' => 'Customization',
			'common.skip' => 'Skip',
			'common.next' => 'Next',
			'common.getStarted' => 'Get Started',
			'common.backToLogin' => 'Back to Login',
			'common.noResults' => 'No results found',
			'common.opening' => ({required Object url}) => 'Opening: ${url}',
			'common.comingSoon' => 'Coming soon',
			'common.somethingWentWrong' => 'Something went wrong',
			'common.retry' => 'Retry',
			'common.readMore' => 'Read More',
			'common.readLess' => 'Read Less',
			'widgets.announcement.pinned' => 'PINNED',
			'widgets.announcement.update' => 'UPDATE',
			'widgets.attendance.rate' => 'Attendance Rate',
			'widgets.error.title' => 'Something went wrong',
			'widgets.error.retry' => 'Retry',
			'core.currency' => 'EGP',
			'parent.unableToLoad' => 'Unable to load',
			'parent.childWalletBalance' => 'Child Wallet Balance',
			'parent.transactionHistory' => 'Transaction History',
			'parent.financialMonitor' => 'Financial Monitor',
			'parent.announcements' => 'Announcements',
			'parent.overallAverage' => 'Overall Average',
			'parent.noData' => 'No Data',
			'parent.enrolledCourses' => 'Enrolled Courses',
			'parent.academicMonitor' => 'Academic Monitor',
			'parent.services' => 'Services',
			'parent.recentActivity' => 'Recent Activity',
			'parent.welcomeBack' => 'Welcome Back',
			'parent.accountInfo' => 'Account Info',
			'parent.appSettings' => 'App Settings',
			'parent.notifications' => 'Notifications',
			'parent.security' => 'Security',
			'parent.signOut' => 'Sign Out',
			'parent.myProfile' => 'My Profile',
			'forms.required' => 'This field is required',
			'forms.minLength' => ({required int length}) => 'It must be ${length} letters long at least',
			'forms.maxLength' => ({required int length}) => 'The maximum limit is ${length} letters',
			'forms.minDigitsLength' => ({required int length}) => 'It must be ${length} digits long at least',
			'forms.maxDigitsLength' => ({required int length}) => 'The maximum limit is ${length} digits',
			'forms.youMustEnterAValidEmail' => 'You must enter a valid email',
			'exceptions.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'Invalid phone number',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'Invalid OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'Failed to initialize',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'Failed to send OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'Failed to verify OTP',
			_ => null,
		};
	}
}
