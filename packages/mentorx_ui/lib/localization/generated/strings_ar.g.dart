///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		    types: {
		      'price': ValueFormatter(() => NumberFormat.currency(symbol: '\$', locale: 'ar')),
		    },
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiAr ui = _TranslationsUiAr._(_root);
	@override late final _TranslationsCoreAr core = _TranslationsCoreAr._(_root);
	@override late final _TranslationsInitialLanguageAr initialLanguage = _TranslationsInitialLanguageAr._(_root);
	@override late final _TranslationsInitialLocationAr initialLocation = _TranslationsInitialLocationAr._(_root);
	@override late final _TranslationsLoginAr login = _TranslationsLoginAr._(_root);
	@override late final _TranslationsHomeAr home = _TranslationsHomeAr._(_root);
	@override late final _TranslationsSearchAr search = _TranslationsSearchAr._(_root);
	@override late final _TranslationsFormsAr forms = _TranslationsFormsAr._(_root);
	@override Map<String, dynamic> get exceptions => {
		'unknown': 'خطأ غير معروف',
		'AuthenticationRepositoryExceptionCode': _TranslationsExceptionsAuthenticationRepositoryExceptionCodeAr._(_root),
	};
	@override Map<String, String> get countries => {
		'afghanistan': 'أفغانستان',
		'albania': 'ألبانيا',
		'algeria': 'الجزائر',
		'andorra': 'أندورا',
		'angola': 'أنغولا',
		'antiguaAndBarbuda': 'أنتيغوا وباربودا',
		'argentina': 'الأرجنتين',
		'armenia': 'أرمينيا',
		'australia': 'أستراليا',
		'austria': 'النمسا',
		'azerbaijan': 'أذربيجان',
		'bahamas': 'جزر البهاما',
		'bahrain': 'البحرين',
		'bangladesh': 'بنغلاديش',
		'barbados': 'بربادوس',
		'belarus': 'بيلاروسيا',
		'belgium': 'بلجيكا',
		'belize': 'بليز',
		'benin': 'بنين',
		'bhutan': 'بوتان',
		'bolivia': 'بوليفيا',
		'bosniaAndHerzegovina': 'البوسنة والهرسك',
		'botswana': 'بوتسوانا',
		'brazil': 'البرازيل',
		'brunei': 'بروناي',
		'bulgaria': 'بلغاريا',
		'burkinaFaso': 'بوركينا فاسو',
		'burundi': 'بوروندي',
		'cambodia': 'كمبوديا',
		'cameroon': 'الكاميرون',
		'canada': 'كندا',
		'capeVerde': 'الرأس الأخضر',
		'centralAfricanRepublic': 'جمهورية أفريقيا الوسطى',
		'chad': 'تشاد',
		'chile': 'تشيلي',
		'china': 'الصين',
		'colombia': 'كولومبيا',
		'comoros': 'جزر القمر',
		'congo': 'الكونغو',
		'democraticRepublicOfCongo': 'جمهورية الكونغو الديمقراطية',
		'costaRica': 'كوستاريكا',
		'croatia': 'كرواتيا',
		'cuba': 'كوبا',
		'cyprus': 'قبرص',
		'czechRepublic': 'جمهورية التشيك',
		'denmark': 'الدنمارك',
		'djibouti': 'جيبوتي',
		'dominica': 'دومينيكا',
		'dominicanRepublic': 'جمهورية الدومينيكان',
		'ecuador': 'الإكوادور',
		'egypt': 'مصر',
		'elSalvador': 'السلفادور',
		'equatorialGuinea': 'غينيا الاستوائية',
		'eritrea': 'إريتريا',
		'estonia': 'إستونيا',
		'eswatini': 'إسواتيني',
		'ethiopia': 'إثيوبيا',
		'fiji': 'فيجي',
		'finland': 'فنلندا',
		'france': 'فرنسا',
		'gabon': 'الغابون',
		'gambia': 'غامبيا',
		'georgia': 'جورجيا',
		'germany': 'ألمانيا',
		'ghana': 'غانا',
		'greece': 'اليونان',
		'grenada': 'غرينادا',
		'guatemala': 'غواتيمالا',
		'guinea': 'غينيا',
		'guineaBissau': 'غينيا بيساو',
		'guyana': 'غيانا',
		'haiti': 'هايتي',
		'honduras': 'هندوراس',
		'hungary': 'المجر',
		'iceland': 'آيسلندا',
		'india': 'الهند',
		'indonesia': 'إندونيسيا',
		'iran': 'إيران',
		'iraq': 'العراق',
		'ireland': 'أيرلندا',
		'israel': 'إسرائيل',
		'italy': 'إيطاليا',
		'ivoryCoast': 'ساحل العاج',
		'jamaica': 'جامايكا',
		'japan': 'اليابان',
		'jordan': 'الأردن',
		'kazakhstan': 'كازاخستان',
		'kenya': 'كينيا',
		'kiribati': 'كيريباتي',
		'kuwait': 'الكويت',
		'kyrgyzstan': 'قيرغيزستان',
		'laos': 'لاوس',
		'latvia': 'لاتفيا',
		'lebanon': 'لبنان',
		'lesotho': 'ليسوتو',
		'liberia': 'ليبيريا',
		'libya': 'ليبيا',
		'liechtenstein': 'ليختنشتاين',
		'lithuania': 'ليتوانيا',
		'luxembourg': 'لوكسمبورغ',
		'madagascar': 'مدغشقر',
		'malawi': 'ملاوي',
		'malaysia': 'ماليزيا',
		'maldives': 'جزر المالديف',
		'mali': 'مالي',
		'malta': 'مالطا',
		'marshallIslands': 'جزر مارشال',
		'mauritania': 'موريتانيا',
		'mauritius': 'موريشيوس',
		'mexico': 'المكسيك',
		'micronesia': 'ميكرونيزيا',
		'moldova': 'مولدوفا',
		'monaco': 'موناكو',
		'mongolia': 'منغوليا',
		'montenegro': 'الجبل الأسود',
		'morocco': 'المغرب',
		'mozambique': 'موزمبيق',
		'myanmar': 'ميانمار',
		'namibia': 'ناميبيا',
		'nauru': 'ناورو',
		'nepal': 'نيبال',
		'netherlands': 'هولندا',
		'newZealand': 'نيوزيلندا',
		'nicaragua': 'نيكاراغوا',
		'niger': 'النيجر',
		'nigeria': 'نيجيريا',
		'northKorea': 'كوريا الشمالية',
		'northMacedonia': 'مقدونيا الشمالية',
		'norway': 'النرويج',
		'oman': 'عمان',
		'pakistan': 'باكستان',
		'palau': 'بالاو',
		'palestine': 'فلسطين',
		'panama': 'بنما',
		'papuaNewGuinea': 'بابوا غينيا الجديدة',
		'paraguay': 'باراغواي',
		'peru': 'بيرو',
		'philippines': 'الفلبين',
		'poland': 'بولندا',
		'portugal': 'البرتغال',
		'qatar': 'قطر',
		'romania': 'رومانيا',
		'russia': 'روسيا',
		'rwanda': 'رواندا',
		'saintKittsAndNevis': 'سانت كيتس ونيفيس',
		'saintLucia': 'سانت لوسيا',
		'saintVincentAndTheGrenadines': 'سانت فنسنت وجزر غرينادين',
		'samoa': 'ساموا',
		'sanMarino': 'سان مارينو',
		'saoTomeAndPrincipe': 'ساو تومي وبرينسيبي',
		'saudiArabia': 'المملكة العربية السعودية',
		'senegal': 'السنغال',
		'serbia': 'صربيا',
		'seychelles': 'سيشل',
		'sierraLeone': 'سيراليون',
		'singapore': 'سنغافورة',
		'slovakia': 'سلوفاكيا',
		'slovenia': 'سلوفينيا',
		'solomonIslands': 'جزر سليمان',
		'somalia': 'الصومال',
		'southAfrica': 'جنوب أفريقيا',
		'southKorea': 'كوريا الجنوبية',
		'southSudan': 'جنوب السودان',
		'spain': 'إسبانيا',
		'sriLanka': 'سريلانكا',
		'sudan': 'السودان',
		'suriname': 'سورينام',
		'sweden': 'السويد',
		'switzerland': 'سويسرا',
		'syria': 'سوريا',
		'taiwan': 'تايوان',
		'tajikistan': 'طاجيكستان',
		'tanzania': 'تنزانيا',
		'thailand': 'تايلاند',
		'timor': 'تيمور الشرقية',
		'togo': 'توغو',
		'tonga': 'تونغا',
		'trinidadAndTobago': 'ترينيداد وتوباغو',
		'tunisia': 'تونس',
		'turkey': 'تركيا',
		'turkmenistan': 'تركمانستان',
		'tuvalu': 'توفالو',
		'uganda': 'أوغندا',
		'ukraine': 'أوكرانيا',
		'unitedArabEmirates': 'الإمارات العربية المتحدة',
		'unitedKingdom': 'المملكة المتحدة',
		'unitedStates': 'الولايات المتحدة الأمريكية',
		'uruguay': 'أوروغواي',
		'uzbekistan': 'أوزبكستان',
		'vanuatu': 'فانواتو',
		'vaticanCity': 'الفاتيكان',
		'venezuela': 'فنزويلا',
		'vietnam': 'فيتنام',
		'yemen': 'اليمن',
		'zambia': 'زامبيا',
		'zimbabwe': 'زيمبابوي',
	};
}

// Path: ui
class _TranslationsUiAr implements TranslationsUiEn {
	_TranslationsUiAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String totalCost({required num amount}) => '${_root.$meta.types['price']!.format(amount)}';
	@override late final _TranslationsUiEventCardAr eventCard = _TranslationsUiEventCardAr._(_root);
	@override late final _TranslationsUiServiceDetailsAr serviceDetails = _TranslationsUiServiceDetailsAr._(_root);
	@override late final _TranslationsUiCommonAr common = _TranslationsUiCommonAr._(_root);
}

// Path: core
class _TranslationsCoreAr implements TranslationsCoreEn {
	_TranslationsCoreAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'MentorX';
	@override Map<String, String> get languages => {
		'en': 'English',
		'ar': 'العربية',
	};
}

// Path: initialLanguage
class _TranslationsInitialLanguageAr implements TranslationsInitialLanguageEn {
	_TranslationsInitialLanguageAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'يرجى تحديد اللغة المفضلة';
	@override String get kContinue => 'موافق';
}

// Path: initialLocation
class _TranslationsInitialLocationAr implements TranslationsInitialLocationEn {
	_TranslationsInitialLocationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'من فضلك اختر موقعك لتجربة افضل';
	@override String get kContinue => 'موافق';
}

// Path: login
class _TranslationsLoginAr implements TranslationsLoginEn {
	_TranslationsLoginAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'ادخل رقم الجوال لتسجيل الدخول';
	@override String get phoneNumber => 'رقم الجوال';
	@override String get signIn => 'تسجيل الدخول';
	@override String get continueAsGuest => 'استمر كزائر';
	@override late final _TranslationsLoginOtpAr otp = _TranslationsLoginOtpAr._(_root);
	@override late final _TranslationsLoginWallAr wall = _TranslationsLoginWallAr._(_root);
	@override late final _TranslationsLoginCountryPickerAr countryPicker = _TranslationsLoginCountryPickerAr._(_root);
}

// Path: home
class _TranslationsHomeAr implements TranslationsHomeEn {
	_TranslationsHomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeMainAr main = _TranslationsHomeMainAr._(_root);
	@override late final _TranslationsHomeLocationAr location = _TranslationsHomeLocationAr._(_root);
	@override String get search => 'ابحث عن خدمات أو مزودين أو تجارب';
	@override String get upcomingEvents => 'الأحداث القادمة';
	@override String get curatedServiceProviders => 'مزودو الخدمة المختارون';
	@override String get browseExperiences => 'تصفح التجارب';
	@override String get services => 'الخدمات';
	@override String get seeAll => 'عرض الكل';
	@override String get seePastEvents => 'عرض الأحداث السابقة';
}

// Path: search
class _TranslationsSearchAr implements TranslationsSearchEn {
	_TranslationsSearchAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بحث';
	@override String get search => 'ابحث عن خدمات';
	@override String get placeholder => 'ابحث عن خدمات أو مزودين أو تجارب';
	@override String get noResults => 'لم يتم العثور على نتائج';
	@override late final _TranslationsSearchFiltersAr filters = _TranslationsSearchFiltersAr._(_root);
	@override late final _TranslationsSearchTimeBottomSheetAr timeBottomSheet = _TranslationsSearchTimeBottomSheetAr._(_root);
}

// Path: forms
class _TranslationsFormsAr implements TranslationsFormsEn {
	_TranslationsFormsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get required => 'هذا الحقل مطلوب';
	@override String minLength({required int length}) => 'يجب أن يحتوي على ${length} أحرف على الأقل';
	@override String maxLength({required int length}) => 'الحد الأقصى هو ${length} أحرف';
	@override String minDigitsLength({required int length}) => 'يجب أن يحتوي على ${length} أرقام على الأقل';
	@override String maxDigitsLength({required int length}) => 'الحد الأقصى هو ${length} أرقام';
	@override String get youMustEnterAValidEmail => 'يجب إدخال بريد إلكتروني صحيح';
}

// Path: exceptions.AuthenticationRepositoryExceptionCode
class _TranslationsExceptionsAuthenticationRepositoryExceptionCodeAr implements TranslationsExceptionsAuthenticationRepositoryExceptionCodeEn {
	_TranslationsExceptionsAuthenticationRepositoryExceptionCodeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'خطأ غير معروف';
	@override String get invalidPhoneNumber => 'رقم الجوال غير صحيح';
	@override String get invalidOTP => 'رمز OTP غير صحيح';
	@override String get failedToInitialize => 'فشل التحميل';
	@override String get failedToSendOtp => 'فشل ارسال رمز ال OTP';
	@override String get failedToVerifyOtp => 'فشل التحقق من رمز ال OTP';
}

// Path: ui.eventCard
class _TranslationsUiEventCardAr implements TranslationsUiEventCardEn {
	_TranslationsUiEventCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String date({required DateTime date}) => '${DateFormat('MMM dd', 'ar').format(date)}';
	@override String services({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		one: '${n} خدمة',
		other: '${n} خدمات',
	);
}

// Path: ui.serviceDetails
class _TranslationsUiServiceDetailsAr implements TranslationsUiServiceDetailsEn {
	_TranslationsUiServiceDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String updateAt({required DateTime date}) => '${DateFormat('MMM dd, HH:mm', 'ar').format(date)}';
	@override String hour({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} ساعة',
		one: '${n} ساعة',
		other: '${n} ساعات',
	);
}

// Path: ui.common
class _TranslationsUiCommonAr implements TranslationsUiCommonEn {
	_TranslationsUiCommonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'إلغاء';
	@override String get ok => 'موافق';
}

// Path: login.otp
class _TranslationsLoginOtpAr implements TranslationsLoginOtpEn {
	_TranslationsLoginOtpAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'رمز التأكيد';
	@override String get description => 'لقد ارسلنا رمز تأكيد لجوالك. ادخله هنا للمتابعة.';
	@override String get confirm => 'تأكيد';
	@override String get otpWasVerifiedSuccessfully => 'تم التحقق من رمز التأكيد بنجاح';
}

// Path: login.wall
class _TranslationsLoginWallAr implements TranslationsLoginWallEn {
	_TranslationsLoginWallAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'حسابك';
	@override String get description => 'سجل الدخول او انشى حسابك في ${_root.core.appName} للأكمال';
	@override String get cancel => 'إلغاء';
	@override String get tryAnotherNumber => 'اختر رقم جوال جديد';
}

// Path: login.countryPicker
class _TranslationsLoginCountryPickerAr implements TranslationsLoginCountryPickerEn {
	_TranslationsLoginCountryPickerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pickYourCountry => 'اختر دولتك';
	@override String get pickYourCountryDailCode => 'اختر رمز إتصال دولتك';
}

// Path: home.main
class _TranslationsHomeMainAr implements TranslationsHomeMainEn {
	_TranslationsHomeMainAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get home => 'الرئيسية';
	@override String get favorites => 'المفضلة';
	@override String get assistance => 'المساعدة';
	@override String get cart => 'السلة';
	@override String get me => 'حسابي';
}

// Path: home.location
class _TranslationsHomeLocationAr implements TranslationsHomeLocationEn {
	_TranslationsHomeLocationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get doha => 'الدوحة';
	@override String get title => 'الموقع';
	@override String get subtitle => 'يرجى تحديد موقعك لتحسين التجربة';
	@override String get historyLocations => 'المواقع السابقة';
	@override String get updateLocation => 'تحديث الموقع';
	@override String get detected => 'تم تحديد الموقع';
	@override String get noSearchResults => 'لا توجد نتائج';
	@override String get searchPlaceholder => 'ابحث عن موقع';
	@override String get currentLocation => 'موقعك الحالي';
	@override String get useCurrentLocation => 'استخدام الموقع الحالي';
	@override String get permissionDenied => 'تم رفض إذن الموقع';
	@override String get retry => 'إعادة المحاولة';
}

// Path: search.filters
class _TranslationsSearchFiltersAr implements TranslationsSearchFiltersEn {
	_TranslationsSearchFiltersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الفلاتر';
}

// Path: search.timeBottomSheet
class _TranslationsSearchTimeBottomSheetAr implements TranslationsSearchTimeBottomSheetEn {
	_TranslationsSearchTimeBottomSheetAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'وقت الحدث';
	@override String get subtitle => 'يرجى تحديد الوقت المطلوب لتصفية الخدمات التي يمكن ترتيبها لحدثك';
	@override String get updateTime => 'تحديث الوقت';
	@override String selectedDate({required DateTime date}) => '${DateFormat('MMMM d, HH:mm', 'ar').format(date)}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui.totalCost': return ({required num amount}) => '${_root.$meta.types['price']!.format(amount)}';
			case 'ui.eventCard.date': return ({required DateTime date}) => '${DateFormat('MMM dd', 'ar').format(date)}';
			case 'ui.eventCard.services': return ({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
				one: '${n} خدمة',
				other: '${n} خدمات',
			);
			case 'ui.serviceDetails.updateAt': return ({required DateTime date}) => '${DateFormat('MMM dd, HH:mm', 'ar').format(date)}';
			case 'ui.serviceDetails.hour': return ({required int n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
				zero: '${n} ساعة',
				one: '${n} ساعة',
				other: '${n} ساعات',
			);
			case 'ui.common.cancel': return 'إلغاء';
			case 'ui.common.ok': return 'موافق';
			case 'core.appName': return 'MentorX';
			case 'core.languages.en': return 'English';
			case 'core.languages.ar': return 'العربية';
			case 'initialLanguage.header': return 'يرجى تحديد اللغة المفضلة';
			case 'initialLanguage.kContinue': return 'موافق';
			case 'initialLocation.header': return 'من فضلك اختر موقعك لتجربة افضل';
			case 'initialLocation.kContinue': return 'موافق';
			case 'login.header': return 'ادخل رقم الجوال لتسجيل الدخول';
			case 'login.phoneNumber': return 'رقم الجوال';
			case 'login.signIn': return 'تسجيل الدخول';
			case 'login.continueAsGuest': return 'استمر كزائر';
			case 'login.otp.header': return 'رمز التأكيد';
			case 'login.otp.description': return 'لقد ارسلنا رمز تأكيد لجوالك. ادخله هنا للمتابعة.';
			case 'login.otp.confirm': return 'تأكيد';
			case 'login.otp.otpWasVerifiedSuccessfully': return 'تم التحقق من رمز التأكيد بنجاح';
			case 'login.wall.header': return 'حسابك';
			case 'login.wall.description': return 'سجل الدخول او انشى حسابك في ${_root.core.appName} للأكمال';
			case 'login.wall.cancel': return 'إلغاء';
			case 'login.wall.tryAnotherNumber': return 'اختر رقم جوال جديد';
			case 'login.countryPicker.pickYourCountry': return 'اختر دولتك';
			case 'login.countryPicker.pickYourCountryDailCode': return 'اختر رمز إتصال دولتك';
			case 'home.main.home': return 'الرئيسية';
			case 'home.main.favorites': return 'المفضلة';
			case 'home.main.assistance': return 'المساعدة';
			case 'home.main.cart': return 'السلة';
			case 'home.main.me': return 'حسابي';
			case 'home.location.doha': return 'الدوحة';
			case 'home.location.title': return 'الموقع';
			case 'home.location.subtitle': return 'يرجى تحديد موقعك لتحسين التجربة';
			case 'home.location.historyLocations': return 'المواقع السابقة';
			case 'home.location.updateLocation': return 'تحديث الموقع';
			case 'home.location.detected': return 'تم تحديد الموقع';
			case 'home.location.noSearchResults': return 'لا توجد نتائج';
			case 'home.location.searchPlaceholder': return 'ابحث عن موقع';
			case 'home.location.currentLocation': return 'موقعك الحالي';
			case 'home.location.useCurrentLocation': return 'استخدام الموقع الحالي';
			case 'home.location.permissionDenied': return 'تم رفض إذن الموقع';
			case 'home.location.retry': return 'إعادة المحاولة';
			case 'home.search': return 'ابحث عن خدمات أو مزودين أو تجارب';
			case 'home.upcomingEvents': return 'الأحداث القادمة';
			case 'home.curatedServiceProviders': return 'مزودو الخدمة المختارون';
			case 'home.browseExperiences': return 'تصفح التجارب';
			case 'home.services': return 'الخدمات';
			case 'home.seeAll': return 'عرض الكل';
			case 'home.seePastEvents': return 'عرض الأحداث السابقة';
			case 'search.title': return 'بحث';
			case 'search.search': return 'ابحث عن خدمات';
			case 'search.placeholder': return 'ابحث عن خدمات أو مزودين أو تجارب';
			case 'search.noResults': return 'لم يتم العثور على نتائج';
			case 'search.filters.title': return 'الفلاتر';
			case 'search.timeBottomSheet.title': return 'وقت الحدث';
			case 'search.timeBottomSheet.subtitle': return 'يرجى تحديد الوقت المطلوب لتصفية الخدمات التي يمكن ترتيبها لحدثك';
			case 'search.timeBottomSheet.updateTime': return 'تحديث الوقت';
			case 'search.timeBottomSheet.selectedDate': return ({required DateTime date}) => '${DateFormat('MMMM d, HH:mm', 'ar').format(date)}';
			case 'forms.required': return 'هذا الحقل مطلوب';
			case 'forms.minLength': return ({required int length}) => 'يجب أن يحتوي على ${length} أحرف على الأقل';
			case 'forms.maxLength': return ({required int length}) => 'الحد الأقصى هو ${length} أحرف';
			case 'forms.minDigitsLength': return ({required int length}) => 'يجب أن يحتوي على ${length} أرقام على الأقل';
			case 'forms.maxDigitsLength': return ({required int length}) => 'الحد الأقصى هو ${length} أرقام';
			case 'forms.youMustEnterAValidEmail': return 'يجب إدخال بريد إلكتروني صحيح';
			case 'exceptions.unknown': return 'خطأ غير معروف';
			case 'exceptions.AuthenticationRepositoryExceptionCode.unknown': return 'خطأ غير معروف';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber': return 'رقم الجوال غير صحيح';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP': return 'رمز OTP غير صحيح';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize': return 'فشل التحميل';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp': return 'فشل ارسال رمز ال OTP';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp': return 'فشل التحقق من رمز ال OTP';
			case 'countries.afghanistan': return 'أفغانستان';
			case 'countries.albania': return 'ألبانيا';
			case 'countries.algeria': return 'الجزائر';
			case 'countries.andorra': return 'أندورا';
			case 'countries.angola': return 'أنغولا';
			case 'countries.antiguaAndBarbuda': return 'أنتيغوا وباربودا';
			case 'countries.argentina': return 'الأرجنتين';
			case 'countries.armenia': return 'أرمينيا';
			case 'countries.australia': return 'أستراليا';
			case 'countries.austria': return 'النمسا';
			case 'countries.azerbaijan': return 'أذربيجان';
			case 'countries.bahamas': return 'جزر البهاما';
			case 'countries.bahrain': return 'البحرين';
			case 'countries.bangladesh': return 'بنغلاديش';
			case 'countries.barbados': return 'بربادوس';
			case 'countries.belarus': return 'بيلاروسيا';
			case 'countries.belgium': return 'بلجيكا';
			case 'countries.belize': return 'بليز';
			case 'countries.benin': return 'بنين';
			case 'countries.bhutan': return 'بوتان';
			case 'countries.bolivia': return 'بوليفيا';
			case 'countries.bosniaAndHerzegovina': return 'البوسنة والهرسك';
			case 'countries.botswana': return 'بوتسوانا';
			case 'countries.brazil': return 'البرازيل';
			case 'countries.brunei': return 'بروناي';
			case 'countries.bulgaria': return 'بلغاريا';
			case 'countries.burkinaFaso': return 'بوركينا فاسو';
			case 'countries.burundi': return 'بوروندي';
			case 'countries.cambodia': return 'كمبوديا';
			case 'countries.cameroon': return 'الكاميرون';
			case 'countries.canada': return 'كندا';
			case 'countries.capeVerde': return 'الرأس الأخضر';
			case 'countries.centralAfricanRepublic': return 'جمهورية أفريقيا الوسطى';
			case 'countries.chad': return 'تشاد';
			case 'countries.chile': return 'تشيلي';
			case 'countries.china': return 'الصين';
			case 'countries.colombia': return 'كولومبيا';
			case 'countries.comoros': return 'جزر القمر';
			case 'countries.congo': return 'الكونغو';
			case 'countries.democraticRepublicOfCongo': return 'جمهورية الكونغو الديمقراطية';
			case 'countries.costaRica': return 'كوستاريكا';
			case 'countries.croatia': return 'كرواتيا';
			case 'countries.cuba': return 'كوبا';
			case 'countries.cyprus': return 'قبرص';
			case 'countries.czechRepublic': return 'جمهورية التشيك';
			case 'countries.denmark': return 'الدنمارك';
			case 'countries.djibouti': return 'جيبوتي';
			case 'countries.dominica': return 'دومينيكا';
			case 'countries.dominicanRepublic': return 'جمهورية الدومينيكان';
			case 'countries.ecuador': return 'الإكوادور';
			case 'countries.egypt': return 'مصر';
			case 'countries.elSalvador': return 'السلفادور';
			case 'countries.equatorialGuinea': return 'غينيا الاستوائية';
			case 'countries.eritrea': return 'إريتريا';
			case 'countries.estonia': return 'إستونيا';
			case 'countries.eswatini': return 'إسواتيني';
			case 'countries.ethiopia': return 'إثيوبيا';
			case 'countries.fiji': return 'فيجي';
			case 'countries.finland': return 'فنلندا';
			case 'countries.france': return 'فرنسا';
			case 'countries.gabon': return 'الغابون';
			case 'countries.gambia': return 'غامبيا';
			case 'countries.georgia': return 'جورجيا';
			case 'countries.germany': return 'ألمانيا';
			case 'countries.ghana': return 'غانا';
			case 'countries.greece': return 'اليونان';
			case 'countries.grenada': return 'غرينادا';
			case 'countries.guatemala': return 'غواتيمالا';
			case 'countries.guinea': return 'غينيا';
			case 'countries.guineaBissau': return 'غينيا بيساو';
			case 'countries.guyana': return 'غيانا';
			case 'countries.haiti': return 'هايتي';
			case 'countries.honduras': return 'هندوراس';
			case 'countries.hungary': return 'المجر';
			case 'countries.iceland': return 'آيسلندا';
			case 'countries.india': return 'الهند';
			case 'countries.indonesia': return 'إندونيسيا';
			case 'countries.iran': return 'إيران';
			case 'countries.iraq': return 'العراق';
			case 'countries.ireland': return 'أيرلندا';
			case 'countries.israel': return 'إسرائيل';
			case 'countries.italy': return 'إيطاليا';
			case 'countries.ivoryCoast': return 'ساحل العاج';
			case 'countries.jamaica': return 'جامايكا';
			case 'countries.japan': return 'اليابان';
			case 'countries.jordan': return 'الأردن';
			case 'countries.kazakhstan': return 'كازاخستان';
			case 'countries.kenya': return 'كينيا';
			case 'countries.kiribati': return 'كيريباتي';
			case 'countries.kuwait': return 'الكويت';
			case 'countries.kyrgyzstan': return 'قيرغيزستان';
			case 'countries.laos': return 'لاوس';
			case 'countries.latvia': return 'لاتفيا';
			case 'countries.lebanon': return 'لبنان';
			case 'countries.lesotho': return 'ليسوتو';
			case 'countries.liberia': return 'ليبيريا';
			case 'countries.libya': return 'ليبيا';
			case 'countries.liechtenstein': return 'ليختنشتاين';
			case 'countries.lithuania': return 'ليتوانيا';
			case 'countries.luxembourg': return 'لوكسمبورغ';
			case 'countries.madagascar': return 'مدغشقر';
			case 'countries.malawi': return 'ملاوي';
			case 'countries.malaysia': return 'ماليزيا';
			case 'countries.maldives': return 'جزر المالديف';
			case 'countries.mali': return 'مالي';
			case 'countries.malta': return 'مالطا';
			case 'countries.marshallIslands': return 'جزر مارشال';
			case 'countries.mauritania': return 'موريتانيا';
			case 'countries.mauritius': return 'موريشيوس';
			case 'countries.mexico': return 'المكسيك';
			case 'countries.micronesia': return 'ميكرونيزيا';
			case 'countries.moldova': return 'مولدوفا';
			case 'countries.monaco': return 'موناكو';
			case 'countries.mongolia': return 'منغوليا';
			case 'countries.montenegro': return 'الجبل الأسود';
			case 'countries.morocco': return 'المغرب';
			case 'countries.mozambique': return 'موزمبيق';
			case 'countries.myanmar': return 'ميانمار';
			case 'countries.namibia': return 'ناميبيا';
			case 'countries.nauru': return 'ناورو';
			case 'countries.nepal': return 'نيبال';
			case 'countries.netherlands': return 'هولندا';
			case 'countries.newZealand': return 'نيوزيلندا';
			case 'countries.nicaragua': return 'نيكاراغوا';
			case 'countries.niger': return 'النيجر';
			case 'countries.nigeria': return 'نيجيريا';
			case 'countries.northKorea': return 'كوريا الشمالية';
			case 'countries.northMacedonia': return 'مقدونيا الشمالية';
			case 'countries.norway': return 'النرويج';
			case 'countries.oman': return 'عمان';
			case 'countries.pakistan': return 'باكستان';
			case 'countries.palau': return 'بالاو';
			case 'countries.palestine': return 'فلسطين';
			case 'countries.panama': return 'بنما';
			case 'countries.papuaNewGuinea': return 'بابوا غينيا الجديدة';
			case 'countries.paraguay': return 'باراغواي';
			case 'countries.peru': return 'بيرو';
			case 'countries.philippines': return 'الفلبين';
			case 'countries.poland': return 'بولندا';
			case 'countries.portugal': return 'البرتغال';
			case 'countries.qatar': return 'قطر';
			case 'countries.romania': return 'رومانيا';
			case 'countries.russia': return 'روسيا';
			case 'countries.rwanda': return 'رواندا';
			case 'countries.saintKittsAndNevis': return 'سانت كيتس ونيفيس';
			case 'countries.saintLucia': return 'سانت لوسيا';
			case 'countries.saintVincentAndTheGrenadines': return 'سانت فنسنت وجزر غرينادين';
			case 'countries.samoa': return 'ساموا';
			case 'countries.sanMarino': return 'سان مارينو';
			case 'countries.saoTomeAndPrincipe': return 'ساو تومي وبرينسيبي';
			case 'countries.saudiArabia': return 'المملكة العربية السعودية';
			case 'countries.senegal': return 'السنغال';
			case 'countries.serbia': return 'صربيا';
			case 'countries.seychelles': return 'سيشل';
			case 'countries.sierraLeone': return 'سيراليون';
			case 'countries.singapore': return 'سنغافورة';
			case 'countries.slovakia': return 'سلوفاكيا';
			case 'countries.slovenia': return 'سلوفينيا';
			case 'countries.solomonIslands': return 'جزر سليمان';
			case 'countries.somalia': return 'الصومال';
			case 'countries.southAfrica': return 'جنوب أفريقيا';
			case 'countries.southKorea': return 'كوريا الجنوبية';
			case 'countries.southSudan': return 'جنوب السودان';
			case 'countries.spain': return 'إسبانيا';
			case 'countries.sriLanka': return 'سريلانكا';
			case 'countries.sudan': return 'السودان';
			case 'countries.suriname': return 'سورينام';
			case 'countries.sweden': return 'السويد';
			case 'countries.switzerland': return 'سويسرا';
			case 'countries.syria': return 'سوريا';
			case 'countries.taiwan': return 'تايوان';
			case 'countries.tajikistan': return 'طاجيكستان';
			case 'countries.tanzania': return 'تنزانيا';
			case 'countries.thailand': return 'تايلاند';
			case 'countries.timor': return 'تيمور الشرقية';
			case 'countries.togo': return 'توغو';
			case 'countries.tonga': return 'تونغا';
			case 'countries.trinidadAndTobago': return 'ترينيداد وتوباغو';
			case 'countries.tunisia': return 'تونس';
			case 'countries.turkey': return 'تركيا';
			case 'countries.turkmenistan': return 'تركمانستان';
			case 'countries.tuvalu': return 'توفالو';
			case 'countries.uganda': return 'أوغندا';
			case 'countries.ukraine': return 'أوكرانيا';
			case 'countries.unitedArabEmirates': return 'الإمارات العربية المتحدة';
			case 'countries.unitedKingdom': return 'المملكة المتحدة';
			case 'countries.unitedStates': return 'الولايات المتحدة الأمريكية';
			case 'countries.uruguay': return 'أوروغواي';
			case 'countries.uzbekistan': return 'أوزبكستان';
			case 'countries.vanuatu': return 'فانواتو';
			case 'countries.vaticanCity': return 'الفاتيكان';
			case 'countries.venezuela': return 'فنزويلا';
			case 'countries.vietnam': return 'فيتنام';
			case 'countries.yemen': return 'اليمن';
			case 'countries.zambia': return 'زامبيا';
			case 'countries.zimbabwe': return 'زيمبابوي';
			default: return null;
		}
	}
}

