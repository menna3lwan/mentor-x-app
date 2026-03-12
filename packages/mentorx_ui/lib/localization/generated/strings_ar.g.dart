///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
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
	@override late final _TranslationsOnboardingAr onboarding = _TranslationsOnboardingAr._(_root);
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
	@override late final _TranslationsAccountStatusAr accountStatus = _TranslationsAccountStatusAr._(_root);
	@override late final _TranslationsCartAr cart = _TranslationsCartAr._(_root);
	@override late final _TranslationsSettingsAr settings = _TranslationsSettingsAr._(_root);
	@override late final _TranslationsCourseAr course = _TranslationsCourseAr._(_root);
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

// Path: onboarding
class _TranslationsOnboardingAr implements TranslationsOnboardingEn {
	_TranslationsOnboardingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingStepsAr steps = _TranslationsOnboardingStepsAr._(_root);
}

// Path: login
class _TranslationsLoginAr implements TranslationsLoginEn {
	_TranslationsLoginAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'ادخل رقم الجوال لتسجيل الدخول';
	@override String get subtitle => 'سنرسل لك رمز تحقق';
	@override String get phoneNumber => 'رقم الجوال';
	@override String get phoneHint => '01XXXXXXXXX';
	@override String get phoneValidationError => 'يرجى إدخال رقم هاتف صحيح';
	@override String get signIn => 'تسجيل الدخول';
	@override late final _TranslationsLoginOtpAr otp = _TranslationsLoginOtpAr._(_root);
}

// Path: home
class _TranslationsHomeAr implements TranslationsHomeEn {
	_TranslationsHomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeMainAr main = _TranslationsHomeMainAr._(_root);
	@override late final _TranslationsHomeDashboardAr dashboard = _TranslationsHomeDashboardAr._(_root);
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

// Path: accountStatus
class _TranslationsAccountStatusAr implements TranslationsAccountStatusEn {
	_TranslationsAccountStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pendingTitle => 'الحساب قيد المراجعة';
	@override String get pendingDescription => 'حسابك قيد المراجعة حالياً. سنقوم بإعلامك فور الموافقة.';
	@override String get pendingSupportInfo => 'إذا كان لديك أي استفسار، يرجى التواصل مع الدعم.';
	@override String get rejectedTitle => 'تم رفض الحساب';
	@override String get rejectedDescription => 'للأسف، تم رفض طلب حسابك.';
	@override String get rejectedReason => 'يرجى التواصل مع الدعم لمعرفة المزيد عن السبب.';
	@override String get blockedTitle => 'الحساب محظور';
	@override String get blockedDescription => 'تم حظر حسابك. يرجى التواصل مع الدعم للمساعدة.';
	@override String get blockedSupportInfo => 'إذا كنت تعتقد أن هذا خطأ، يرجى التواصل مع فريق الدعم.';
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

// Path: course
class _TranslationsCourseAr implements TranslationsCourseEn {
	_TranslationsCourseAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get myCourses => 'دوراتي';
	@override String get courseCatalog => 'كتالوج الدورات';
	@override String get courseDetail => 'تفاصيل الدورة';
	@override String get videoPlayer => 'مشغل الفيديو';
	@override String get pdfViewer => 'عارض PDF';
	@override late final _TranslationsCourseTabsAr tabs = _TranslationsCourseTabsAr._(_root);
	@override late final _TranslationsCourseCatalogAr catalog = _TranslationsCourseCatalogAr._(_root);
	@override late final _TranslationsCourseDetailAr detail = _TranslationsCourseDetailAr._(_root);
	@override late final _TranslationsCoursePlayerAr player = _TranslationsCoursePlayerAr._(_root);
	@override late final _TranslationsCoursePdfAr pdf = _TranslationsCoursePdfAr._(_root);
	@override late final _TranslationsCourseEmptyAr empty = _TranslationsCourseEmptyAr._(_root);
	@override late final _TranslationsCourseErrorsAr errors = _TranslationsCourseErrorsAr._(_root);
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
	@override String get skip => 'تخطي';
	@override String get next => 'التالي';
	@override String get getStarted => 'ابدأ الآن';
	@override String get backToLogin => 'العودة لتسجيل الدخول';
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

// Path: onboarding.steps
class _TranslationsOnboardingStepsAr implements TranslationsOnboardingStepsEn {
	_TranslationsOnboardingStepsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingStepsLearnAr learn = _TranslationsOnboardingStepsLearnAr._(_root);
	@override late final _TranslationsOnboardingStepsTrackProgressAr trackProgress = _TranslationsOnboardingStepsTrackProgressAr._(_root);
	@override late final _TranslationsOnboardingStepsQuizzesAr quizzes = _TranslationsOnboardingStepsQuizzesAr._(_root);
}

// Path: login.otp
class _TranslationsLoginOtpAr implements TranslationsLoginOtpEn {
	_TranslationsLoginOtpAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'رمز التأكيد';
	@override String get description => 'لقد ارسلنا رمز تأكيد لجوالك. ادخله هنا للمتابعة.';
	@override String get confirm => 'تأكيد';
	@override String get otpWasVerifiedSuccessfully => 'تم التحقق من رمز التأكيد بنجاح';
	@override String get resend => 'اعادة الارسال';
	@override String get resendIn => 'إعادة الإرسال خلال';
	@override String get editNumber => 'تعديل الرقم';
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

// Path: home.dashboard
class _TranslationsHomeDashboardAr implements TranslationsHomeDashboardEn {
	_TranslationsHomeDashboardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get greetingMorning => 'صباح الخير';
	@override String get greetingEvening => 'مساء الخير';
	@override String greetingWithName({required Object greeting, required Object name}) => '${greeting}، ${name} 👋';
	@override String updatedAt({required DateTime time}) => 'تم التحديث ${DateFormat('HH:mm', 'ar').format(time)}';
	@override String get continueLearning => 'استكمل التعلم';
	@override String get featuredCourses => 'الدورات المميزة';
	@override String get announcements => 'الإعلانات';
	@override String get quickActions => 'إجراءات سريعة';
	@override String get walletBalance => 'رصيد المحفظة';
	@override String points({required int count}) => '${count} نقطة';
	@override String get startLearningJourney => 'ابدأ رحلتك التعليمية! تصفح الدورات المتاحة.';
	@override String continueProgress({required num progress}) => 'استكمل ${progress}%';
	@override String get free => 'مجاني';
	@override String get loadingCourse => 'جاري تحميل الدورة';
	@override String get loadingFeaturedCourse => 'جاري تحميل الدورة المميزة';
	@override String get loadingAnnouncement => 'جاري تحميل الإعلان';
	@override String get loadingAnnouncementDetails => 'جاري تحميل تفاصيل الإعلان';
	@override String get unableToLoadTapRetry => 'تعذر التحميل. اضغط لإعادة المحاولة.';
	@override late final _TranslationsHomeDashboardActionsAr actions = _TranslationsHomeDashboardActionsAr._(_root);
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

// Path: course.tabs
class _TranslationsCourseTabsAr implements TranslationsCourseTabsEn {
	_TranslationsCourseTabsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get inProgress => 'قيد التقدم';
	@override String get completed => 'مكتملة';
	@override String get expired => 'منتهية';
	@override String get description => 'الوصف';
	@override String get sessions => 'الحصص';
}

// Path: course.catalog
class _TranslationsCourseCatalogAr implements TranslationsCourseCatalogEn {
	_TranslationsCourseCatalogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'ابحث عن الدورات...';
	@override String get allCategories => 'الكل';
	@override String get sortBy => 'ترتيب حسب';
	@override String get sortNewest => 'الأحدث';
	@override String get sortPriceAsc => 'السعر: من الأقل للأعلى';
	@override String get sortPriceDesc => 'السعر: من الأعلى للأقل';
	@override String get sortPopular => 'الأكثر شعبية';
	@override String get noCourses => 'لا توجد دورات';
	@override String get noCoursesDescription => 'حاول تعديل البحث أو الفلاتر.';
}

// Path: course.detail
class _TranslationsCourseDetailAr implements TranslationsCourseDetailEn {
	_TranslationsCourseDetailAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get aboutCourse => 'عن هذه الدورة';
	@override String get sessions => 'الحصص';
	@override String get items => 'عناصر';
	@override String get enrollNow => 'سجل الآن';
	@override String get enrolled => 'مسجل';
	@override String get continueStudying => 'متابعة الدراسة';
	@override String get courseExpired => 'انتهت صلاحية الدورة';
	@override String get courseCompleted => 'تم إكمال الدورة';
	@override String get free => 'مجاني';
	@override String get students => 'طالب';
	@override String get videos => 'فيديو';
	@override String get duration => 'المدة';
	@override String get minutes => 'دقيقة';
	@override String get hours => 'ساعات';
	@override String get sessionFree => 'مجاني';
	@override String get enrolling => 'جاري التسجيل...';
	@override String get enrollSuccess => 'تم التسجيل بنجاح!';
	@override String get enrollFailed => 'فشل التسجيل. حاول مرة أخرى.';
}

// Path: course.player
class _TranslationsCoursePlayerAr implements TranslationsCoursePlayerEn {
	_TranslationsCoursePlayerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مشغل الفيديو';
	@override String get loading => 'جاري تحميل الفيديو...';
	@override String get error => 'فشل تحميل الفيديو';
	@override String get complete => 'تحديد كمكتمل';
	@override String get completed => 'مكتمل';
}

// Path: course.pdf
class _TranslationsCoursePdfAr implements TranslationsCoursePdfEn {
	_TranslationsCoursePdfAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'عارض PDF';
	@override String get loading => 'جاري تحميل المستند...';
	@override String get error => 'فشل تحميل المستند';
	@override String page({required Object current, required Object total}) => 'صفحة ${current} من ${total}';
	@override String get markComplete => 'تحديد كمكتمل';
	@override String get completed => 'مكتمل';
}

// Path: course.empty
class _TranslationsCourseEmptyAr implements TranslationsCourseEmptyEn {
	_TranslationsCourseEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noEnrolledCourses => 'لا توجد دورات مسجلة';
	@override String get noEnrolledCoursesDescription => 'ابدأ التعلم بتصفح كتالوج الدورات.';
	@override String get browseCatalog => 'تصفح الكتالوج';
}

// Path: course.errors
class _TranslationsCourseErrorsAr implements TranslationsCourseErrorsEn {
	_TranslationsCourseErrorsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get failedToLoad => 'فشل التحميل. اضغط للمحاولة مرة أخرى.';
	@override String get failedToLoadCourses => 'فشل تحميل الدورات';
	@override String get failedToLoadDetail => 'فشل تحميل تفاصيل الدورة';
	@override String get failedToLoadSessions => 'فشل تحميل الحصص';
}

// Path: onboarding.steps.learn
class _TranslationsOnboardingStepsLearnAr implements TranslationsOnboardingStepsLearnEn {
	_TranslationsOnboardingStepsLearnAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تعلّم';
	@override String get description => 'يمكنك الوصول إلى دروسك ودوراتك والمواد التعليمية في مكان واحد.';
}

// Path: onboarding.steps.trackProgress
class _TranslationsOnboardingStepsTrackProgressAr implements TranslationsOnboardingStepsTrackProgressEn {
	_TranslationsOnboardingStepsTrackProgressAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تابع التقدم';
	@override String get description => 'راقب أداءك الأكاديمي وتابع تطورك خطوة بخطوة.';
}

// Path: onboarding.steps.quizzes
class _TranslationsOnboardingStepsQuizzesAr implements TranslationsOnboardingStepsQuizzesEn {
	_TranslationsOnboardingStepsQuizzesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الاختبارات';
	@override String get description => 'اختبر معلوماتك عبر اختبارات تفاعلية واحصل على نتائج فورية.';
}

// Path: home.dashboard.actions
class _TranslationsHomeDashboardActionsAr implements TranslationsHomeDashboardActionsEn {
	_TranslationsHomeDashboardActionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get myCourses => 'دوراتي';
	@override String get attendance => 'الحضور';
	@override String get grades => 'الدرجات';
	@override String get aiAssistant => 'المساعد الذكي';
	@override String get rewards => 'المكافآت';
	@override String get marketplace => 'المتجر';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui.common.cancel' => 'إلغاء',
			'ui.common.ok' => 'موافق',
			'ui.common.viewAll' => 'عرض الكل',
			'ui.common.required' => 'مطلوب',
			'ui.common.optional' => 'اختياري',
			'ui.common.customization' => 'التخصيص',
			'ui.common.skip' => 'تخطي',
			'ui.common.next' => 'التالي',
			'ui.common.getStarted' => 'ابدأ الآن',
			'ui.common.backToLogin' => 'العودة لتسجيل الدخول',
			'ui.errors.somethingWentWrong' => 'حدث خطأ ما',
			'ui.errors.retry' => 'إعادة المحاولة',
			'ui.dateTime.yesterday' => 'أمس',
			'ui.dateTime.today' => 'اليوم',
			'ui.dateTime.now' => 'الآن',
			'ui.dateTime.tomorrow' => 'غدًا',
			'ui.dateTime.time' => ({required DateTime time}) => '${DateFormat('HH:mm', 'ar').format(time)}',
			'ui.dateTime.timeWithDay' => ({required DateTime time, required Object day}) => '${DateFormat('HH:mm', 'ar').format(time)}، ${day}',
			'ui.dateTime.dateWithMonth' => ({required DateTime date}) => '${DateFormat('MMM d', 'ar').format(date)}',
			'ui.dateTime.weekdays.monday' => 'الاثنين',
			'ui.dateTime.weekdays.tuesday' => 'الثلاثاء',
			'ui.dateTime.weekdays.wednesday' => 'الأربعاء',
			'ui.dateTime.weekdays.thursday' => 'الخميس',
			'ui.dateTime.weekdays.friday' => 'الجمعة',
			'ui.dateTime.weekdays.saturday' => 'السبت',
			'ui.dateTime.weekdays.sunday' => 'الأحد',
			'ui.mentorXReadMore.more' => 'المزيد',
			'ui.mentorXReadMore.less' => 'أقل',
			'core.appName' => 'MentorX Student',
			'core.currency' => 'ج.م',
			'core.price' => ({required num amount}) => '${amount} ${_root.core.currency}',
			'core.languages.en' => 'English',
			'core.languages.ar' => 'العربية',
			'initialLanguage.header' => 'يرجى تحديد اللغة المفضلة',
			'initialLanguage.kContinue' => 'موافق',
			'onboarding.steps.learn.title' => 'تعلّم',
			'onboarding.steps.learn.description' => 'يمكنك الوصول إلى دروسك ودوراتك والمواد التعليمية في مكان واحد.',
			'onboarding.steps.trackProgress.title' => 'تابع التقدم',
			'onboarding.steps.trackProgress.description' => 'راقب أداءك الأكاديمي وتابع تطورك خطوة بخطوة.',
			'onboarding.steps.quizzes.title' => 'الاختبارات',
			'onboarding.steps.quizzes.description' => 'اختبر معلوماتك عبر اختبارات تفاعلية واحصل على نتائج فورية.',
			'login.header' => 'ادخل رقم الجوال لتسجيل الدخول',
			'login.subtitle' => 'سنرسل لك رمز تحقق',
			'login.phoneNumber' => 'رقم الجوال',
			'login.phoneHint' => '01XXXXXXXXX',
			'login.phoneValidationError' => 'يرجى إدخال رقم هاتف صحيح',
			'login.signIn' => 'تسجيل الدخول',
			'login.otp.header' => 'رمز التأكيد',
			'login.otp.description' => 'لقد ارسلنا رمز تأكيد لجوالك. ادخله هنا للمتابعة.',
			'login.otp.confirm' => 'تأكيد',
			'login.otp.otpWasVerifiedSuccessfully' => 'تم التحقق من رمز التأكيد بنجاح',
			'login.otp.resend' => 'اعادة الارسال',
			'login.otp.resendIn' => 'إعادة الإرسال خلال',
			'login.otp.editNumber' => 'تعديل الرقم',
			'login.otp.otpWasResentSuccessfully' => 'تم اعادة الارسال بنجاح',
			'home.main.home' => 'الرئيسية',
			'home.main.favorites' => 'المفضلة',
			'home.main.assistance' => 'المساعدة',
			'home.main.cart' => 'السلة',
			'home.main.me' => 'حسابي',
			'home.dashboard.greetingMorning' => 'صباح الخير',
			'home.dashboard.greetingEvening' => 'مساء الخير',
			'home.dashboard.greetingWithName' => ({required Object greeting, required Object name}) => '${greeting}، ${name} 👋',
			'home.dashboard.updatedAt' => ({required DateTime time}) => 'تم التحديث ${DateFormat('HH:mm', 'ar').format(time)}',
			'home.dashboard.continueLearning' => 'استكمل التعلم',
			'home.dashboard.featuredCourses' => 'الدورات المميزة',
			'home.dashboard.announcements' => 'الإعلانات',
			'home.dashboard.quickActions' => 'إجراءات سريعة',
			'home.dashboard.walletBalance' => 'رصيد المحفظة',
			'home.dashboard.points' => ({required int count}) => '${count} نقطة',
			'home.dashboard.startLearningJourney' => 'ابدأ رحلتك التعليمية! تصفح الدورات المتاحة.',
			'home.dashboard.continueProgress' => ({required num progress}) => 'استكمل ${progress}%',
			'home.dashboard.free' => 'مجاني',
			'home.dashboard.loadingCourse' => 'جاري تحميل الدورة',
			'home.dashboard.loadingFeaturedCourse' => 'جاري تحميل الدورة المميزة',
			'home.dashboard.loadingAnnouncement' => 'جاري تحميل الإعلان',
			'home.dashboard.loadingAnnouncementDetails' => 'جاري تحميل تفاصيل الإعلان',
			'home.dashboard.unableToLoadTapRetry' => 'تعذر التحميل. اضغط لإعادة المحاولة.',
			'home.dashboard.actions.myCourses' => 'دوراتي',
			'home.dashboard.actions.attendance' => 'الحضور',
			'home.dashboard.actions.grades' => 'الدرجات',
			'home.dashboard.actions.aiAssistant' => 'المساعد الذكي',
			'home.dashboard.actions.rewards' => 'المكافآت',
			'home.dashboard.actions.marketplace' => 'المتجر',
			'home.errors.failedToLoadUpcomingEvents' => 'فشل تحميل الفاعليات القادمة',
			'home.errors.failedToLoadVendors' => 'فشل تحميل مزودي الخدمات',
			'home.errors.failedToLoadOccasions' => 'فشل تحميل المناسبات',
			'home.errors.failedToLoadCategories' => 'فشل تحميل الأقسام',
			'forms.required' => 'هذا الحقل مطلوب',
			'forms.minLength' => ({required int length}) => 'يجب أن يحتوي على ${length} أحرف على الأقل',
			'forms.maxLength' => ({required int length}) => 'الحد الأقصى هو ${length} أحرف',
			'forms.minDigitsLength' => ({required int length}) => 'يجب أن يحتوي على ${length} أرقام على الأقل',
			'forms.maxDigitsLength' => ({required int length}) => 'الحد الأقصى هو ${length} أرقام',
			'forms.youMustEnterAValidEmail' => 'يجب إدخال بريد إلكتروني صحيح',
			'forms.card.expiryInvalidFormat' => 'صيغة غير صحيحة. استخدم MM/YY',
			'forms.card.expiryInvalidMonth' => 'شهر غير صحيح (01-12)',
			'forms.card.expiryCardExpired' => 'انتهت صلاحية البطاقة',
			'forms.card.cvvInvalid' => 'يجب أن يكون CVV من 3-4 أرقام',
			'exceptions.unknown' => 'خطأ غير معروف',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'خطأ غير معروف',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'رقم الجوال غير صحيح',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'رمز OTP غير صحيح',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'فشل التحميل',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'فشل ارسال رمز ال OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'فشل التحقق من رمز ال OTP',
			'exceptions.promocodeExceptions.cantBeApplied' => 'لا يمكن تطبيق الرمز الترويجي على سلتك',
			'countries.afghanistan' => 'أفغانستان',
			'countries.albania' => 'ألبانيا',
			'countries.algeria' => 'الجزائر',
			'countries.andorra' => 'أندورا',
			'countries.angola' => 'أنغولا',
			'countries.antiguaAndBarbuda' => 'أنتيغوا وباربودا',
			'countries.argentina' => 'الأرجنتين',
			'countries.armenia' => 'أرمينيا',
			'countries.australia' => 'أستراليا',
			'countries.austria' => 'النمسا',
			'countries.azerbaijan' => 'أذربيجان',
			'countries.bahamas' => 'جزر البهاما',
			'countries.bahrain' => 'البحرين',
			'countries.bangladesh' => 'بنغلاديش',
			'countries.barbados' => 'بربادوس',
			'countries.belarus' => 'بيلاروسيا',
			'countries.belgium' => 'بلجيكا',
			'countries.belize' => 'بليز',
			'countries.benin' => 'بنين',
			'countries.bhutan' => 'بوتان',
			'countries.bolivia' => 'بوليفيا',
			'countries.bosniaAndHerzegovina' => 'البوسنة والهرسك',
			'countries.botswana' => 'بوتسوانا',
			'countries.brazil' => 'البرازيل',
			'countries.brunei' => 'بروناي',
			'countries.bulgaria' => 'بلغاريا',
			'countries.burkinaFaso' => 'بوركينا فاسو',
			'countries.burundi' => 'بوروندي',
			'countries.cambodia' => 'كمبوديا',
			'countries.cameroon' => 'الكاميرون',
			'countries.canada' => 'كندا',
			'countries.capeVerde' => 'الرأس الأخضر',
			'countries.centralAfricanRepublic' => 'جمهورية أفريقيا الوسطى',
			'countries.chad' => 'تشاد',
			'countries.chile' => 'تشيلي',
			'countries.china' => 'الصين',
			'countries.colombia' => 'كولومبيا',
			'countries.comoros' => 'جزر القمر',
			'countries.congo' => 'الكونغو',
			'countries.democraticRepublicOfCongo' => 'جمهورية الكونغو الديمقراطية',
			'countries.costaRica' => 'كوستاريكا',
			'countries.croatia' => 'كرواتيا',
			'countries.cuba' => 'كوبا',
			'countries.cyprus' => 'قبرص',
			'countries.czechRepublic' => 'جمهورية التشيك',
			'countries.denmark' => 'الدنمارك',
			'countries.djibouti' => 'جيبوتي',
			'countries.dominica' => 'دومينيكا',
			'countries.dominicanRepublic' => 'جمهورية الدومينيكان',
			'countries.ecuador' => 'الإكوادور',
			'countries.egypt' => 'مصر',
			'countries.elSalvador' => 'السلفادور',
			'countries.equatorialGuinea' => 'غينيا الاستوائية',
			'countries.eritrea' => 'إريتريا',
			'countries.estonia' => 'إستونيا',
			'countries.eswatini' => 'إسواتيني',
			'countries.ethiopia' => 'إثيوبيا',
			'countries.fiji' => 'فيجي',
			'countries.finland' => 'فنلندا',
			'countries.france' => 'فرنسا',
			'countries.gabon' => 'الغابون',
			'countries.gambia' => 'غامبيا',
			'countries.georgia' => 'جورجيا',
			'countries.germany' => 'ألمانيا',
			'countries.ghana' => 'غانا',
			'countries.greece' => 'اليونان',
			'countries.grenada' => 'غرينادا',
			'countries.guatemala' => 'غواتيمالا',
			'countries.guinea' => 'غينيا',
			'countries.guineaBissau' => 'غينيا بيساو',
			'countries.guyana' => 'غيانا',
			'countries.haiti' => 'هايتي',
			'countries.honduras' => 'هندوراس',
			'countries.hungary' => 'المجر',
			'countries.iceland' => 'آيسلندا',
			'countries.india' => 'الهند',
			'countries.indonesia' => 'إندونيسيا',
			'countries.iran' => 'إيران',
			'countries.iraq' => 'العراق',
			'countries.ireland' => 'أيرلندا',
			'countries.israel' => 'إسرائيل',
			'countries.italy' => 'إيطاليا',
			'countries.ivoryCoast' => 'ساحل العاج',
			'countries.jamaica' => 'جامايكا',
			'countries.japan' => 'اليابان',
			'countries.jordan' => 'الأردن',
			'countries.kazakhstan' => 'كازاخستان',
			'countries.kenya' => 'كينيا',
			'countries.kiribati' => 'كيريباتي',
			'countries.kuwait' => 'الكويت',
			'countries.kyrgyzstan' => 'قيرغيزستان',
			'countries.laos' => 'لاوس',
			'countries.latvia' => 'لاتفيا',
			'countries.lebanon' => 'لبنان',
			'countries.lesotho' => 'ليسوتو',
			'countries.liberia' => 'ليبيريا',
			'countries.libya' => 'ليبيا',
			'countries.liechtenstein' => 'ليختنشتاين',
			'countries.lithuania' => 'ليتوانيا',
			'countries.luxembourg' => 'لوكسمبورغ',
			'countries.madagascar' => 'مدغشقر',
			'countries.malawi' => 'ملاوي',
			'countries.malaysia' => 'ماليزيا',
			'countries.maldives' => 'جزر المالديف',
			'countries.mali' => 'مالي',
			'countries.malta' => 'مالطا',
			'countries.marshallIslands' => 'جزر مارشال',
			'countries.mauritania' => 'موريتانيا',
			'countries.mauritius' => 'موريشيوس',
			'countries.mexico' => 'المكسيك',
			'countries.micronesia' => 'ميكرونيزيا',
			'countries.moldova' => 'مولدوفا',
			'countries.monaco' => 'موناكو',
			'countries.mongolia' => 'منغوليا',
			'countries.montenegro' => 'الجبل الأسود',
			'countries.morocco' => 'المغرب',
			'countries.mozambique' => 'موزمبيق',
			'countries.myanmar' => 'ميانمار',
			'countries.namibia' => 'ناميبيا',
			'countries.nauru' => 'ناورو',
			'countries.nepal' => 'نيبال',
			'countries.netherlands' => 'هولندا',
			'countries.newZealand' => 'نيوزيلندا',
			'countries.nicaragua' => 'نيكاراغوا',
			'countries.niger' => 'النيجر',
			'countries.nigeria' => 'نيجيريا',
			'countries.northKorea' => 'كوريا الشمالية',
			'countries.northMacedonia' => 'مقدونيا الشمالية',
			'countries.norway' => 'النرويج',
			'countries.oman' => 'عمان',
			'countries.pakistan' => 'باكستان',
			'countries.palau' => 'بالاو',
			'countries.palestine' => 'فلسطين',
			'countries.panama' => 'بنما',
			'countries.papuaNewGuinea' => 'بابوا غينيا الجديدة',
			'countries.paraguay' => 'باراغواي',
			'countries.peru' => 'بيرو',
			'countries.philippines' => 'الفلبين',
			'countries.poland' => 'بولندا',
			'countries.portugal' => 'البرتغال',
			'countries.qatar' => 'قطر',
			'countries.romania' => 'رومانيا',
			'countries.russia' => 'روسيا',
			'countries.rwanda' => 'رواندا',
			'countries.saintKittsAndNevis' => 'سانت كيتس ونيفيس',
			'countries.saintLucia' => 'سانت لوسيا',
			'countries.saintVincentAndTheGrenadines' => 'سانت فنسنت وجزر غرينادين',
			'countries.samoa' => 'ساموا',
			'countries.sanMarino' => 'سان مارينو',
			'countries.saoTomeAndPrincipe' => 'ساو تومي وبرينسيبي',
			'countries.saudiArabia' => 'المملكة العربية السعودية',
			'countries.senegal' => 'السنغال',
			'countries.serbia' => 'صربيا',
			'countries.seychelles' => 'سيشل',
			'countries.sierraLeone' => 'سيراليون',
			'countries.singapore' => 'سنغافورة',
			'countries.slovakia' => 'سلوفاكيا',
			'countries.slovenia' => 'سلوفينيا',
			'countries.solomonIslands' => 'جزر سليمان',
			'countries.somalia' => 'الصومال',
			'countries.southAfrica' => 'جنوب أفريقيا',
			'countries.southKorea' => 'كوريا الجنوبية',
			'countries.southSudan' => 'جنوب السودان',
			'countries.spain' => 'إسبانيا',
			'countries.sriLanka' => 'سريلانكا',
			'countries.sudan' => 'السودان',
			'countries.suriname' => 'سورينام',
			'countries.sweden' => 'السويد',
			'countries.switzerland' => 'سويسرا',
			'countries.syria' => 'سوريا',
			'countries.taiwan' => 'تايوان',
			'countries.tajikistan' => 'طاجيكستان',
			'countries.tanzania' => 'تنزانيا',
			'countries.thailand' => 'تايلاند',
			'countries.timor' => 'تيمور الشرقية',
			'countries.togo' => 'توغو',
			'countries.tonga' => 'تونغا',
			'countries.trinidadAndTobago' => 'ترينيداد وتوباغو',
			'countries.tunisia' => 'تونس',
			'countries.turkey' => 'تركيا',
			'countries.turkmenistan' => 'تركمانستان',
			'countries.tuvalu' => 'توفالو',
			'countries.uganda' => 'أوغندا',
			'countries.ukraine' => 'أوكرانيا',
			'countries.unitedArabEmirates' => 'الإمارات العربية المتحدة',
			'countries.unitedKingdom' => 'المملكة المتحدة',
			'countries.unitedStates' => 'الولايات المتحدة الأمريكية',
			'countries.uruguay' => 'أوروغواي',
			'countries.uzbekistan' => 'أوزبكستان',
			'countries.vanuatu' => 'فانواتو',
			'countries.vaticanCity' => 'الفاتيكان',
			'countries.venezuela' => 'فنزويلا',
			'countries.vietnam' => 'فيتنام',
			'countries.yemen' => 'اليمن',
			'countries.zambia' => 'زامبيا',
			'countries.zimbabwe' => 'زيمبابوي',
			'accountStatus.pendingTitle' => 'الحساب قيد المراجعة',
			'accountStatus.pendingDescription' => 'حسابك قيد المراجعة حالياً. سنقوم بإعلامك فور الموافقة.',
			'accountStatus.pendingSupportInfo' => 'إذا كان لديك أي استفسار، يرجى التواصل مع الدعم.',
			'accountStatus.rejectedTitle' => 'تم رفض الحساب',
			'accountStatus.rejectedDescription' => 'للأسف، تم رفض طلب حسابك.',
			'accountStatus.rejectedReason' => 'يرجى التواصل مع الدعم لمعرفة المزيد عن السبب.',
			'accountStatus.blockedTitle' => 'الحساب محظور',
			'accountStatus.blockedDescription' => 'تم حظر حسابك. يرجى التواصل مع الدعم للمساعدة.',
			'accountStatus.blockedSupportInfo' => 'إذا كنت تعتقد أن هذا خطأ، يرجى التواصل مع فريق الدعم.',
			'cart.yourCart' => 'سلتك',
			'cart.emptyCart' => 'سلتك فارغة',
			'cart.browseServices' => 'تصفح الخدمات',
			'cart.browseOfferings' => 'تصفح عروضنا \nلإضافة عناصر إلى سلتك',
			'cart.weRecommend' => 'نوصي بـ',
			'cart.edit' => 'تعديل',
			'cart.remove' => 'إزالة',
			'cart.addToCart' => 'أضف إلى السلة',
			'cart.close' => 'إغلاق',
			'cart.itemDateTime' => ({required DateTime date}) => '${DateFormat('MMM dd, hh:mm', 'ar').format(date)}',
			'cart.hour' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'ساعة', one: 'ساعة', other: 'ساعات', ), 
			'cart.dontForgetToAdd' => 'لا تنسَ الإضافة',
			'cart.services' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, one: 'خدمة', other: 'خدمات', ), 
			'cart.total' => 'الإجمالي',
			'cart.promocode.header' => 'رمز ترويجي',
			'cart.promocode.hint' => 'أدخل الرمز الترويجي',
			'cart.promocode.promocodeApplied' => 'تم تطبيق الرمز الترويجي',
			'cart.promocode.promocodeCannotBeApplied' => 'لا يمكن تطبيق الرمز الترويجي على سلتك',
			'cart.updateInCart' => 'تحديث في السلة',
			'cart.cart' => 'سلة',
			'cart.checkout' => 'إتمام الشراء',
			'cart.apply' => 'تطبيق',
			'cart.applyPromocode' => 'تطبيق كود الخصم',
			'cart.enterPromocode' => 'أدخل كود الخصم',
			'cart.promocodeRequired' => 'كود الخصم مطلوب',
			'cart.appliedPromocodes' => 'أكواد الخصم المطبقة',
			'cart.recommendations' => 'التوصيات',
			'cart.subtotal' => 'المجموع الفرعي',
			'cart.discount' => 'الخصم',
			'cart.minOrder' => 'الحد الأدنى للطلب',
			'cart.minTime' => 'الحد الأدنى للوقت',
			'cart.spaceRequired' => 'المساحة المطلوبة',
			'cart.hours' => 'ساعات',
			'cart.specialRequests' => 'طلبات خاصة',
			'cart.enterSpecialRequests' => 'أدخل الطلبات الخاصة...',
			'cart.errorLoadingCart' => 'خطأ في تحميل السلة',
			'cart.cartCleared' => 'تم مسح السلة بنجاح',
			'cart.failedToLoadService' => 'فشل تحميل الخدمة',
			'cart.pleaseSelectOption' => ({required Object sectionName}) => 'يرجى اختيار ${sectionName}',
			'cart.pleaseSelectAtLeastOne' => ({required Object sectionName}) => 'يرجى اختيار خيار ${sectionName} واحد على الأقل',
			'cart.pleaseSelectMore' => ({required Object sectionName}) => 'يرجى اختيار المزيد من خيارات ${sectionName}',
			'cart.tooManyOptionsSelected' => ({required Object sectionName}) => 'تم اختيار عدد كبير جداً من خيارات ${sectionName}',
			'cart.pleaseAddAtLeastOne' => ({required Object sectionName}) => 'يرجى إضافة عنصر ${sectionName} واحد على الأقل',
			'cart.pleaseSelectDateTime' => 'يرجى اختيار التاريخ والوقت',
			'cart.canapeOptions' => 'خيارات الكانابيه',
			'cart.options' => 'خيارات',
			'cart.startDateAndTime' => 'تاريخ ووقت البدء',
			'cart.perExtraHour' => 'لكل ساعة إضافية',
			'cart.goToVendorProfile' => ({required Object vendorName}) => 'انتقل إلى ملف ${vendorName}',
			'settings.title' => 'إعدادات التطبيق',
			'settings.language' => 'اللغة',
			'settings.notifications' => 'الإشعارات',
			'settings.notificationSettings.title' => 'الإشعارات',
			'settings.notificationSettings.common' => 'عام',
			'settings.notificationSettings.generalNotification' => 'الإشعار العام',
			'settings.notificationSettings.sound' => 'الصوت',
			'settings.notificationSettings.vibrate' => 'الاهتزاز',
			'settings.notificationSettings.systemAndServicesUpdate' => 'التحديثات والخدمات',
			'settings.notificationSettings.appUpdates' => 'تحديثات التطبيق',
			'settings.notificationSettings.billReminder' => 'تذكير الفاتورة',
			'settings.notificationSettings.promotion' => 'العروض الترويجية',
			'settings.notificationSettings.discountAvailable' => 'الخصومات المتاحة',
			'settings.notificationSettings.paymentRequest' => 'طلب الدفع',
			'course.myCourses' => 'دوراتي',
			'course.courseCatalog' => 'كتالوج الدورات',
			'course.courseDetail' => 'تفاصيل الدورة',
			'course.videoPlayer' => 'مشغل الفيديو',
			'course.pdfViewer' => 'عارض PDF',
			'course.tabs.inProgress' => 'قيد التقدم',
			'course.tabs.completed' => 'مكتملة',
			'course.tabs.expired' => 'منتهية',
			'course.tabs.description' => 'الوصف',
			'course.tabs.sessions' => 'الحصص',
			'course.catalog.searchHint' => 'ابحث عن الدورات...',
			'course.catalog.allCategories' => 'الكل',
			'course.catalog.sortBy' => 'ترتيب حسب',
			'course.catalog.sortNewest' => 'الأحدث',
			'course.catalog.sortPriceAsc' => 'السعر: من الأقل للأعلى',
			'course.catalog.sortPriceDesc' => 'السعر: من الأعلى للأقل',
			'course.catalog.sortPopular' => 'الأكثر شعبية',
			'course.catalog.noCourses' => 'لا توجد دورات',
			'course.catalog.noCoursesDescription' => 'حاول تعديل البحث أو الفلاتر.',
			'course.detail.aboutCourse' => 'عن هذه الدورة',
			'course.detail.sessions' => 'الحصص',
			'course.detail.items' => 'عناصر',
			'course.detail.enrollNow' => 'سجل الآن',
			'course.detail.enrolled' => 'مسجل',
			'course.detail.continueStudying' => 'متابعة الدراسة',
			'course.detail.courseExpired' => 'انتهت صلاحية الدورة',
			'course.detail.courseCompleted' => 'تم إكمال الدورة',
			'course.detail.free' => 'مجاني',
			'course.detail.students' => 'طالب',
			'course.detail.videos' => 'فيديو',
			'course.detail.duration' => 'المدة',
			'course.detail.minutes' => 'دقيقة',
			'course.detail.hours' => 'ساعات',
			'course.detail.sessionFree' => 'مجاني',
			'course.detail.enrolling' => 'جاري التسجيل...',
			'course.detail.enrollSuccess' => 'تم التسجيل بنجاح!',
			'course.detail.enrollFailed' => 'فشل التسجيل. حاول مرة أخرى.',
			'course.player.title' => 'مشغل الفيديو',
			'course.player.loading' => 'جاري تحميل الفيديو...',
			'course.player.error' => 'فشل تحميل الفيديو',
			'course.player.complete' => 'تحديد كمكتمل',
			'course.player.completed' => 'مكتمل',
			'course.pdf.title' => 'عارض PDF',
			'course.pdf.loading' => 'جاري تحميل المستند...',
			'course.pdf.error' => 'فشل تحميل المستند',
			'course.pdf.page' => ({required Object current, required Object total}) => 'صفحة ${current} من ${total}',
			'course.pdf.markComplete' => 'تحديد كمكتمل',
			'course.pdf.completed' => 'مكتمل',
			'course.empty.noEnrolledCourses' => 'لا توجد دورات مسجلة',
			'course.empty.noEnrolledCoursesDescription' => 'ابدأ التعلم بتصفح كتالوج الدورات.',
			'course.empty.browseCatalog' => 'تصفح الكتالوج',
			'course.errors.failedToLoad' => 'فشل التحميل. اضغط للمحاولة مرة أخرى.',
			'course.errors.failedToLoadCourses' => 'فشل تحميل الدورات',
			'course.errors.failedToLoadDetail' => 'فشل تحميل تفاصيل الدورة',
			'course.errors.failedToLoadSessions' => 'فشل تحميل الحصص',
			_ => null,
		};
	}
}
