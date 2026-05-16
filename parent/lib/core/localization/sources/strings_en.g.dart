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
	/// final t = Translations.of(context);
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
	late final TranslationsCoreEn core = TranslationsCoreEn.internal(_root);
	late final TranslationsParentEn parent = TranslationsParentEn.internal(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MentorX Student'
	String get appName => 'MentorX Student';

	/// en: 'EGP'
	String get currency => 'EGP';

	/// en: '${amount: num} EGP'
	String price({required num amount}) => '${amount} ${_root.core.currency}';

	Map<String, String> get languages => {
		'en': 'English',
		'ar': 'العربية',
	};
	late final TranslationsCoreInitialLanguageEn initialLanguage = TranslationsCoreInitialLanguageEn.internal(_root);

	/// en: 'Log Out'
	String get logoutSetting => 'Log Out';

	/// en: 'Logout'
	String get logoutConfirmTitle => 'Logout';

	/// en: 'Are you sure you want to logout?'
	String get logoutConfirmDesc => 'Are you sure you want to logout?';

	/// en: 'Preview'
	String get preview => 'Preview';

	/// en: 'Coming Soon'
	String get comingSoon => 'Coming Soon';

	/// en: 'Opening ${url}...'
	String opening({required Object url}) => 'Opening ${url}...';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'View All'
	String get viewAll => 'View All';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Settings'
	String get settingsTitle => 'Settings';

	/// en: 'Edit Profile'
	String get editProfile => 'Edit Profile';

	/// en: 'Student Card'
	String get studentCard => 'Student Card';

	/// en: 'Digital ID'
	String get digitalId => 'Digital ID';

	/// en: 'Personal Data'
	String get personalData => 'Personal Data';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Grade'
	String get grade => 'Grade';

	/// en: 'Center'
	String get center => 'Center';

	/// en: 'School'
	String get school => 'School';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Wallet'
	String get wallet => 'Wallet';

	/// en: 'Send Request'
	String get sendRequest => 'Send Request';

	/// en: 'MentorX Edition Pro'
	String get tEditionPro => 'MentorX Edition Pro';

	/// en: 'MentorX is a comprehensive educational platform designed to empower students and parents with real-time academic tracking and resources.'
	String get aboutDesc => 'MentorX is a comprehensive educational platform designed to empower students and parents with real-time academic tracking and resources.';

	/// en: 'Version ${v}'
	String version({required Object v}) => 'Version ${v}';

	/// en: 'Last Update: ${date}'
	String lastUpdate({required Object date}) => 'Last Update: ${date}';

	/// en: 'Build: ${b}'
	String buildLabel({required Object b}) => 'Build: ${b}';

	/// en: 'All Rights Reserved © 2026 MentorX'
	String get allRightsReserved => 'All Rights Reserved © 2026 MentorX';

	/// en: 'Unable to load devices'
	String get unableToLoadDevices => 'Unable to load devices';

	/// en: 'No registered devices found'
	String get noRegisteredDevices => 'No registered devices found';

	/// en: 'Manage your active sessions and devices. You can deactivate any device you no longer use.'
	String get activeSessionsDesc => 'Manage your active sessions and devices. You can deactivate any device you no longer use.';

	/// en: 'Deactivate Device'
	String get deactivateDevice => 'Deactivate Device';

	/// en: 'Deactivated'
	String get deactivatedLabel => 'Deactivated';

	/// en: 'Active'
	String get activeLabel => 'Active';

	/// en: 'Inactive'
	String get inactiveLabel => 'Inactive';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Change Password'
	String get changePasswordSetting => 'Change Password';

	/// en: 'Device Management'
	String get deviceManagement => 'Device Management';

	/// en: 'Communication'
	String get communication => 'Communication';

	/// en: 'Notifications'
	String get notificationsSetting => 'Notifications';

	/// en: 'WhatsApp Groups'
	String get whatsappGroups => 'WhatsApp Groups';

	/// en: 'Help & Info'
	String get helpAndInfo => 'Help & Info';

	/// en: 'About App'
	String get aboutSetting => 'About App';

	/// en: 'Last used at ${date}'
	String lastUsedAt({required Object date}) => 'Last used at ${date}';

	/// en: 'Excellent'
	String get excellent => 'Excellent';

	/// en: 'Very Good'
	String get veryGood => 'Very Good';

	/// en: 'Needs Work'
	String get fail => 'Needs Work';

	/// en: 'of ${count}'
	String of({required Object count}) => 'of ${count}';
}

// Path: parent
class TranslationsParentEn {
	TranslationsParentEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MentorX Parent'
	String get app_name => 'MentorX Parent';

	/// en: 'Welcome back'
	String get welcome => 'Welcome back';
}

// Path: core.initialLanguage
class TranslationsCoreInitialLanguageEn {
	TranslationsCoreInitialLanguageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select your preferred language'
	String get header => 'Select your preferred language';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'core.appName' => 'MentorX Student',
			'core.currency' => 'EGP',
			'core.price' => ({required num amount}) => '${amount} ${_root.core.currency}',
			'core.languages.en' => 'English',
			'core.languages.ar' => 'العربية',
			'core.initialLanguage.header' => 'Select your preferred language',
			'core.initialLanguage.kContinue' => 'Continue',
			'core.logoutSetting' => 'Log Out',
			'core.logoutConfirmTitle' => 'Logout',
			'core.logoutConfirmDesc' => 'Are you sure you want to logout?',
			'core.preview' => 'Preview',
			'core.comingSoon' => 'Coming Soon',
			'core.opening' => ({required Object url}) => 'Opening ${url}...',
			'core.search' => 'Search',
			'core.viewAll' => 'View All',
			'core.skip' => 'Skip',
			'core.next' => 'Next',
			'core.getStarted' => 'Get Started',
			'core.retry' => 'Retry',
			'core.cancel' => 'Cancel',
			'core.settingsTitle' => 'Settings',
			'core.editProfile' => 'Edit Profile',
			'core.studentCard' => 'Student Card',
			'core.digitalId' => 'Digital ID',
			'core.personalData' => 'Personal Data',
			'core.name' => 'Name',
			'core.phone' => 'Phone',
			'core.grade' => 'Grade',
			'core.center' => 'Center',
			'core.school' => 'School',
			'core.attendance' => 'Attendance',
			'core.wallet' => 'Wallet',
			'core.sendRequest' => 'Send Request',
			'core.tEditionPro' => 'MentorX Edition Pro',
			'core.aboutDesc' => 'MentorX is a comprehensive educational platform designed to empower students and parents with real-time academic tracking and resources.',
			'core.version' => ({required Object v}) => 'Version ${v}',
			'core.lastUpdate' => ({required Object date}) => 'Last Update: ${date}',
			'core.buildLabel' => ({required Object b}) => 'Build: ${b}',
			'core.allRightsReserved' => 'All Rights Reserved © 2026 MentorX',
			'core.unableToLoadDevices' => 'Unable to load devices',
			'core.noRegisteredDevices' => 'No registered devices found',
			'core.activeSessionsDesc' => 'Manage your active sessions and devices. You can deactivate any device you no longer use.',
			'core.deactivateDevice' => 'Deactivate Device',
			'core.deactivatedLabel' => 'Deactivated',
			'core.activeLabel' => 'Active',
			'core.inactiveLabel' => 'Inactive',
			'core.language' => 'Language',
			'core.account' => 'Account',
			'core.changePasswordSetting' => 'Change Password',
			'core.deviceManagement' => 'Device Management',
			'core.communication' => 'Communication',
			'core.notificationsSetting' => 'Notifications',
			'core.whatsappGroups' => 'WhatsApp Groups',
			'core.helpAndInfo' => 'Help & Info',
			'core.aboutSetting' => 'About App',
			'core.lastUsedAt' => ({required Object date}) => 'Last used at ${date}',
			'core.excellent' => 'Excellent',
			'core.veryGood' => 'Very Good',
			'core.fail' => 'Needs Work',
			'core.of' => ({required Object count}) => 'of ${count}',
			'parent.app_name' => 'MentorX Parent',
			'parent.welcome' => 'Welcome back',
			_ => null,
		};
	}
}
