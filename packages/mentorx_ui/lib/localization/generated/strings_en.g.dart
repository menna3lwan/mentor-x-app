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
		    types: {
		      'price': ValueFormatter(() => NumberFormat.currency(symbol: '\$', locale: 'en')),
		    },
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
	late final TranslationsInitialLocationEn initialLocation = TranslationsInitialLocationEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsSearchEn search = TranslationsSearchEn._(_root);
	late final TranslationsFormsEn forms = TranslationsFormsEn._(_root);
	Map<String, dynamic> get exceptions => {
		'unknown': 'Unknown error',
		'AuthenticationRepositoryExceptionCode': TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn._(_root),
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
}

// Path: ui
class TranslationsUiEn {
	TranslationsUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${amount: price}'
	String totalCost({required num amount}) => '${_root.$meta.types['price']!.format(amount)}';

	late final TranslationsUiEventCardEn eventCard = TranslationsUiEventCardEn._(_root);
	late final TranslationsUiServiceDetailsEn serviceDetails = TranslationsUiServiceDetailsEn._(_root);
	late final TranslationsUiCommonEn common = TranslationsUiCommonEn._(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Eventi'
	String get appName => 'Eventi';

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

// Path: initialLocation
class TranslationsInitialLocationEn {
	TranslationsInitialLocationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please select your location for better experience'
	String get header => 'Please select your location for better experience';

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

	/// en: 'Continue as Guest'
	String get continueAsGuest => 'Continue as Guest';

	late final TranslationsLoginOtpEn otp = TranslationsLoginOtpEn._(_root);
	late final TranslationsLoginWallEn wall = TranslationsLoginWallEn._(_root);
	late final TranslationsLoginCountryPickerEn countryPicker = TranslationsLoginCountryPickerEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeMainEn main = TranslationsHomeMainEn._(_root);
	late final TranslationsHomeLocationEn location = TranslationsHomeLocationEn._(_root);

	/// en: 'Search for services, providers or experiences'
	String get search => 'Search for services, providers or experiences';

	/// en: 'Upcoming Events'
	String get upcomingEvents => 'Upcoming Events';

	/// en: 'Curated Service Providers'
	String get curatedServiceProviders => 'Curated Service Providers';

	/// en: 'Browse Experiences'
	String get browseExperiences => 'Browse Experiences';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'See All'
	String get seeAll => 'See All';

	/// en: 'See Past Events'
	String get seePastEvents => 'See Past Events';
}

// Path: search
class TranslationsSearchEn {
	TranslationsSearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search'
	String get title => 'Search';

	/// en: 'Search for services'
	String get search => 'Search for services';

	/// en: 'Search for services, providers or experiences'
	String get placeholder => 'Search for services, providers or experiences';

	/// en: 'No results found'
	String get noResults => 'No results found';

	late final TranslationsSearchFiltersEn filters = TranslationsSearchFiltersEn._(_root);
	late final TranslationsSearchTimeBottomSheetEn timeBottomSheet = TranslationsSearchTimeBottomSheetEn._(_root);
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

// Path: ui.eventCard
class TranslationsUiEventCardEn {
	TranslationsUiEventCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${date: DateFormat('MMM dd')}'
	String date({required DateTime date}) => '${DateFormat('MMM dd', 'en').format(date)}';

	/// en: '(one) {${n: int} service} (other) {${n: int} services}'
	String services({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} service',
		other: '${n} services',
	);
}

// Path: ui.serviceDetails
class TranslationsUiServiceDetailsEn {
	TranslationsUiServiceDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${date: DateFormat('MMM dd, HH:mm')}'
	String updateAt({required DateTime date}) => '${DateFormat('MMM dd, HH:mm', 'en').format(date)}';

	/// en: '(zero) {${n: int} hour} (one) {${n: int} hour} (other) {${n: int} hours}'
	String hour({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: '${n} hour',
		one: '${n} hour',
		other: '${n} hours',
	);
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
}

// Path: login.wall
class TranslationsLoginWallEn {
	TranslationsLoginWallEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Account'
	String get header => 'Your Account';

	/// en: 'Sign in or create your Eventi account to proceed.'
	String get description => 'Sign in or create your ${_root.core.appName} account to proceed.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Try another number'
	String get tryAnotherNumber => 'Try another number';
}

// Path: login.countryPicker
class TranslationsLoginCountryPickerEn {
	TranslationsLoginCountryPickerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pick your country'
	String get pickYourCountry => 'Pick your country';

	/// en: 'Pick your country dail code'
	String get pickYourCountryDailCode => 'Pick your country dail code';
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

// Path: home.location
class TranslationsHomeLocationEn {
	TranslationsHomeLocationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doha'
	String get doha => 'Doha';

	/// en: 'Location'
	String get title => 'Location';

	/// en: 'Please select your location for better experience'
	String get subtitle => 'Please select your location for better experience';

	/// en: 'History'
	String get historyLocations => 'History';

	/// en: 'Update Location'
	String get updateLocation => 'Update Location';

	/// en: 'Detected'
	String get detected => 'Detected';

	/// en: 'No results found'
	String get noSearchResults => 'No results found';

	/// en: 'Search for a location'
	String get searchPlaceholder => 'Search for a location';

	/// en: 'Your current location'
	String get currentLocation => 'Your current location';

	/// en: 'Use current location'
	String get useCurrentLocation => 'Use current location';

	/// en: 'Location permission denied'
	String get permissionDenied => 'Location permission denied';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: search.filters
class TranslationsSearchFiltersEn {
	TranslationsSearchFiltersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Filters'
	String get title => 'Filters';
}

// Path: search.timeBottomSheet
class TranslationsSearchTimeBottomSheetEn {
	TranslationsSearchTimeBottomSheetEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Event time'
	String get title => 'Event time';

	/// en: 'Please specify the desired time to filter services that can be arranged for your event'
	String get subtitle => 'Please specify the desired time to filter services that can be arranged for your event';

	/// en: 'Update Time'
	String get updateTime => 'Update Time';

	/// en: '${date: DateFormat('MMMM d, HH:mm')}'
	String selectedDate({required DateTime date}) => '${DateFormat('MMMM d, HH:mm', 'en').format(date)}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui.totalCost': return ({required num amount}) => '${_root.$meta.types['price']!.format(amount)}';
			case 'ui.eventCard.date': return ({required DateTime date}) => '${DateFormat('MMM dd', 'en').format(date)}';
			case 'ui.eventCard.services': return ({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} service',
				other: '${n} services',
			);
			case 'ui.serviceDetails.updateAt': return ({required DateTime date}) => '${DateFormat('MMM dd, HH:mm', 'en').format(date)}';
			case 'ui.serviceDetails.hour': return ({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				zero: '${n} hour',
				one: '${n} hour',
				other: '${n} hours',
			);
			case 'ui.common.cancel': return 'Cancel';
			case 'ui.common.ok': return 'OK';
			case 'core.appName': return 'Eventi';
			case 'core.languages.en': return 'English';
			case 'core.languages.ar': return 'العربية';
			case 'initialLanguage.header': return 'Select your preferred language';
			case 'initialLanguage.kContinue': return 'Continue';
			case 'initialLocation.header': return 'Please select your location for better experience';
			case 'initialLocation.kContinue': return 'Continue';
			case 'login.header': return 'Enter your phone number to sign in';
			case 'login.phoneNumber': return 'Phone Number';
			case 'login.signIn': return 'Sign In';
			case 'login.continueAsGuest': return 'Continue as Guest';
			case 'login.otp.header': return 'Confirmation code';
			case 'login.otp.description': return 'We sent a code to your device. Enter it here to continue.';
			case 'login.otp.confirm': return 'Confirm';
			case 'login.otp.otpWasVerifiedSuccessfully': return 'OTP was verified successfully';
			case 'login.wall.header': return 'Your Account';
			case 'login.wall.description': return 'Sign in or create your ${_root.core.appName} account to proceed.';
			case 'login.wall.cancel': return 'Cancel';
			case 'login.wall.tryAnotherNumber': return 'Try another number';
			case 'login.countryPicker.pickYourCountry': return 'Pick your country';
			case 'login.countryPicker.pickYourCountryDailCode': return 'Pick your country dail code';
			case 'home.main.home': return 'Home';
			case 'home.main.favorites': return 'Favorites';
			case 'home.main.assistance': return 'Assistance';
			case 'home.main.cart': return 'Cart';
			case 'home.main.me': return 'Me';
			case 'home.location.doha': return 'Doha';
			case 'home.location.title': return 'Location';
			case 'home.location.subtitle': return 'Please select your location for better experience';
			case 'home.location.historyLocations': return 'History';
			case 'home.location.updateLocation': return 'Update Location';
			case 'home.location.detected': return 'Detected';
			case 'home.location.noSearchResults': return 'No results found';
			case 'home.location.searchPlaceholder': return 'Search for a location';
			case 'home.location.currentLocation': return 'Your current location';
			case 'home.location.useCurrentLocation': return 'Use current location';
			case 'home.location.permissionDenied': return 'Location permission denied';
			case 'home.location.retry': return 'Retry';
			case 'home.search': return 'Search for services, providers or experiences';
			case 'home.upcomingEvents': return 'Upcoming Events';
			case 'home.curatedServiceProviders': return 'Curated Service Providers';
			case 'home.browseExperiences': return 'Browse Experiences';
			case 'home.services': return 'Services';
			case 'home.seeAll': return 'See All';
			case 'home.seePastEvents': return 'See Past Events';
			case 'search.title': return 'Search';
			case 'search.search': return 'Search for services';
			case 'search.placeholder': return 'Search for services, providers or experiences';
			case 'search.noResults': return 'No results found';
			case 'search.filters.title': return 'Filters';
			case 'search.timeBottomSheet.title': return 'Event time';
			case 'search.timeBottomSheet.subtitle': return 'Please specify the desired time to filter services that can be arranged for your event';
			case 'search.timeBottomSheet.updateTime': return 'Update Time';
			case 'search.timeBottomSheet.selectedDate': return ({required DateTime date}) => '${DateFormat('MMMM d, HH:mm', 'en').format(date)}';
			case 'forms.required': return 'This field is required';
			case 'forms.minLength': return ({required int length}) => 'It must be ${length} letters long at least';
			case 'forms.maxLength': return ({required int length}) => 'The maximum limit is ${length} letters';
			case 'forms.minDigitsLength': return ({required int length}) => 'It must be ${length} digits long at least';
			case 'forms.maxDigitsLength': return ({required int length}) => 'The maximum limit is ${length} digits';
			case 'forms.youMustEnterAValidEmail': return 'You must enter a valid email';
			case 'exceptions.unknown': return 'Unknown error';
			case 'exceptions.AuthenticationRepositoryExceptionCode.unknown': return 'Unknown error';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber': return 'Invalid phone number';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP': return 'Invalid OTP';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize': return 'Failed to initialize';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp': return 'Failed to send OTP';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp': return 'Failed to verify OTP';
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
			default: return null;
		}
	}
}

