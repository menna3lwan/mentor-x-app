///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
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
	late final TranslationsUiEn ui = TranslationsUiEn._(_root);
	late final TranslationsCoreEn core = TranslationsCoreEn._(_root);
	late final TranslationsInitialLanguageEn initialLanguage = TranslationsInitialLanguageEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsFormsEn forms = TranslationsFormsEn._(_root);
	Map<String, dynamic> get exceptions => {
		'unknown': 'Unknown error',
		'AuthenticationRepositoryExceptionCode': TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(_root),
		'promocodeExceptions': TranslationsExceptionsPromocodeExceptionsEn._(_root),
	};
	Map<String, String> get countries => {
		'afghanistan': 'Afghanistan',
		'albania': 'Albania',
		'algeria': 'Algeria',
		'andorra': 'Andorra',
		'angola': 'Angola',
		'antiguaAndBarbuda': 'Antigua and Barbuda',
		'argentina': 'Argentina',
		'armenia': 'Armenia',
		'australia': 'Australia',
		'austria': 'Austria',
		'azerbaijan': 'Azerbaijan',
		'bahamas': 'Bahamas',
		'bahrain': 'Bahrain',
		'bangladesh': 'Bangladesh',
		'barbados': 'Barbados',
		'belarus': 'Belarus',
		'belgium': 'Belgium',
		'belize': 'Belize',
		'benin': 'Benin',
		'bhutan': 'Bhutan',
		'bolivia': 'Bolivia',
		'bosniaAndHerzegovina': 'Bosnia and Herzegovina',
		'botswana': 'Botswana',
		'brazil': 'Brazil',
		'brunei': 'Brunei',
		'bulgaria': 'Bulgaria',
		'burkinaFaso': 'Burkina Faso',
		'burundi': 'Burundi',
		'cambodia': 'Cambodia',
		'cameroon': 'Cameroon',
		'canada': 'Canada',
		'capeVerde': 'Cape Verde',
		'centralAfricanRepublic': 'Central African Republic',
		'chad': 'Chad',
		'chile': 'Chile',
		'china': 'China',
		'colombia': 'Colombia',
		'comoros': 'Comoros',
		'congo': 'Congo',
		'democraticRepublicOfCongo': 'Democratic Republic of the Congo',
		'costaRica': 'Costa Rica',
		'croatia': 'Croatia',
		'cuba': 'Cuba',
		'cyprus': 'Cyprus',
		'czechRepublic': 'Czech Republic',
		'denmark': 'Denmark',
		'djibouti': 'Djibouti',
		'dominica': 'Dominica',
		'dominicanRepublic': 'Dominican Republic',
		'ecuador': 'Ecuador',
		'egypt': 'Egypt',
		'elSalvador': 'El Salvador',
		'equatorialGuinea': 'Equatorial Guinea',
		'eritrea': 'Eritrea',
		'estonia': 'Estonia',
		'eswatini': 'Eswatini',
		'ethiopia': 'Ethiopia',
		'fiji': 'Fiji',
		'finland': 'Finland',
		'france': 'France',
		'gabon': 'Gabon',
		'gambia': 'Gambia',
		'georgia': 'Georgia',
		'germany': 'Germany',
		'ghana': 'Ghana',
		'greece': 'Greece',
		'grenada': 'Grenada',
		'guatemala': 'Guatemala',
		'guinea': 'Guinea',
		'guineaBissau': 'Guinea-Bissau',
		'guyana': 'Guyana',
		'haiti': 'Haiti',
		'honduras': 'Honduras',
		'hungary': 'Hungary',
		'iceland': 'Iceland',
		'india': 'India',
		'indonesia': 'Indonesia',
		'iran': 'Iran',
		'iraq': 'Iraq',
		'ireland': 'Ireland',
		'israel': 'Israel',
		'italy': 'Italy',
		'ivoryCoast': 'Ivory Coast',
		'jamaica': 'Jamaica',
		'japan': 'Japan',
		'jordan': 'Jordan',
		'kazakhstan': 'Kazakhstan',
		'kenya': 'Kenya',
		'kiribati': 'Kiribati',
		'kuwait': 'Kuwait',
		'kyrgyzstan': 'Kyrgyzstan',
		'laos': 'Laos',
		'latvia': 'Latvia',
		'lebanon': 'Lebanon',
		'lesotho': 'Lesotho',
		'liberia': 'Liberia',
		'libya': 'Libya',
		'liechtenstein': 'Liechtenstein',
		'lithuania': 'Lithuania',
		'luxembourg': 'Luxembourg',
		'madagascar': 'Madagascar',
		'malawi': 'Malawi',
		'malaysia': 'Malaysia',
		'maldives': 'Maldives',
		'mali': 'Mali',
		'malta': 'Malta',
		'marshallIslands': 'Marshall Islands',
		'mauritania': 'Mauritania',
		'mauritius': 'Mauritius',
		'mexico': 'Mexico',
		'micronesia': 'Micronesia',
		'moldova': 'Moldova',
		'monaco': 'Monaco',
		'mongolia': 'Mongolia',
		'montenegro': 'Montenegro',
		'morocco': 'Morocco',
		'mozambique': 'Mozambique',
		'myanmar': 'Myanmar',
		'namibia': 'Namibia',
		'nauru': 'Nauru',
		'nepal': 'Nepal',
		'netherlands': 'Netherlands',
		'newZealand': 'New Zealand',
		'nicaragua': 'Nicaragua',
		'niger': 'Niger',
		'nigeria': 'Nigeria',
		'northKorea': 'North Korea',
		'northMacedonia': 'North Macedonia',
		'norway': 'Norway',
		'oman': 'Oman',
		'pakistan': 'Pakistan',
		'palau': 'Palau',
		'palestine': 'Palestine',
		'panama': 'Panama',
		'papuaNewGuinea': 'Papua New Guinea',
		'paraguay': 'Paraguay',
		'peru': 'Peru',
		'philippines': 'Philippines',
		'poland': 'Poland',
		'portugal': 'Portugal',
		'qatar': 'Qatar',
		'romania': 'Romania',
		'russia': 'Russia',
		'rwanda': 'Rwanda',
		'saintKittsAndNevis': 'Saint Kitts and Nevis',
		'saintLucia': 'Saint Lucia',
		'saintVincentAndTheGrenadines': 'Saint Vincent and the Grenadines',
		'samoa': 'Samoa',
		'sanMarino': 'San Marino',
		'saoTomeAndPrincipe': 'Sao Tome and Principe',
		'saudiArabia': 'Saudi Arabia',
		'senegal': 'Senegal',
		'serbia': 'Serbia',
		'seychelles': 'Seychelles',
		'sierraLeone': 'Sierra Leone',
		'singapore': 'Singapore',
		'slovakia': 'Slovakia',
		'slovenia': 'Slovenia',
		'solomonIslands': 'Solomon Islands',
		'somalia': 'Somalia',
		'southAfrica': 'South Africa',
		'southKorea': 'South Korea',
		'southSudan': 'South Sudan',
		'spain': 'Spain',
		'sriLanka': 'Sri Lanka',
		'sudan': 'Sudan',
		'suriname': 'Suriname',
		'sweden': 'Sweden',
		'switzerland': 'Switzerland',
		'syria': 'Syria',
		'taiwan': 'Taiwan',
		'tajikistan': 'Tajikistan',
		'tanzania': 'Tanzania',
		'thailand': 'Thailand',
		'timor': 'Timor-Leste',
		'togo': 'Togo',
		'tonga': 'Tonga',
		'trinidadAndTobago': 'Trinidad and Tobago',
		'tunisia': 'Tunisia',
		'turkey': 'Turkey',
		'turkmenistan': 'Turkmenistan',
		'tuvalu': 'Tuvalu',
		'uganda': 'Uganda',
		'ukraine': 'Ukraine',
		'unitedArabEmirates': 'United Arab Emirates',
		'unitedKingdom': 'United Kingdom',
		'unitedStates': 'United States',
		'uruguay': 'Uruguay',
		'uzbekistan': 'Uzbekistan',
		'vanuatu': 'Vanuatu',
		'vaticanCity': 'Vatican City',
		'venezuela': 'Venezuela',
		'vietnam': 'Vietnam',
		'yemen': 'Yemen',
		'zambia': 'Zambia',
		'zimbabwe': 'Zimbabwe',
	};
	late final TranslationsAccountStatusEn accountStatus = TranslationsAccountStatusEn._(_root);
	late final TranslationsCartEn cart = TranslationsCartEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
}

// Path: ui
class TranslationsUiEn {
	TranslationsUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsUiCommonEn common = TranslationsUiCommonEn._(_root);
	late final TranslationsUiErrorsEn errors = TranslationsUiErrorsEn._(_root);
	late final TranslationsUiDateTimeEn dateTime = TranslationsUiDateTimeEn._(_root);
	late final TranslationsUiMentorXReadMoreEn mentorXReadMore = TranslationsUiMentorXReadMoreEn._(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn._(this._root);

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
}

// Path: initialLanguage
class TranslationsInitialLanguageEn {
	TranslationsInitialLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select your preferred language'
	String get header => 'Select your preferred language';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter your phone number to sign in'
	String get header => 'Enter your phone number to sign in';

	/// en: 'We will send you a verification code'
	String get subtitle => 'We will send you a verification code';

	/// en: 'Phone Number'
	String get phoneNumber => 'Phone Number';

	/// en: '01XXXXXXXXX'
	String get phoneHint => '01XXXXXXXXX';

	/// en: 'Please enter a valid phone number'
	String get phoneValidationError => 'Please enter a valid phone number';

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	late final TranslationsLoginOtpEn otp = TranslationsLoginOtpEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeMainEn main = TranslationsHomeMainEn._(_root);
	late final TranslationsHomeDashboardEn dashboard = TranslationsHomeDashboardEn._(_root);
	late final TranslationsHomeErrorsEn errors = TranslationsHomeErrorsEn._(_root);
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

	late final TranslationsFormsCardEn card = TranslationsFormsCardEn._(_root);
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

// Path: exceptions.promocodeExceptions
class TranslationsExceptionsPromocodeExceptionsEn {
	TranslationsExceptionsPromocodeExceptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Promocode cannot be applied to your cart'
	String get cantBeApplied => 'Promocode cannot be applied to your cart';
}

// Path: accountStatus
class TranslationsAccountStatusEn {
	TranslationsAccountStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account Under Review'
	String get pendingTitle => 'Account Under Review';

	/// en: 'Your account is currently being reviewed. We will notify you once approved.'
	String get pendingDescription => 'Your account is currently being reviewed. We will notify you once approved.';

	/// en: 'If you have questions, please contact support.'
	String get pendingSupportInfo => 'If you have questions, please contact support.';

	/// en: 'Account Rejected'
	String get rejectedTitle => 'Account Rejected';

	/// en: 'Unfortunately, your account application has been rejected.'
	String get rejectedDescription => 'Unfortunately, your account application has been rejected.';

	/// en: 'Please contact support for more information about the reason.'
	String get rejectedReason => 'Please contact support for more information about the reason.';

	/// en: 'Account Blocked'
	String get blockedTitle => 'Account Blocked';

	/// en: 'Your account has been blocked. Please contact support for assistance.'
	String get blockedDescription => 'Your account has been blocked. Please contact support for assistance.';

	/// en: 'If you believe this is an error, please reach out to our support team.'
	String get blockedSupportInfo => 'If you believe this is an error, please reach out to our support team.';
}

// Path: cart
class TranslationsCartEn {
	TranslationsCartEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Cart'
	String get yourCart => 'Your Cart';

	/// en: 'Cart is Empty'
	String get emptyCart => 'Cart is Empty';

	/// en: 'Browse Services'
	String get browseServices => 'Browse Services';

	/// en: 'Browse our offerings to add items to your cart'
	String get browseOfferings => 'Browse our offerings \nto add items to your cart';

	/// en: 'We recommend'
	String get weRecommend => 'We recommend';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Add to Cart'
	String get addToCart => 'Add to Cart';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Don't forget to add'
	String get dontForgetToAdd => 'Don\'t forget to add';

	/// en: '${date: DateFormat('MMM dd, hh:mm')}'
	String itemDateTime({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'en').format(date)}';

	/// en: '(one) {service} (other) {services}'
	String services({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'service',
		other: 'services',
	);

	/// en: 'Total'
	String get total => 'Total';

	/// en: '(zero) {hour} (one) {hour} (other) {hours}'
	String hour({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'hour',
		one: 'hour',
		other: 'hours',
	);

	late final TranslationsCartPromocodeEn promocode = TranslationsCartPromocodeEn._(_root);

	/// en: 'Update in Cart'
	String get updateInCart => 'Update in Cart';

	/// en: 'cart'
	String get cart => 'cart';

	/// en: 'Checkout'
	String get checkout => 'Checkout';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Apply Promocode'
	String get applyPromocode => 'Apply Promocode';

	/// en: 'Enter promocode'
	String get enterPromocode => 'Enter promocode';

	/// en: 'Promocode is required'
	String get promocodeRequired => 'Promocode is required';

	/// en: 'Applied Promocodes'
	String get appliedPromocodes => 'Applied Promocodes';

	/// en: 'Recommendations'
	String get recommendations => 'Recommendations';

	/// en: 'Subtotal'
	String get subtotal => 'Subtotal';

	/// en: 'Discount'
	String get discount => 'Discount';

	/// en: 'Min order'
	String get minOrder => 'Min order';

	/// en: 'Min time'
	String get minTime => 'Min time';

	/// en: 'Space required'
	String get spaceRequired => 'Space required';

	/// en: 'Hours'
	String get hours => 'Hours';

	/// en: 'Special requests'
	String get specialRequests => 'Special requests';

	/// en: 'Enter special requests...'
	String get enterSpecialRequests => 'Enter special requests...';

	/// en: 'Error loading cart'
	String get errorLoadingCart => 'Error loading cart';

	/// en: 'Cart cleared successfully'
	String get cartCleared => 'Cart cleared successfully';

	/// en: 'Failed to load service'
	String get failedToLoadService => 'Failed to load service';

	/// en: 'Please select a ${sectionName}'
	String pleaseSelectOption({required Object sectionName}) => 'Please select a ${sectionName}';

	/// en: 'Please select at least one ${sectionName} option'
	String pleaseSelectAtLeastOne({required Object sectionName}) => 'Please select at least one ${sectionName} option';

	/// en: 'Please select more ${sectionName} options'
	String pleaseSelectMore({required Object sectionName}) => 'Please select more ${sectionName} options';

	/// en: 'Too many ${sectionName} options selected'
	String tooManyOptionsSelected({required Object sectionName}) => 'Too many ${sectionName} options selected';

	/// en: 'Please add at least one ${sectionName} item'
	String pleaseAddAtLeastOne({required Object sectionName}) => 'Please add at least one ${sectionName} item';

	/// en: 'Please select a date and time'
	String get pleaseSelectDateTime => 'Please select a date and time';

	/// en: 'Canapé Options'
	String get canapeOptions => 'Canapé Options';

	/// en: 'Options'
	String get options => 'Options';

	/// en: 'Start date and time'
	String get startDateAndTime => 'Start date and time';

	/// en: 'per extra hour'
	String get perExtraHour => 'per extra hour';

	/// en: 'Go to ${vendorName} profile'
	String goToVendorProfile({required Object vendorName}) => 'Go to ${vendorName} profile';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Settings'
	String get title => 'App Settings';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	late final TranslationsSettingsNotificationSettingsEn notificationSettings = TranslationsSettingsNotificationSettingsEn._(_root);
}

// Path: ui.common
class TranslationsUiCommonEn {
	TranslationsUiCommonEn._(this._root);

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
}

// Path: ui.errors
class TranslationsUiErrorsEn {
	TranslationsUiErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong'
	String get somethingWentWrong => 'Something went wrong';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: ui.dateTime
class TranslationsUiDateTimeEn {
	TranslationsUiDateTimeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Now'
	String get now => 'Now';

	/// en: 'Tomorrow'
	String get tomorrow => 'Tomorrow';

	/// en: '${time: DateFormat('HH:mm')}'
	String time({required DateTime time}) => '${DateFormat('HH:mm', 'en').format(time)}';

	/// en: '${time: DateFormat('HH:mm')}, ${day}'
	String timeWithDay({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'en').format(time)}, ${day}';

	/// en: '${date: DateFormat('MMM d')}'
	String dateWithMonth({required DateTime date}) => '${DateFormat('MMM d', 'en').format(date)}';

	Map<String, String> get weekdays => {
		'monday': 'Mon',
		'tuesday': 'Tue',
		'wednesday': 'Wed',
		'thursday': 'Thu',
		'friday': 'Fri',
		'saturday': 'Sat',
		'sunday': 'Sun',
	};
}

// Path: ui.mentorXReadMore
class TranslationsUiMentorXReadMoreEn {
	TranslationsUiMentorXReadMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'More'
	String get more => 'More';

	/// en: 'Less'
	String get less => 'Less';
}

// Path: login.otp
class TranslationsLoginOtpEn {
	TranslationsLoginOtpEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirmation code'
	String get header => 'Confirmation code';

	/// en: 'We sent a code to your device. Enter it here to continue.'
	String get description => 'We sent a code to your device. Enter it here to continue.';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'OTP was verified successfully'
	String get otpWasVerifiedSuccessfully => 'OTP was verified successfully';

	/// en: 'Resend'
	String get resend => 'Resend';

	/// en: 'Resend in'
	String get resendIn => 'Resend in';

	/// en: 'Edit Number'
	String get editNumber => 'Edit Number';

	/// en: 'OTP was resent successfully'
	String get otpWasResentSuccessfully => 'OTP was resent successfully';
}

// Path: home.main
class TranslationsHomeMainEn {
	TranslationsHomeMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Assistance'
	String get assistance => 'Assistance';

	/// en: 'Cart'
	String get cart => 'Cart';

	/// en: 'Me'
	String get me => 'Me';
}

// Path: home.dashboard
class TranslationsHomeDashboardEn {
	TranslationsHomeDashboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Good morning'
	String get greetingMorning => 'Good morning';

	/// en: 'Good evening'
	String get greetingEvening => 'Good evening';

	/// en: '${greeting}, ${name} 👋'
	String greetingWithName({required Object greeting, required Object name}) => '${greeting}, ${name} 👋';

	/// en: 'Updated ${time: DateFormat('HH:mm')}'
	String updatedAt({required DateTime time}) => 'Updated ${DateFormat('HH:mm', 'en').format(time)}';

	/// en: 'Continue Learning'
	String get continueLearning => 'Continue Learning';

	/// en: 'Featured Courses'
	String get featuredCourses => 'Featured Courses';

	/// en: 'Announcements'
	String get announcements => 'Announcements';

	/// en: 'Quick Actions'
	String get quickActions => 'Quick Actions';

	/// en: 'Wallet Balance'
	String get walletBalance => 'Wallet Balance';

	/// en: '${count: int} points'
	String points({required int count}) => '${count} points';

	/// en: 'Start your learning journey! Browse available courses.'
	String get startLearningJourney => 'Start your learning journey! Browse available courses.';

	/// en: 'Continue ${progress: num}%'
	String continueProgress({required num progress}) => 'Continue ${progress}%';

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'Loading course'
	String get loadingCourse => 'Loading course';

	/// en: 'Loading featured course'
	String get loadingFeaturedCourse => 'Loading featured course';

	/// en: 'Loading announcement'
	String get loadingAnnouncement => 'Loading announcement';

	/// en: 'Loading announcement details'
	String get loadingAnnouncementDetails => 'Loading announcement details';

	/// en: 'Unable to load. Tap to retry.'
	String get unableToLoadTapRetry => 'Unable to load. Tap to retry.';

	late final TranslationsHomeDashboardActionsEn actions = TranslationsHomeDashboardActionsEn._(_root);
}

// Path: home.errors
class TranslationsHomeErrorsEn {
	TranslationsHomeErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load upcoming events'
	String get failedToLoadUpcomingEvents => 'Failed to load upcoming events';

	/// en: 'Failed to load service providers'
	String get failedToLoadVendors => 'Failed to load service providers';

	/// en: 'Failed to load occasions'
	String get failedToLoadOccasions => 'Failed to load occasions';

	/// en: 'Failed to load categories'
	String get failedToLoadCategories => 'Failed to load categories';
}

// Path: forms.card
class TranslationsFormsCardEn {
	TranslationsFormsCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid format. Use MM/YY'
	String get expiryInvalidFormat => 'Invalid format. Use MM/YY';

	/// en: 'Invalid month (01-12)'
	String get expiryInvalidMonth => 'Invalid month (01-12)';

	/// en: 'Card has expired'
	String get expiryCardExpired => 'Card has expired';

	/// en: 'CVV must be 3-4 digits'
	String get cvvInvalid => 'CVV must be 3-4 digits';
}

// Path: cart.promocode
class TranslationsCartPromocodeEn {
	TranslationsCartPromocodeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Promocode'
	String get header => 'Promocode';

	/// en: 'Enter a Promocode'
	String get hint => 'Enter a Promocode';

	/// en: 'Promocode applied'
	String get promocodeApplied => 'Promocode applied';

	/// en: 'Promocode cannot be applied to your cart'
	String get promocodeCannotBeApplied => 'Promocode cannot be applied to your cart';
}

// Path: settings.notificationSettings
class TranslationsSettingsNotificationSettingsEn {
	TranslationsSettingsNotificationSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Common'
	String get common => 'Common';

	/// en: 'General Notification'
	String get generalNotification => 'General Notification';

	/// en: 'Sound'
	String get sound => 'Sound';

	/// en: 'Vibrate'
	String get vibrate => 'Vibrate';

	/// en: 'System & Services Update'
	String get systemAndServicesUpdate => 'System & Services Update';

	/// en: 'App Updates'
	String get appUpdates => 'App Updates';

	/// en: 'Bill Reminder'
	String get billReminder => 'Bill Reminder';

	/// en: 'Promotion'
	String get promotion => 'Promotion';

	/// en: 'Discount Available'
	String get discountAvailable => 'Discount Available';

	/// en: 'Payment Request'
	String get paymentRequest => 'Payment Request';
}

// Path: home.dashboard.actions
class TranslationsHomeDashboardActionsEn {
	TranslationsHomeDashboardActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Courses'
	String get myCourses => 'My Courses';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Grades'
	String get grades => 'Grades';

	/// en: 'AI Assistant'
	String get aiAssistant => 'AI Assistant';

	/// en: 'Rewards'
	String get rewards => 'Rewards';

	/// en: 'Marketplace'
	String get marketplace => 'Marketplace';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		switch (path) {
			case 'ui.common.cancel': return 'Cancel';
			case 'ui.common.ok': return 'OK';
			case 'ui.common.viewAll': return 'View All';
			case 'ui.common.required': return 'Required';
			case 'ui.common.optional': return 'Optional';
			case 'ui.common.customization': return 'Customization';
			case 'ui.common.skip': return 'Skip';
			case 'ui.common.next': return 'Next';
			case 'ui.common.getStarted': return 'Get Started';
			case 'ui.common.backToLogin': return 'Back to Login';
			case 'ui.errors.somethingWentWrong': return 'Something went wrong';
			case 'ui.errors.retry': return 'Retry';
			case 'ui.dateTime.yesterday': return 'Yesterday';
			case 'ui.dateTime.today': return 'Today';
			case 'ui.dateTime.now': return 'Now';
			case 'ui.dateTime.tomorrow': return 'Tomorrow';
			case 'ui.dateTime.time': return ({required DateTime time}) => '${DateFormat('HH:mm', 'en').format(time)}';
			case 'ui.dateTime.timeWithDay': return ({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'en').format(time)}, ${day}';
			case 'ui.dateTime.dateWithMonth': return ({required DateTime date}) => '${DateFormat('MMM d', 'en').format(date)}';
			case 'ui.dateTime.weekdays.monday': return 'Mon';
			case 'ui.dateTime.weekdays.tuesday': return 'Tue';
			case 'ui.dateTime.weekdays.wednesday': return 'Wed';
			case 'ui.dateTime.weekdays.thursday': return 'Thu';
			case 'ui.dateTime.weekdays.friday': return 'Fri';
			case 'ui.dateTime.weekdays.saturday': return 'Sat';
			case 'ui.dateTime.weekdays.sunday': return 'Sun';
			case 'ui.mentorXReadMore.more': return 'More';
			case 'ui.mentorXReadMore.less': return 'Less';
			case 'core.appName': return 'MentorX Student';
			case 'core.currency': return 'EGP';
			case 'core.price': return ({required num amount}) => '${amount} ${_root.core.currency}';
			case 'core.languages.en': return 'English';
			case 'core.languages.ar': return 'العربية';
			case 'initialLanguage.header': return 'Select your preferred language';
			case 'initialLanguage.kContinue': return 'Continue';
			case 'login.header': return 'Enter your phone number to sign in';
			case 'login.subtitle': return 'We will send you a verification code';
			case 'login.phoneNumber': return 'Phone Number';
			case 'login.phoneHint': return '01XXXXXXXXX';
			case 'login.phoneValidationError': return 'Please enter a valid phone number';
			case 'login.signIn': return 'Sign In';
			case 'login.otp.header': return 'Confirmation code';
			case 'login.otp.description': return 'We sent a code to your device. Enter it here to continue.';
			case 'login.otp.confirm': return 'Confirm';
			case 'login.otp.otpWasVerifiedSuccessfully': return 'OTP was verified successfully';
			case 'login.otp.resend': return 'Resend';
			case 'login.otp.resendIn': return 'Resend in';
			case 'login.otp.editNumber': return 'Edit Number';
			case 'login.otp.otpWasResentSuccessfully': return 'OTP was resent successfully';
			case 'home.main.home': return 'Home';
			case 'home.main.favorites': return 'Favorites';
			case 'home.main.assistance': return 'Assistance';
			case 'home.main.cart': return 'Cart';
			case 'home.main.me': return 'Me';
			case 'home.dashboard.greetingMorning': return 'Good morning';
			case 'home.dashboard.greetingEvening': return 'Good evening';
			case 'home.dashboard.greetingWithName': return ({required Object greeting, required Object name}) => '${greeting}, ${name} 👋';
			case 'home.dashboard.updatedAt': return ({required DateTime time}) => 'Updated ${DateFormat('HH:mm', 'en').format(time)}';
			case 'home.dashboard.continueLearning': return 'Continue Learning';
			case 'home.dashboard.featuredCourses': return 'Featured Courses';
			case 'home.dashboard.announcements': return 'Announcements';
			case 'home.dashboard.quickActions': return 'Quick Actions';
			case 'home.dashboard.walletBalance': return 'Wallet Balance';
			case 'home.dashboard.points': return ({required int count}) => '${count} points';
			case 'home.dashboard.startLearningJourney': return 'Start your learning journey! Browse available courses.';
			case 'home.dashboard.continueProgress': return ({required num progress}) => 'Continue ${progress}%';
			case 'home.dashboard.free': return 'Free';
			case 'home.dashboard.loadingCourse': return 'Loading course';
			case 'home.dashboard.loadingFeaturedCourse': return 'Loading featured course';
			case 'home.dashboard.loadingAnnouncement': return 'Loading announcement';
			case 'home.dashboard.loadingAnnouncementDetails': return 'Loading announcement details';
			case 'home.dashboard.unableToLoadTapRetry': return 'Unable to load. Tap to retry.';
			case 'home.dashboard.actions.myCourses': return 'My Courses';
			case 'home.dashboard.actions.attendance': return 'Attendance';
			case 'home.dashboard.actions.grades': return 'Grades';
			case 'home.dashboard.actions.aiAssistant': return 'AI Assistant';
			case 'home.dashboard.actions.rewards': return 'Rewards';
			case 'home.dashboard.actions.marketplace': return 'Marketplace';
			case 'home.errors.failedToLoadUpcomingEvents': return 'Failed to load upcoming events';
			case 'home.errors.failedToLoadVendors': return 'Failed to load service providers';
			case 'home.errors.failedToLoadOccasions': return 'Failed to load occasions';
			case 'home.errors.failedToLoadCategories': return 'Failed to load categories';
			case 'forms.required': return 'This field is required';
			case 'forms.minLength': return ({required int length}) => 'It must be ${length} letters long at least';
			case 'forms.maxLength': return ({required int length}) => 'The maximum limit is ${length} letters';
			case 'forms.minDigitsLength': return ({required int length}) => 'It must be ${length} digits long at least';
			case 'forms.maxDigitsLength': return ({required int length}) => 'The maximum limit is ${length} digits';
			case 'forms.youMustEnterAValidEmail': return 'You must enter a valid email';
			case 'forms.card.expiryInvalidFormat': return 'Invalid format. Use MM/YY';
			case 'forms.card.expiryInvalidMonth': return 'Invalid month (01-12)';
			case 'forms.card.expiryCardExpired': return 'Card has expired';
			case 'forms.card.cvvInvalid': return 'CVV must be 3-4 digits';
			case 'exceptions.unknown': return 'Unknown error';
			case 'exceptions.AuthenticationRepositoryExceptionCode.unknown': return 'Unknown error';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber': return 'Invalid phone number';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP': return 'Invalid OTP';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize': return 'Failed to initialize';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp': return 'Failed to send OTP';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp': return 'Failed to verify OTP';
			case 'exceptions.promocodeExceptions.cantBeApplied': return 'Promocode cannot be applied to your cart';
			case 'countries.afghanistan': return 'Afghanistan';
			case 'countries.albania': return 'Albania';
			case 'countries.algeria': return 'Algeria';
			case 'countries.andorra': return 'Andorra';
			case 'countries.angola': return 'Angola';
			case 'countries.antiguaAndBarbuda': return 'Antigua and Barbuda';
			case 'countries.argentina': return 'Argentina';
			case 'countries.armenia': return 'Armenia';
			case 'countries.australia': return 'Australia';
			case 'countries.austria': return 'Austria';
			case 'countries.azerbaijan': return 'Azerbaijan';
			case 'countries.bahamas': return 'Bahamas';
			case 'countries.bahrain': return 'Bahrain';
			case 'countries.bangladesh': return 'Bangladesh';
			case 'countries.barbados': return 'Barbados';
			case 'countries.belarus': return 'Belarus';
			case 'countries.belgium': return 'Belgium';
			case 'countries.belize': return 'Belize';
			case 'countries.benin': return 'Benin';
			case 'countries.bhutan': return 'Bhutan';
			case 'countries.bolivia': return 'Bolivia';
			case 'countries.bosniaAndHerzegovina': return 'Bosnia and Herzegovina';
			case 'countries.botswana': return 'Botswana';
			case 'countries.brazil': return 'Brazil';
			case 'countries.brunei': return 'Brunei';
			case 'countries.bulgaria': return 'Bulgaria';
			case 'countries.burkinaFaso': return 'Burkina Faso';
			case 'countries.burundi': return 'Burundi';
			case 'countries.cambodia': return 'Cambodia';
			case 'countries.cameroon': return 'Cameroon';
			case 'countries.canada': return 'Canada';
			case 'countries.capeVerde': return 'Cape Verde';
			case 'countries.centralAfricanRepublic': return 'Central African Republic';
			case 'countries.chad': return 'Chad';
			case 'countries.chile': return 'Chile';
			case 'countries.china': return 'China';
			case 'countries.colombia': return 'Colombia';
			case 'countries.comoros': return 'Comoros';
			case 'countries.congo': return 'Congo';
			case 'countries.democraticRepublicOfCongo': return 'Democratic Republic of the Congo';
			case 'countries.costaRica': return 'Costa Rica';
			case 'countries.croatia': return 'Croatia';
			case 'countries.cuba': return 'Cuba';
			case 'countries.cyprus': return 'Cyprus';
			case 'countries.czechRepublic': return 'Czech Republic';
			case 'countries.denmark': return 'Denmark';
			case 'countries.djibouti': return 'Djibouti';
			case 'countries.dominica': return 'Dominica';
			case 'countries.dominicanRepublic': return 'Dominican Republic';
			case 'countries.ecuador': return 'Ecuador';
			case 'countries.egypt': return 'Egypt';
			case 'countries.elSalvador': return 'El Salvador';
			case 'countries.equatorialGuinea': return 'Equatorial Guinea';
			case 'countries.eritrea': return 'Eritrea';
			case 'countries.estonia': return 'Estonia';
			case 'countries.eswatini': return 'Eswatini';
			case 'countries.ethiopia': return 'Ethiopia';
			case 'countries.fiji': return 'Fiji';
			case 'countries.finland': return 'Finland';
			case 'countries.france': return 'France';
			case 'countries.gabon': return 'Gabon';
			case 'countries.gambia': return 'Gambia';
			case 'countries.georgia': return 'Georgia';
			case 'countries.germany': return 'Germany';
			case 'countries.ghana': return 'Ghana';
			case 'countries.greece': return 'Greece';
			case 'countries.grenada': return 'Grenada';
			case 'countries.guatemala': return 'Guatemala';
			case 'countries.guinea': return 'Guinea';
			case 'countries.guineaBissau': return 'Guinea-Bissau';
			case 'countries.guyana': return 'Guyana';
			case 'countries.haiti': return 'Haiti';
			case 'countries.honduras': return 'Honduras';
			case 'countries.hungary': return 'Hungary';
			case 'countries.iceland': return 'Iceland';
			case 'countries.india': return 'India';
			case 'countries.indonesia': return 'Indonesia';
			case 'countries.iran': return 'Iran';
			case 'countries.iraq': return 'Iraq';
			case 'countries.ireland': return 'Ireland';
			case 'countries.israel': return 'Israel';
			case 'countries.italy': return 'Italy';
			case 'countries.ivoryCoast': return 'Ivory Coast';
			case 'countries.jamaica': return 'Jamaica';
			case 'countries.japan': return 'Japan';
			case 'countries.jordan': return 'Jordan';
			case 'countries.kazakhstan': return 'Kazakhstan';
			case 'countries.kenya': return 'Kenya';
			case 'countries.kiribati': return 'Kiribati';
			case 'countries.kuwait': return 'Kuwait';
			case 'countries.kyrgyzstan': return 'Kyrgyzstan';
			case 'countries.laos': return 'Laos';
			case 'countries.latvia': return 'Latvia';
			case 'countries.lebanon': return 'Lebanon';
			case 'countries.lesotho': return 'Lesotho';
			case 'countries.liberia': return 'Liberia';
			case 'countries.libya': return 'Libya';
			case 'countries.liechtenstein': return 'Liechtenstein';
			case 'countries.lithuania': return 'Lithuania';
			case 'countries.luxembourg': return 'Luxembourg';
			case 'countries.madagascar': return 'Madagascar';
			case 'countries.malawi': return 'Malawi';
			case 'countries.malaysia': return 'Malaysia';
			case 'countries.maldives': return 'Maldives';
			case 'countries.mali': return 'Mali';
			case 'countries.malta': return 'Malta';
			case 'countries.marshallIslands': return 'Marshall Islands';
			case 'countries.mauritania': return 'Mauritania';
			case 'countries.mauritius': return 'Mauritius';
			case 'countries.mexico': return 'Mexico';
			case 'countries.micronesia': return 'Micronesia';
			case 'countries.moldova': return 'Moldova';
			case 'countries.monaco': return 'Monaco';
			case 'countries.mongolia': return 'Mongolia';
			case 'countries.montenegro': return 'Montenegro';
			case 'countries.morocco': return 'Morocco';
			case 'countries.mozambique': return 'Mozambique';
			case 'countries.myanmar': return 'Myanmar';
			case 'countries.namibia': return 'Namibia';
			case 'countries.nauru': return 'Nauru';
			case 'countries.nepal': return 'Nepal';
			case 'countries.netherlands': return 'Netherlands';
			case 'countries.newZealand': return 'New Zealand';
			case 'countries.nicaragua': return 'Nicaragua';
			case 'countries.niger': return 'Niger';
			case 'countries.nigeria': return 'Nigeria';
			case 'countries.northKorea': return 'North Korea';
			case 'countries.northMacedonia': return 'North Macedonia';
			case 'countries.norway': return 'Norway';
			case 'countries.oman': return 'Oman';
			case 'countries.pakistan': return 'Pakistan';
			case 'countries.palau': return 'Palau';
			case 'countries.palestine': return 'Palestine';
			case 'countries.panama': return 'Panama';
			case 'countries.papuaNewGuinea': return 'Papua New Guinea';
			case 'countries.paraguay': return 'Paraguay';
			case 'countries.peru': return 'Peru';
			case 'countries.philippines': return 'Philippines';
			case 'countries.poland': return 'Poland';
			case 'countries.portugal': return 'Portugal';
			case 'countries.qatar': return 'Qatar';
			case 'countries.romania': return 'Romania';
			case 'countries.russia': return 'Russia';
			case 'countries.rwanda': return 'Rwanda';
			case 'countries.saintKittsAndNevis': return 'Saint Kitts and Nevis';
			case 'countries.saintLucia': return 'Saint Lucia';
			case 'countries.saintVincentAndTheGrenadines': return 'Saint Vincent and the Grenadines';
			case 'countries.samoa': return 'Samoa';
			case 'countries.sanMarino': return 'San Marino';
			case 'countries.saoTomeAndPrincipe': return 'Sao Tome and Principe';
			case 'countries.saudiArabia': return 'Saudi Arabia';
			case 'countries.senegal': return 'Senegal';
			case 'countries.serbia': return 'Serbia';
			case 'countries.seychelles': return 'Seychelles';
			case 'countries.sierraLeone': return 'Sierra Leone';
			case 'countries.singapore': return 'Singapore';
			case 'countries.slovakia': return 'Slovakia';
			case 'countries.slovenia': return 'Slovenia';
			case 'countries.solomonIslands': return 'Solomon Islands';
			case 'countries.somalia': return 'Somalia';
			case 'countries.southAfrica': return 'South Africa';
			case 'countries.southKorea': return 'South Korea';
			case 'countries.southSudan': return 'South Sudan';
			case 'countries.spain': return 'Spain';
			case 'countries.sriLanka': return 'Sri Lanka';
			case 'countries.sudan': return 'Sudan';
			case 'countries.suriname': return 'Suriname';
			case 'countries.sweden': return 'Sweden';
			case 'countries.switzerland': return 'Switzerland';
			case 'countries.syria': return 'Syria';
			case 'countries.taiwan': return 'Taiwan';
			case 'countries.tajikistan': return 'Tajikistan';
			case 'countries.tanzania': return 'Tanzania';
			case 'countries.thailand': return 'Thailand';
			case 'countries.timor': return 'Timor-Leste';
			case 'countries.togo': return 'Togo';
			case 'countries.tonga': return 'Tonga';
			case 'countries.trinidadAndTobago': return 'Trinidad and Tobago';
			case 'countries.tunisia': return 'Tunisia';
			case 'countries.turkey': return 'Turkey';
			case 'countries.turkmenistan': return 'Turkmenistan';
			case 'countries.tuvalu': return 'Tuvalu';
			case 'countries.uganda': return 'Uganda';
			case 'countries.ukraine': return 'Ukraine';
			case 'countries.unitedArabEmirates': return 'United Arab Emirates';
			case 'countries.unitedKingdom': return 'United Kingdom';
			case 'countries.unitedStates': return 'United States';
			case 'countries.uruguay': return 'Uruguay';
			case 'countries.uzbekistan': return 'Uzbekistan';
			case 'countries.vanuatu': return 'Vanuatu';
			case 'countries.vaticanCity': return 'Vatican City';
			case 'countries.venezuela': return 'Venezuela';
			case 'countries.vietnam': return 'Vietnam';
			case 'countries.yemen': return 'Yemen';
			case 'countries.zambia': return 'Zambia';
			case 'countries.zimbabwe': return 'Zimbabwe';
			case 'accountStatus.pendingTitle': return 'Account Under Review';
			case 'accountStatus.pendingDescription': return 'Your account is currently being reviewed. We will notify you once approved.';
			case 'accountStatus.pendingSupportInfo': return 'If you have questions, please contact support.';
			case 'accountStatus.rejectedTitle': return 'Account Rejected';
			case 'accountStatus.rejectedDescription': return 'Unfortunately, your account application has been rejected.';
			case 'accountStatus.rejectedReason': return 'Please contact support for more information about the reason.';
			case 'accountStatus.blockedTitle': return 'Account Blocked';
			case 'accountStatus.blockedDescription': return 'Your account has been blocked. Please contact support for assistance.';
			case 'accountStatus.blockedSupportInfo': return 'If you believe this is an error, please reach out to our support team.';
			case 'cart.yourCart': return 'Your Cart';
			case 'cart.emptyCart': return 'Cart is Empty';
			case 'cart.browseServices': return 'Browse Services';
			case 'cart.browseOfferings': return 'Browse our offerings \nto add items to your cart';
			case 'cart.weRecommend': return 'We recommend';
			case 'cart.edit': return 'Edit';
			case 'cart.remove': return 'Remove';
			case 'cart.addToCart': return 'Add to Cart';
			case 'cart.close': return 'Close';
			case 'cart.dontForgetToAdd': return 'Don\'t forget to add';
			case 'cart.itemDateTime': return ({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'en').format(date)}';
			case 'cart.services': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'service',
				other: 'services',
			);
			case 'cart.total': return 'Total';
			case 'cart.hour': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				zero: 'hour',
				one: 'hour',
				other: 'hours',
			);
			case 'cart.promocode.header': return 'Promocode';
			case 'cart.promocode.hint': return 'Enter a Promocode';
			case 'cart.promocode.promocodeApplied': return 'Promocode applied';
			case 'cart.promocode.promocodeCannotBeApplied': return 'Promocode cannot be applied to your cart';
			case 'cart.updateInCart': return 'Update in Cart';
			case 'cart.cart': return 'cart';
			case 'cart.checkout': return 'Checkout';
			case 'cart.apply': return 'Apply';
			case 'cart.applyPromocode': return 'Apply Promocode';
			case 'cart.enterPromocode': return 'Enter promocode';
			case 'cart.promocodeRequired': return 'Promocode is required';
			case 'cart.appliedPromocodes': return 'Applied Promocodes';
			case 'cart.recommendations': return 'Recommendations';
			case 'cart.subtotal': return 'Subtotal';
			case 'cart.discount': return 'Discount';
			case 'cart.minOrder': return 'Min order';
			case 'cart.minTime': return 'Min time';
			case 'cart.spaceRequired': return 'Space required';
			case 'cart.hours': return 'Hours';
			case 'cart.specialRequests': return 'Special requests';
			case 'cart.enterSpecialRequests': return 'Enter special requests...';
			case 'cart.errorLoadingCart': return 'Error loading cart';
			case 'cart.cartCleared': return 'Cart cleared successfully';
			case 'cart.failedToLoadService': return 'Failed to load service';
			case 'cart.pleaseSelectOption': return ({required Object sectionName}) => 'Please select a ${sectionName}';
			case 'cart.pleaseSelectAtLeastOne': return ({required Object sectionName}) => 'Please select at least one ${sectionName} option';
			case 'cart.pleaseSelectMore': return ({required Object sectionName}) => 'Please select more ${sectionName} options';
			case 'cart.tooManyOptionsSelected': return ({required Object sectionName}) => 'Too many ${sectionName} options selected';
			case 'cart.pleaseAddAtLeastOne': return ({required Object sectionName}) => 'Please add at least one ${sectionName} item';
			case 'cart.pleaseSelectDateTime': return 'Please select a date and time';
			case 'cart.canapeOptions': return 'Canapé Options';
			case 'cart.options': return 'Options';
			case 'cart.startDateAndTime': return 'Start date and time';
			case 'cart.perExtraHour': return 'per extra hour';
			case 'cart.goToVendorProfile': return ({required Object vendorName}) => 'Go to ${vendorName} profile';
			case 'settings.title': return 'App Settings';
			case 'settings.language': return 'Language';
			case 'settings.notifications': return 'Notifications';
			case 'settings.notificationSettings.title': return 'Notifications';
			case 'settings.notificationSettings.common': return 'Common';
			case 'settings.notificationSettings.generalNotification': return 'General Notification';
			case 'settings.notificationSettings.sound': return 'Sound';
			case 'settings.notificationSettings.vibrate': return 'Vibrate';
			case 'settings.notificationSettings.systemAndServicesUpdate': return 'System & Services Update';
			case 'settings.notificationSettings.appUpdates': return 'App Updates';
			case 'settings.notificationSettings.billReminder': return 'Bill Reminder';
			case 'settings.notificationSettings.promotion': return 'Promotion';
			case 'settings.notificationSettings.discountAvailable': return 'Discount Available';
			case 'settings.notificationSettings.paymentRequest': return 'Payment Request';
			default: return null;
		}
	}
}

