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
	@override late final _TranslationsLoginAr login = _TranslationsLoginAr._(_root);
	@override late final _TranslationsHomeAr home = _TranslationsHomeAr._(_root);
	@override late final _TranslationsFormsAr forms = _TranslationsFormsAr._(_root);
	@override Map<String, dynamic> get exceptions => {
		'unknown': 'خطأ غير معروف',
		'AuthenticationRepositoryExceptionCode': _TranslationsExceptionsAuthenticationRepositoryExceptionCodeAr._(_root),
		'promocodeExceptions': _TranslationsExceptionsPromocodeExceptionsAr._(_root),
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
	@override late final _TranslationsCartAr cart = _TranslationsCartAr._(_root);
	@override late final _TranslationsSettingsAr settings = _TranslationsSettingsAr._(_root);
}

// Path: ui
class _TranslationsUiAr implements TranslationsUiEn {
	_TranslationsUiAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsUiCommonAr common = _TranslationsUiCommonAr._(_root);
	@override late final _TranslationsUiErrorsAr errors = _TranslationsUiErrorsAr._(_root);
	@override late final _TranslationsUiDateTimeAr dateTime = _TranslationsUiDateTimeAr._(_root);
	@override late final _TranslationsUiMentorXReadMoreAr mentorXReadMore = _TranslationsUiMentorXReadMoreAr._(_root);
}

// Path: core
class _TranslationsCoreAr implements TranslationsCoreEn {
	_TranslationsCoreAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'MentorX Student';
	@override String get currency => 'ج.م';
	@override String price({required num amount}) => '${amount} ${_root.core.currency}';
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

// Path: login
class _TranslationsLoginAr implements TranslationsLoginEn {
	_TranslationsLoginAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'ادخل رقم الجوال لتسجيل الدخول';
	@override String get phoneNumber => 'رقم الجوال';
	@override String get signIn => 'تسجيل الدخول';
	@override late final _TranslationsLoginOtpAr otp = _TranslationsLoginOtpAr._(_root);
}

// Path: home
class _TranslationsHomeAr implements TranslationsHomeEn {
	_TranslationsHomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeMainAr main = _TranslationsHomeMainAr._(_root);
	@override late final _TranslationsHomeErrorsAr errors = _TranslationsHomeErrorsAr._(_root);
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
	@override late final _TranslationsFormsCardAr card = _TranslationsFormsCardAr._(_root);
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

// Path: exceptions.promocodeExceptions
class _TranslationsExceptionsPromocodeExceptionsAr implements TranslationsExceptionsPromocodeExceptionsEn {
	_TranslationsExceptionsPromocodeExceptionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get cantBeApplied => 'لا يمكن تطبيق الرمز الترويجي على سلتك';
}

// Path: cart
class _TranslationsCartAr implements TranslationsCartEn {
	_TranslationsCartAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get yourCart => 'سلتك';
	@override String get emptyCart => 'سلتك فارغة';
	@override String get browseServices => 'تصفح الخدمات';
	@override String get browseOfferings => 'تصفح عروضنا \nلإضافة عناصر إلى سلتك';
	@override String get weRecommend => 'نوصي بـ';
	@override String get edit => 'تعديل';
	@override String get remove => 'إزالة';
	@override String get addToCart => 'أضف إلى السلة';
	@override String get close => 'إغلاق';
	@override String itemDateTime({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'ar').format(date)}';
	@override String hour({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'ساعة',
		one: 'ساعة',
		other: 'ساعات',
	);
	@override String get dontForgetToAdd => 'لا تنسَ الإضافة';
	@override String services({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		one: 'خدمة',
		other: 'خدمات',
	);
	@override String get total => 'الإجمالي';
	@override late final _TranslationsCartPromocodeAr promocode = _TranslationsCartPromocodeAr._(_root);
	@override String get updateInCart => 'تحديث في السلة';
	@override String get cart => 'سلة';
	@override String get checkout => 'إتمام الشراء';
	@override String get apply => 'تطبيق';
	@override String get applyPromocode => 'تطبيق كود الخصم';
	@override String get enterPromocode => 'أدخل كود الخصم';
	@override String get promocodeRequired => 'كود الخصم مطلوب';
	@override String get appliedPromocodes => 'أكواد الخصم المطبقة';
	@override String get recommendations => 'التوصيات';
	@override String get subtotal => 'المجموع الفرعي';
	@override String get discount => 'الخصم';
	@override String get minOrder => 'الحد الأدنى للطلب';
	@override String get minTime => 'الحد الأدنى للوقت';
	@override String get spaceRequired => 'المساحة المطلوبة';
	@override String get hours => 'ساعات';
	@override String get specialRequests => 'طلبات خاصة';
	@override String get enterSpecialRequests => 'أدخل الطلبات الخاصة...';
	@override String get errorLoadingCart => 'خطأ في تحميل السلة';
	@override String get cartCleared => 'تم مسح السلة بنجاح';
	@override String get failedToLoadService => 'فشل تحميل الخدمة';
	@override String pleaseSelectOption({required Object sectionName}) => 'يرجى اختيار ${sectionName}';
	@override String pleaseSelectAtLeastOne({required Object sectionName}) => 'يرجى اختيار خيار ${sectionName} واحد على الأقل';
	@override String pleaseSelectMore({required Object sectionName}) => 'يرجى اختيار المزيد من خيارات ${sectionName}';
	@override String tooManyOptionsSelected({required Object sectionName}) => 'تم اختيار عدد كبير جداً من خيارات ${sectionName}';
	@override String pleaseAddAtLeastOne({required Object sectionName}) => 'يرجى إضافة عنصر ${sectionName} واحد على الأقل';
	@override String get pleaseSelectDateTime => 'يرجى اختيار التاريخ والوقت';
	@override String get canapeOptions => 'خيارات الكانابيه';
	@override String get options => 'خيارات';
	@override String get startDateAndTime => 'تاريخ ووقت البدء';
	@override String get perExtraHour => 'لكل ساعة إضافية';
	@override String goToVendorProfile({required Object vendorName}) => 'انتقل إلى ملف ${vendorName}';
}

// Path: settings
class _TranslationsSettingsAr implements TranslationsSettingsEn {
	_TranslationsSettingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إعدادات التطبيق';
	@override String get language => 'اللغة';
	@override String get notifications => 'الإشعارات';
	@override late final _TranslationsSettingsNotificationSettingsAr notificationSettings = _TranslationsSettingsNotificationSettingsAr._(_root);
}

// Path: ui.common
class _TranslationsUiCommonAr implements TranslationsUiCommonEn {
	_TranslationsUiCommonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'إلغاء';
	@override String get ok => 'موافق';
	@override String get viewAll => 'عرض الكل';
	@override String get required => 'مطلوب';
	@override String get optional => 'اختياري';
	@override String get customization => 'التخصيص';
}

// Path: ui.errors
class _TranslationsUiErrorsAr implements TranslationsUiErrorsEn {
	_TranslationsUiErrorsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get somethingWentWrong => 'حدث خطأ ما';
	@override String get retry => 'إعادة المحاولة';
}

// Path: ui.dateTime
class _TranslationsUiDateTimeAr implements TranslationsUiDateTimeEn {
	_TranslationsUiDateTimeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get yesterday => 'أمس';
	@override String get today => 'اليوم';
	@override String get now => 'الآن';
	@override String get tomorrow => 'غدًا';
	@override String time({required DateTime time}) => '${DateFormat('HH:mm', 'ar').format(time)}';
	@override String timeWithDay({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'ar').format(time)}، ${day}';
	@override String dateWithMonth({required DateTime date}) => '${DateFormat('MMM d', 'ar').format(date)}';
	@override Map<String, String> get weekdays => {
		'monday': 'الاثنين',
		'tuesday': 'الثلاثاء',
		'wednesday': 'الأربعاء',
		'thursday': 'الخميس',
		'friday': 'الجمعة',
		'saturday': 'السبت',
		'sunday': 'الأحد',
	};
}

// Path: ui.mentorXReadMore
class _TranslationsUiMentorXReadMoreAr implements TranslationsUiMentorXReadMoreEn {
	_TranslationsUiMentorXReadMoreAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get more => 'المزيد';
	@override String get less => 'أقل';
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
	@override String get resend => 'اعادة الارسال';
	@override String get otpWasResentSuccessfully => 'تم اعادة الارسال بنجاح';
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

// Path: home.errors
class _TranslationsHomeErrorsAr implements TranslationsHomeErrorsEn {
	_TranslationsHomeErrorsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get failedToLoadUpcomingEvents => 'فشل تحميل الفاعليات القادمة';
	@override String get failedToLoadVendors => 'فشل تحميل مزودي الخدمات';
	@override String get failedToLoadOccasions => 'فشل تحميل المناسبات';
	@override String get failedToLoadCategories => 'فشل تحميل الأقسام';
}

// Path: forms.card
class _TranslationsFormsCardAr implements TranslationsFormsCardEn {
	_TranslationsFormsCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get expiryInvalidFormat => 'صيغة غير صحيحة. استخدم MM/YY';
	@override String get expiryInvalidMonth => 'شهر غير صحيح (01-12)';
	@override String get expiryCardExpired => 'انتهت صلاحية البطاقة';
	@override String get cvvInvalid => 'يجب أن يكون CVV من 3-4 أرقام';
}

// Path: cart.promocode
class _TranslationsCartPromocodeAr implements TranslationsCartPromocodeEn {
	_TranslationsCartPromocodeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'رمز ترويجي';
	@override String get hint => 'أدخل الرمز الترويجي';
	@override String get promocodeApplied => 'تم تطبيق الرمز الترويجي';
	@override String get promocodeCannotBeApplied => 'لا يمكن تطبيق الرمز الترويجي على سلتك';
}

// Path: settings.notificationSettings
class _TranslationsSettingsNotificationSettingsAr implements TranslationsSettingsNotificationSettingsEn {
	_TranslationsSettingsNotificationSettingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإشعارات';
	@override String get common => 'عام';
	@override String get generalNotification => 'الإشعار العام';
	@override String get sound => 'الصوت';
	@override String get vibrate => 'الاهتزاز';
	@override String get systemAndServicesUpdate => 'التحديثات والخدمات';
	@override String get appUpdates => 'تحديثات التطبيق';
	@override String get billReminder => 'تذكير الفاتورة';
	@override String get promotion => 'العروض الترويجية';
	@override String get discountAvailable => 'الخصومات المتاحة';
	@override String get paymentRequest => 'طلب الدفع';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		switch (path) {
			case 'ui.common.cancel': return 'إلغاء';
			case 'ui.common.ok': return 'موافق';
			case 'ui.common.viewAll': return 'عرض الكل';
			case 'ui.common.required': return 'مطلوب';
			case 'ui.common.optional': return 'اختياري';
			case 'ui.common.customization': return 'التخصيص';
			case 'ui.errors.somethingWentWrong': return 'حدث خطأ ما';
			case 'ui.errors.retry': return 'إعادة المحاولة';
			case 'ui.dateTime.yesterday': return 'أمس';
			case 'ui.dateTime.today': return 'اليوم';
			case 'ui.dateTime.now': return 'الآن';
			case 'ui.dateTime.tomorrow': return 'غدًا';
			case 'ui.dateTime.time': return ({required DateTime time}) => '${DateFormat('HH:mm', 'ar').format(time)}';
			case 'ui.dateTime.timeWithDay': return ({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'ar').format(time)}، ${day}';
			case 'ui.dateTime.dateWithMonth': return ({required DateTime date}) => '${DateFormat('MMM d', 'ar').format(date)}';
			case 'ui.dateTime.weekdays.monday': return 'الاثنين';
			case 'ui.dateTime.weekdays.tuesday': return 'الثلاثاء';
			case 'ui.dateTime.weekdays.wednesday': return 'الأربعاء';
			case 'ui.dateTime.weekdays.thursday': return 'الخميس';
			case 'ui.dateTime.weekdays.friday': return 'الجمعة';
			case 'ui.dateTime.weekdays.saturday': return 'السبت';
			case 'ui.dateTime.weekdays.sunday': return 'الأحد';
			case 'ui.mentorXReadMore.more': return 'المزيد';
			case 'ui.mentorXReadMore.less': return 'أقل';
			case 'core.appName': return 'MentorX Student';
			case 'core.currency': return 'ج.م';
			case 'core.price': return ({required num amount}) => '${amount} ${_root.core.currency}';
			case 'core.languages.en': return 'English';
			case 'core.languages.ar': return 'العربية';
			case 'initialLanguage.header': return 'يرجى تحديد اللغة المفضلة';
			case 'initialLanguage.kContinue': return 'موافق';
			case 'login.header': return 'ادخل رقم الجوال لتسجيل الدخول';
			case 'login.phoneNumber': return 'رقم الجوال';
			case 'login.signIn': return 'تسجيل الدخول';
			case 'login.otp.header': return 'رمز التأكيد';
			case 'login.otp.description': return 'لقد ارسلنا رمز تأكيد لجوالك. ادخله هنا للمتابعة.';
			case 'login.otp.confirm': return 'تأكيد';
			case 'login.otp.otpWasVerifiedSuccessfully': return 'تم التحقق من رمز التأكيد بنجاح';
			case 'login.otp.resend': return 'اعادة الارسال';
			case 'login.otp.otpWasResentSuccessfully': return 'تم اعادة الارسال بنجاح';
			case 'home.main.home': return 'الرئيسية';
			case 'home.main.favorites': return 'المفضلة';
			case 'home.main.assistance': return 'المساعدة';
			case 'home.main.cart': return 'السلة';
			case 'home.main.me': return 'حسابي';
			case 'home.errors.failedToLoadUpcomingEvents': return 'فشل تحميل الفاعليات القادمة';
			case 'home.errors.failedToLoadVendors': return 'فشل تحميل مزودي الخدمات';
			case 'home.errors.failedToLoadOccasions': return 'فشل تحميل المناسبات';
			case 'home.errors.failedToLoadCategories': return 'فشل تحميل الأقسام';
			case 'forms.required': return 'هذا الحقل مطلوب';
			case 'forms.minLength': return ({required int length}) => 'يجب أن يحتوي على ${length} أحرف على الأقل';
			case 'forms.maxLength': return ({required int length}) => 'الحد الأقصى هو ${length} أحرف';
			case 'forms.minDigitsLength': return ({required int length}) => 'يجب أن يحتوي على ${length} أرقام على الأقل';
			case 'forms.maxDigitsLength': return ({required int length}) => 'الحد الأقصى هو ${length} أرقام';
			case 'forms.youMustEnterAValidEmail': return 'يجب إدخال بريد إلكتروني صحيح';
			case 'forms.card.expiryInvalidFormat': return 'صيغة غير صحيحة. استخدم MM/YY';
			case 'forms.card.expiryInvalidMonth': return 'شهر غير صحيح (01-12)';
			case 'forms.card.expiryCardExpired': return 'انتهت صلاحية البطاقة';
			case 'forms.card.cvvInvalid': return 'يجب أن يكون CVV من 3-4 أرقام';
			case 'exceptions.unknown': return 'خطأ غير معروف';
			case 'exceptions.AuthenticationRepositoryExceptionCode.unknown': return 'خطأ غير معروف';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber': return 'رقم الجوال غير صحيح';
			case 'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP': return 'رمز OTP غير صحيح';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize': return 'فشل التحميل';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp': return 'فشل ارسال رمز ال OTP';
			case 'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp': return 'فشل التحقق من رمز ال OTP';
			case 'exceptions.promocodeExceptions.cantBeApplied': return 'لا يمكن تطبيق الرمز الترويجي على سلتك';
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
			case 'cart.yourCart': return 'سلتك';
			case 'cart.emptyCart': return 'سلتك فارغة';
			case 'cart.browseServices': return 'تصفح الخدمات';
			case 'cart.browseOfferings': return 'تصفح عروضنا \nلإضافة عناصر إلى سلتك';
			case 'cart.weRecommend': return 'نوصي بـ';
			case 'cart.edit': return 'تعديل';
			case 'cart.remove': return 'إزالة';
			case 'cart.addToCart': return 'أضف إلى السلة';
			case 'cart.close': return 'إغلاق';
			case 'cart.itemDateTime': return ({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'ar').format(date)}';
			case 'cart.hour': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
				zero: 'ساعة',
				one: 'ساعة',
				other: 'ساعات',
			);
			case 'cart.dontForgetToAdd': return 'لا تنسَ الإضافة';
			case 'cart.services': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
				one: 'خدمة',
				other: 'خدمات',
			);
			case 'cart.total': return 'الإجمالي';
			case 'cart.promocode.header': return 'رمز ترويجي';
			case 'cart.promocode.hint': return 'أدخل الرمز الترويجي';
			case 'cart.promocode.promocodeApplied': return 'تم تطبيق الرمز الترويجي';
			case 'cart.promocode.promocodeCannotBeApplied': return 'لا يمكن تطبيق الرمز الترويجي على سلتك';
			case 'cart.updateInCart': return 'تحديث في السلة';
			case 'cart.cart': return 'سلة';
			case 'cart.checkout': return 'إتمام الشراء';
			case 'cart.apply': return 'تطبيق';
			case 'cart.applyPromocode': return 'تطبيق كود الخصم';
			case 'cart.enterPromocode': return 'أدخل كود الخصم';
			case 'cart.promocodeRequired': return 'كود الخصم مطلوب';
			case 'cart.appliedPromocodes': return 'أكواد الخصم المطبقة';
			case 'cart.recommendations': return 'التوصيات';
			case 'cart.subtotal': return 'المجموع الفرعي';
			case 'cart.discount': return 'الخصم';
			case 'cart.minOrder': return 'الحد الأدنى للطلب';
			case 'cart.minTime': return 'الحد الأدنى للوقت';
			case 'cart.spaceRequired': return 'المساحة المطلوبة';
			case 'cart.hours': return 'ساعات';
			case 'cart.specialRequests': return 'طلبات خاصة';
			case 'cart.enterSpecialRequests': return 'أدخل الطلبات الخاصة...';
			case 'cart.errorLoadingCart': return 'خطأ في تحميل السلة';
			case 'cart.cartCleared': return 'تم مسح السلة بنجاح';
			case 'cart.failedToLoadService': return 'فشل تحميل الخدمة';
			case 'cart.pleaseSelectOption': return ({required Object sectionName}) => 'يرجى اختيار ${sectionName}';
			case 'cart.pleaseSelectAtLeastOne': return ({required Object sectionName}) => 'يرجى اختيار خيار ${sectionName} واحد على الأقل';
			case 'cart.pleaseSelectMore': return ({required Object sectionName}) => 'يرجى اختيار المزيد من خيارات ${sectionName}';
			case 'cart.tooManyOptionsSelected': return ({required Object sectionName}) => 'تم اختيار عدد كبير جداً من خيارات ${sectionName}';
			case 'cart.pleaseAddAtLeastOne': return ({required Object sectionName}) => 'يرجى إضافة عنصر ${sectionName} واحد على الأقل';
			case 'cart.pleaseSelectDateTime': return 'يرجى اختيار التاريخ والوقت';
			case 'cart.canapeOptions': return 'خيارات الكانابيه';
			case 'cart.options': return 'خيارات';
			case 'cart.startDateAndTime': return 'تاريخ ووقت البدء';
			case 'cart.perExtraHour': return 'لكل ساعة إضافية';
			case 'cart.goToVendorProfile': return ({required Object vendorName}) => 'انتقل إلى ملف ${vendorName}';
			case 'settings.title': return 'إعدادات التطبيق';
			case 'settings.language': return 'اللغة';
			case 'settings.notifications': return 'الإشعارات';
			case 'settings.notificationSettings.title': return 'الإشعارات';
			case 'settings.notificationSettings.common': return 'عام';
			case 'settings.notificationSettings.generalNotification': return 'الإشعار العام';
			case 'settings.notificationSettings.sound': return 'الصوت';
			case 'settings.notificationSettings.vibrate': return 'الاهتزاز';
			case 'settings.notificationSettings.systemAndServicesUpdate': return 'التحديثات والخدمات';
			case 'settings.notificationSettings.appUpdates': return 'تحديثات التطبيق';
			case 'settings.notificationSettings.billReminder': return 'تذكير الفاتورة';
			case 'settings.notificationSettings.promotion': return 'العروض الترويجية';
			case 'settings.notificationSettings.discountAvailable': return 'الخصومات المتاحة';
			case 'settings.notificationSettings.paymentRequest': return 'طلب الدفع';
			default: return null;
		}
	}
}

