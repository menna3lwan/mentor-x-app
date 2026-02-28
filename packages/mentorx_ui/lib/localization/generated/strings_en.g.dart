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

	/// en: 'Phone Number'
	String get phoneNumber => 'Phone Number';

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
		return switch (path) {
			'ui.common.cancel' => 'Cancel',
			'ui.common.ok' => 'OK',
			'ui.common.viewAll' => 'View All',
			'ui.common.required' => 'Required',
			'ui.common.optional' => 'Optional',
			'ui.common.customization' => 'Customization',
			'ui.errors.somethingWentWrong' => 'Something went wrong',
			'ui.errors.retry' => 'Retry',
			'ui.dateTime.yesterday' => 'Yesterday',
			'ui.dateTime.today' => 'Today',
			'ui.dateTime.now' => 'Now',
			'ui.dateTime.tomorrow' => 'Tomorrow',
			'ui.dateTime.time' => ({required DateTime time}) => '${DateFormat('HH:mm', 'en').format(time)}',
			'ui.dateTime.timeWithDay' => ({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'en').format(time)}, ${day}',
			'ui.dateTime.dateWithMonth' => ({required DateTime date}) => '${DateFormat('MMM d', 'en').format(date)}',
			'ui.dateTime.weekdays.monday' => 'Mon',
			'ui.dateTime.weekdays.tuesday' => 'Tue',
			'ui.dateTime.weekdays.wednesday' => 'Wed',
			'ui.dateTime.weekdays.thursday' => 'Thu',
			'ui.dateTime.weekdays.friday' => 'Fri',
			'ui.dateTime.weekdays.saturday' => 'Sat',
			'ui.dateTime.weekdays.sunday' => 'Sun',
			'ui.mentorXReadMore.more' => 'More',
			'ui.mentorXReadMore.less' => 'Less',
			'core.appName' => 'MentorX Student',
			'core.currency' => 'EGP',
			'core.price' => ({required num amount}) => '${amount} ${_root.core.currency}',
			'core.languages.en' => 'English',
			'core.languages.ar' => 'العربية',
			'initialLanguage.header' => 'Select your preferred language',
			'initialLanguage.kContinue' => 'Continue',
			'login.header' => 'Enter your phone number to sign in',
			'login.phoneNumber' => 'Phone Number',
			'login.signIn' => 'Sign In',
			'login.otp.header' => 'Confirmation code',
			'login.otp.description' => 'We sent a code to your device. Enter it here to continue.',
			'login.otp.confirm' => 'Confirm',
			'login.otp.otpWasVerifiedSuccessfully' => 'OTP was verified successfully',
			'login.otp.resend' => 'Resend',
			'login.otp.otpWasResentSuccessfully' => 'OTP was resent successfully',
			'home.main.home' => 'Home',
			'home.main.favorites' => 'Favorites',
			'home.main.assistance' => 'Assistance',
			'home.main.cart' => 'Cart',
			'home.main.me' => 'Me',
			'home.dashboard.greetingMorning' => 'Good morning',
			'home.dashboard.greetingEvening' => 'Good evening',
			'home.dashboard.greetingWithName' => ({required Object greeting, required Object name}) => '${greeting}, ${name} 👋',
			'home.dashboard.updatedAt' => ({required DateTime time}) => 'Updated ${DateFormat('HH:mm', 'en').format(time)}',
			'home.dashboard.continueLearning' => 'Continue Learning',
			'home.dashboard.featuredCourses' => 'Featured Courses',
			'home.dashboard.announcements' => 'Announcements',
			'home.dashboard.quickActions' => 'Quick Actions',
			'home.dashboard.walletBalance' => 'Wallet Balance',
			'home.dashboard.points' => ({required int count}) => '${count} points',
			'home.dashboard.startLearningJourney' => 'Start your learning journey! Browse available courses.',
			'home.dashboard.continueProgress' => ({required num progress}) => 'Continue ${progress}%',
			'home.dashboard.free' => 'Free',
			'home.dashboard.loadingCourse' => 'Loading course',
			'home.dashboard.loadingFeaturedCourse' => 'Loading featured course',
			'home.dashboard.loadingAnnouncement' => 'Loading announcement',
			'home.dashboard.loadingAnnouncementDetails' => 'Loading announcement details',
			'home.dashboard.unableToLoadTapRetry' => 'Unable to load. Tap to retry.',
			'home.dashboard.actions.myCourses' => 'My Courses',
			'home.dashboard.actions.attendance' => 'Attendance',
			'home.dashboard.actions.grades' => 'Grades',
			'home.dashboard.actions.aiAssistant' => 'AI Assistant',
			'home.dashboard.actions.rewards' => 'Rewards',
			'home.dashboard.actions.marketplace' => 'Marketplace',
			'home.errors.failedToLoadUpcomingEvents' => 'Failed to load upcoming events',
			'home.errors.failedToLoadVendors' => 'Failed to load service providers',
			'home.errors.failedToLoadOccasions' => 'Failed to load occasions',
			'home.errors.failedToLoadCategories' => 'Failed to load categories',
			'forms.required' => 'This field is required',
			'forms.minLength' => ({required int length}) => 'It must be ${length} letters long at least',
			'forms.maxLength' => ({required int length}) => 'The maximum limit is ${length} letters',
			'forms.minDigitsLength' => ({required int length}) => 'It must be ${length} digits long at least',
			'forms.maxDigitsLength' => ({required int length}) => 'The maximum limit is ${length} digits',
			'forms.youMustEnterAValidEmail' => 'You must enter a valid email',
			'forms.card.expiryInvalidFormat' => 'Invalid format. Use MM/YY',
			'forms.card.expiryInvalidMonth' => 'Invalid month (01-12)',
			'forms.card.expiryCardExpired' => 'Card has expired',
			'forms.card.cvvInvalid' => 'CVV must be 3-4 digits',
			'exceptions.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'Unknown error',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'Invalid phone number',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'Invalid OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'Failed to initialize',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'Failed to send OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'Failed to verify OTP',
			'exceptions.promocodeExceptions.cantBeApplied' => 'Promocode cannot be applied to your cart',
			'countries.afghanistan' => 'Afghanistan',
			'countries.albania' => 'Albania',
			'countries.algeria' => 'Algeria',
			'countries.andorra' => 'Andorra',
			'countries.angola' => 'Angola',
			'countries.antiguaAndBarbuda' => 'Antigua and Barbuda',
			'countries.argentina' => 'Argentina',
			'countries.armenia' => 'Armenia',
			'countries.australia' => 'Australia',
			'countries.austria' => 'Austria',
			'countries.azerbaijan' => 'Azerbaijan',
			'countries.bahamas' => 'Bahamas',
			'countries.bahrain' => 'Bahrain',
			'countries.bangladesh' => 'Bangladesh',
			'countries.barbados' => 'Barbados',
			'countries.belarus' => 'Belarus',
			'countries.belgium' => 'Belgium',
			'countries.belize' => 'Belize',
			'countries.benin' => 'Benin',
			'countries.bhutan' => 'Bhutan',
			'countries.bolivia' => 'Bolivia',
			'countries.bosniaAndHerzegovina' => 'Bosnia and Herzegovina',
			'countries.botswana' => 'Botswana',
			'countries.brazil' => 'Brazil',
			'countries.brunei' => 'Brunei',
			'countries.bulgaria' => 'Bulgaria',
			'countries.burkinaFaso' => 'Burkina Faso',
			'countries.burundi' => 'Burundi',
			'countries.cambodia' => 'Cambodia',
			'countries.cameroon' => 'Cameroon',
			'countries.canada' => 'Canada',
			'countries.capeVerde' => 'Cape Verde',
			'countries.centralAfricanRepublic' => 'Central African Republic',
			'countries.chad' => 'Chad',
			'countries.chile' => 'Chile',
			'countries.china' => 'China',
			'countries.colombia' => 'Colombia',
			'countries.comoros' => 'Comoros',
			'countries.congo' => 'Congo',
			'countries.democraticRepublicOfCongo' => 'Democratic Republic of the Congo',
			'countries.costaRica' => 'Costa Rica',
			'countries.croatia' => 'Croatia',
			'countries.cuba' => 'Cuba',
			'countries.cyprus' => 'Cyprus',
			'countries.czechRepublic' => 'Czech Republic',
			'countries.denmark' => 'Denmark',
			'countries.djibouti' => 'Djibouti',
			'countries.dominica' => 'Dominica',
			'countries.dominicanRepublic' => 'Dominican Republic',
			'countries.ecuador' => 'Ecuador',
			'countries.egypt' => 'Egypt',
			'countries.elSalvador' => 'El Salvador',
			'countries.equatorialGuinea' => 'Equatorial Guinea',
			'countries.eritrea' => 'Eritrea',
			'countries.estonia' => 'Estonia',
			'countries.eswatini' => 'Eswatini',
			'countries.ethiopia' => 'Ethiopia',
			'countries.fiji' => 'Fiji',
			'countries.finland' => 'Finland',
			'countries.france' => 'France',
			'countries.gabon' => 'Gabon',
			'countries.gambia' => 'Gambia',
			'countries.georgia' => 'Georgia',
			'countries.germany' => 'Germany',
			'countries.ghana' => 'Ghana',
			'countries.greece' => 'Greece',
			'countries.grenada' => 'Grenada',
			'countries.guatemala' => 'Guatemala',
			'countries.guinea' => 'Guinea',
			'countries.guineaBissau' => 'Guinea-Bissau',
			'countries.guyana' => 'Guyana',
			'countries.haiti' => 'Haiti',
			'countries.honduras' => 'Honduras',
			'countries.hungary' => 'Hungary',
			'countries.iceland' => 'Iceland',
			'countries.india' => 'India',
			'countries.indonesia' => 'Indonesia',
			'countries.iran' => 'Iran',
			'countries.iraq' => 'Iraq',
			'countries.ireland' => 'Ireland',
			'countries.israel' => 'Israel',
			'countries.italy' => 'Italy',
			'countries.ivoryCoast' => 'Ivory Coast',
			'countries.jamaica' => 'Jamaica',
			'countries.japan' => 'Japan',
			'countries.jordan' => 'Jordan',
			'countries.kazakhstan' => 'Kazakhstan',
			'countries.kenya' => 'Kenya',
			'countries.kiribati' => 'Kiribati',
			'countries.kuwait' => 'Kuwait',
			'countries.kyrgyzstan' => 'Kyrgyzstan',
			'countries.laos' => 'Laos',
			'countries.latvia' => 'Latvia',
			'countries.lebanon' => 'Lebanon',
			'countries.lesotho' => 'Lesotho',
			'countries.liberia' => 'Liberia',
			'countries.libya' => 'Libya',
			'countries.liechtenstein' => 'Liechtenstein',
			'countries.lithuania' => 'Lithuania',
			'countries.luxembourg' => 'Luxembourg',
			'countries.madagascar' => 'Madagascar',
			'countries.malawi' => 'Malawi',
			'countries.malaysia' => 'Malaysia',
			'countries.maldives' => 'Maldives',
			'countries.mali' => 'Mali',
			'countries.malta' => 'Malta',
			'countries.marshallIslands' => 'Marshall Islands',
			'countries.mauritania' => 'Mauritania',
			'countries.mauritius' => 'Mauritius',
			'countries.mexico' => 'Mexico',
			'countries.micronesia' => 'Micronesia',
			'countries.moldova' => 'Moldova',
			'countries.monaco' => 'Monaco',
			'countries.mongolia' => 'Mongolia',
			'countries.montenegro' => 'Montenegro',
			'countries.morocco' => 'Morocco',
			'countries.mozambique' => 'Mozambique',
			'countries.myanmar' => 'Myanmar',
			'countries.namibia' => 'Namibia',
			'countries.nauru' => 'Nauru',
			'countries.nepal' => 'Nepal',
			'countries.netherlands' => 'Netherlands',
			'countries.newZealand' => 'New Zealand',
			'countries.nicaragua' => 'Nicaragua',
			'countries.niger' => 'Niger',
			'countries.nigeria' => 'Nigeria',
			'countries.northKorea' => 'North Korea',
			'countries.northMacedonia' => 'North Macedonia',
			'countries.norway' => 'Norway',
			'countries.oman' => 'Oman',
			'countries.pakistan' => 'Pakistan',
			'countries.palau' => 'Palau',
			'countries.palestine' => 'Palestine',
			'countries.panama' => 'Panama',
			'countries.papuaNewGuinea' => 'Papua New Guinea',
			'countries.paraguay' => 'Paraguay',
			'countries.peru' => 'Peru',
			'countries.philippines' => 'Philippines',
			'countries.poland' => 'Poland',
			'countries.portugal' => 'Portugal',
			'countries.qatar' => 'Qatar',
			'countries.romania' => 'Romania',
			'countries.russia' => 'Russia',
			'countries.rwanda' => 'Rwanda',
			'countries.saintKittsAndNevis' => 'Saint Kitts and Nevis',
			'countries.saintLucia' => 'Saint Lucia',
			'countries.saintVincentAndTheGrenadines' => 'Saint Vincent and the Grenadines',
			'countries.samoa' => 'Samoa',
			'countries.sanMarino' => 'San Marino',
			'countries.saoTomeAndPrincipe' => 'Sao Tome and Principe',
			'countries.saudiArabia' => 'Saudi Arabia',
			'countries.senegal' => 'Senegal',
			'countries.serbia' => 'Serbia',
			'countries.seychelles' => 'Seychelles',
			'countries.sierraLeone' => 'Sierra Leone',
			'countries.singapore' => 'Singapore',
			'countries.slovakia' => 'Slovakia',
			'countries.slovenia' => 'Slovenia',
			'countries.solomonIslands' => 'Solomon Islands',
			'countries.somalia' => 'Somalia',
			'countries.southAfrica' => 'South Africa',
			'countries.southKorea' => 'South Korea',
			'countries.southSudan' => 'South Sudan',
			'countries.spain' => 'Spain',
			'countries.sriLanka' => 'Sri Lanka',
			'countries.sudan' => 'Sudan',
			'countries.suriname' => 'Suriname',
			'countries.sweden' => 'Sweden',
			'countries.switzerland' => 'Switzerland',
			'countries.syria' => 'Syria',
			'countries.taiwan' => 'Taiwan',
			'countries.tajikistan' => 'Tajikistan',
			'countries.tanzania' => 'Tanzania',
			'countries.thailand' => 'Thailand',
			'countries.timor' => 'Timor-Leste',
			'countries.togo' => 'Togo',
			'countries.tonga' => 'Tonga',
			'countries.trinidadAndTobago' => 'Trinidad and Tobago',
			'countries.tunisia' => 'Tunisia',
			'countries.turkey' => 'Turkey',
			'countries.turkmenistan' => 'Turkmenistan',
			'countries.tuvalu' => 'Tuvalu',
			'countries.uganda' => 'Uganda',
			'countries.ukraine' => 'Ukraine',
			'countries.unitedArabEmirates' => 'United Arab Emirates',
			'countries.unitedKingdom' => 'United Kingdom',
			'countries.unitedStates' => 'United States',
			'countries.uruguay' => 'Uruguay',
			'countries.uzbekistan' => 'Uzbekistan',
			'countries.vanuatu' => 'Vanuatu',
			'countries.vaticanCity' => 'Vatican City',
			'countries.venezuela' => 'Venezuela',
			'countries.vietnam' => 'Vietnam',
			'countries.yemen' => 'Yemen',
			'countries.zambia' => 'Zambia',
			'countries.zimbabwe' => 'Zimbabwe',
			'cart.yourCart' => 'Your Cart',
			'cart.emptyCart' => 'Cart is Empty',
			'cart.browseServices' => 'Browse Services',
			'cart.browseOfferings' => 'Browse our offerings \nto add items to your cart',
			'cart.weRecommend' => 'We recommend',
			'cart.edit' => 'Edit',
			'cart.remove' => 'Remove',
			'cart.addToCart' => 'Add to Cart',
			'cart.close' => 'Close',
			'cart.dontForgetToAdd' => 'Don\'t forget to add',
			'cart.itemDateTime' => ({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'en').format(date)}',
			'cart.services' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'service', other: 'services', ), 
			'cart.total' => 'Total',
			'cart.hour' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'hour', one: 'hour', other: 'hours', ), 
			'cart.promocode.header' => 'Promocode',
			'cart.promocode.hint' => 'Enter a Promocode',
			'cart.promocode.promocodeApplied' => 'Promocode applied',
			'cart.promocode.promocodeCannotBeApplied' => 'Promocode cannot be applied to your cart',
			'cart.updateInCart' => 'Update in Cart',
			'cart.cart' => 'cart',
			'cart.checkout' => 'Checkout',
			'cart.apply' => 'Apply',
			'cart.applyPromocode' => 'Apply Promocode',
			'cart.enterPromocode' => 'Enter promocode',
			'cart.promocodeRequired' => 'Promocode is required',
			'cart.appliedPromocodes' => 'Applied Promocodes',
			'cart.recommendations' => 'Recommendations',
			'cart.subtotal' => 'Subtotal',
			'cart.discount' => 'Discount',
			'cart.minOrder' => 'Min order',
			'cart.minTime' => 'Min time',
			'cart.spaceRequired' => 'Space required',
			'cart.hours' => 'Hours',
			'cart.specialRequests' => 'Special requests',
			'cart.enterSpecialRequests' => 'Enter special requests...',
			'cart.errorLoadingCart' => 'Error loading cart',
			'cart.cartCleared' => 'Cart cleared successfully',
			'cart.failedToLoadService' => 'Failed to load service',
			'cart.pleaseSelectOption' => ({required Object sectionName}) => 'Please select a ${sectionName}',
			'cart.pleaseSelectAtLeastOne' => ({required Object sectionName}) => 'Please select at least one ${sectionName} option',
			'cart.pleaseSelectMore' => ({required Object sectionName}) => 'Please select more ${sectionName} options',
			'cart.tooManyOptionsSelected' => ({required Object sectionName}) => 'Too many ${sectionName} options selected',
			'cart.pleaseAddAtLeastOne' => ({required Object sectionName}) => 'Please add at least one ${sectionName} item',
			'cart.pleaseSelectDateTime' => 'Please select a date and time',
			'cart.canapeOptions' => 'Canapé Options',
			'cart.options' => 'Options',
			'cart.startDateAndTime' => 'Start date and time',
			'cart.perExtraHour' => 'per extra hour',
			'cart.goToVendorProfile' => ({required Object vendorName}) => 'Go to ${vendorName} profile',
			'settings.title' => 'App Settings',
			'settings.language' => 'Language',
			'settings.notifications' => 'Notifications',
			'settings.notificationSettings.title' => 'Notifications',
			'settings.notificationSettings.common' => 'Common',
			'settings.notificationSettings.generalNotification' => 'General Notification',
			'settings.notificationSettings.sound' => 'Sound',
			'settings.notificationSettings.vibrate' => 'Vibrate',
			'settings.notificationSettings.systemAndServicesUpdate' => 'System & Services Update',
			'settings.notificationSettings.appUpdates' => 'App Updates',
			'settings.notificationSettings.billReminder' => 'Bill Reminder',
			'settings.notificationSettings.promotion' => 'Promotion',
			'settings.notificationSettings.discountAvailable' => 'Discount Available',
			'settings.notificationSettings.paymentRequest' => 'Payment Request',
			_ => null,
		};
	}
}
