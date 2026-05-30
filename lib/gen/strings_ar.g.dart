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
	@override Map<String, dynamic> get student => {
		'aiAssistant': 'المساعد الذكي',
		'aiSubtitle': 'مساعد AI للفيزياء',
		'aiWelcome': 'أهلاً بك! أنا المساعد الذكي للفيزياء. اسألني أي سؤال!',
		'typeQuestion': 'اكتب سؤالك هنا...',
		'analytics': _TranslationsStudentAnalyticsAr._(_root),
		'assignmentDetail': 'تفاصيل الواجب',
		'assignmentTitle': 'واجب الموجات',
		'assignmentUnit': 'الوحدة الثالثة - الحصة 2',
		'deadline': 'آخر موعد',
		'maxScore': 'الدرجة',
		'points': 'درجة',
		'instructionsLabel': 'التعليمات:',
		'assignmentInstructions': 'حل المسائل التالية على الموجات الميكانيكية. يجب حل جميع المسائل وتوضيح خطوات الحل كاملة.',
		'assignmentFile': 'ملف الواجب',
		'submitAssignment': 'تسليم الواجب',
		'uploadFile': 'اضغط لرفع الملف',
		'uploadHint': 'PDF, صور (حد أقصى 10 MB)',
		'notesOptional': 'ملاحظات (اختياري):',
		'notesHint': 'أضف ملاحظة للمحاضر...',
		'feedbackTitle': 'التعليقات',
		'instructorFeedback': 'تعليق المحاضر:',
		'registerAttendance': 'تسجيل الحضور',
		'attendanceHistory': 'سجل الحضور',
		'yourAttendanceCode': 'كود الحضور الخاص بك',
		'exitQuizTitle': 'خروج من الواجب؟',
		'exitQuizDesc': 'لن يتم حفظ تقدمك. هل أنت متأكد أنك تريد الخروج؟',
		'cancel': 'إلغاء',
		'exit': 'خروج',
		'yourResponse': 'إجابتك',
		'writeResponse': 'اكتب إجابتك هنا...',
		'responseHint': 'ابدأ الكتابة...',
		'attachments': 'المرفقات',
		'noFiles': 'لا توجد ملفات مرفقة بعد',
		'chooseCorrect': 'اختر الإجابة الصحيحة:',
		'questionLabel': 'سؤال',
		'assignmentSubmitted': 'تم تسليم الواجب بنجاح',
		'alreadySubmitted': 'لقد قمت بتسليم هذا الواجب بالفعل',
		'assignmentNotFound': 'الواجب غير موجود',
		'commonBack': 'رجوع',
		'commonNext': 'التالي',
		'commonPrevious': 'السابق',
		'commonSubmit': 'إرسال',
		'review': 'مراجعة',
		'quizNotFound': 'الاختبار غير موجود',
		'noQuestions': 'لا توجد أسئلة متاحة',
		'yourAnswer': 'إجابتك:',
		'typeAnswerHere': 'اكتب إجابتك هنا...',
		'showCodeInstruction': 'اعرض الكود للمحاضر أو المساعد لتسجيل حضورك',
		'codeValidFor': 'الكود صالح لمدة 5 دقايق',
		'viewAttendance': 'سجل الحضور',
		'totalAttendance': 'نسبة الحضور الكلية',
		'present': 'حاضر',
		'absent': 'غائب',
		'presentCount': '%s حضور',
		'absentCount': '%s غياب',
		'loginWelcome': 'أهلاً بيك! سجّل دخولك',
		'phoneLabel': 'رقم الموبايل',
		'phoneHint': '01xxxxxxxxx',
		'passwordLabel': 'كلمة المرور',
		'passwordHintLogin': '••••••••',
		'forgotPassword': 'نسيت كلمة المرور؟',
		'loginButton': 'تسجيل الدخول',
		'newStudentPrompt': 'طالب جديد؟',
		'registerHere': 'سجّل هنا',
		'phoneNotRegisteredLogin': 'الرقم ده مش مسجّل عندنا. لو طالب جديد سجّل من تحت.',
		'wrongPasswordLogin': 'رقمك أو الباسورد غلط. راجع بياناتك أو غيّر كلمة المرور.',
		'registerHintFromLogin': 'لو أنت طالب جديد، سجّل من هنا',
		'registerTitle': 'إنشاء حساب جديد',
		'stepLabel1': 'الخطوة 1 من 6 - البيانات الشخصية',
		'stepLabel2': 'الخطوة 2 من 6 - بيانات التواصل',
		'stepLabel3': 'الخطوة 3 من 6 - البيانات الدراسية',
		'stepLabel4': 'الخطوة 4 من 6 - نوع الدراسة',
		'stepLabel5': 'الخطوة 5 من 6 - كلمة المرور والصور',
		'stepLabel6': 'الخطوة 6 من 6 - تأكيد رقم الهاتف',
		'studentPhoneLabel': 'رقم هاتف الطالب',
		'phoneValidationError': 'رقم الموبايل لازم يكون 11 رقم ويبدأ بـ 01.',
		'otpVerifyTitle': 'تأكيد رقم الهاتف',
		'otpSentWhatsapp': 'تم إرسال كود التحقق على واتساب على الرقم',
		'resendCode': 'إعادة إرسال الكود',
		'resendIn': 'إعادة الإرسال خلال',
		'editNumber': 'تعديل الرقم',
		'verifyOtp': 'تأكيد الكود',
		'fullNameLabel': 'الاسم رباعي',
		'firstNameLabel': 'الاسم الأول',
		'secondNameLabel': 'الاسم الثاني',
		'thirdNameLabel': 'الاسم الثالث',
		'fourthNameLabel': 'الاسم الرابع',
		'birthDateLabel': 'تاريخ الميلاد',
		'birthDateHint': 'اختر التاريخ',
		'genderLabel': 'النوع',
		'genderMale': 'ذكر',
		'genderFemale': 'أنثى',
		'parentNameLabel': 'اسم ولي الأمر',
		'parentPhoneLabel': 'رقم هاتف ولي الأمر',
		'parentVerified': 'تم تأكيد رقم ولي الأمر',
		'verifyParentPhone': 'تأكيد رقم ولي الأمر',
		'parentOtpSent': 'تم إرسال كود التحقق لولي الأمر على واتساب',
		'parentOtpRequired': 'لازم تأكد رقم ولي الأمر الأول.',
		'passwordHintRegister': 'أدخل كلمة المرور (8 حروف على الأقل)',
		'confirmPasswordLabel': 'تأكيد كلمة المرور',
		'confirmPasswordHintRegister': 'أعد إدخال كلمة المرور',
		'passwordRules': 'كلمة المرور لازم تكون 8 حروف أو أرقام على الأقل.',
		'passwordRulesHint': 'حد أدنى 8 أحرف أو أرقام.',
		'uploadPhotosLabel': 'ارفع الصور المطلوبة',
		'personalPhotoLabel': 'صورة شخصية',
		'nationalIdPhotoLabel': 'بطاقة الطالب',
		'studyTypeLabel': 'اختر نوع الدراسة',
		'studyTypeCenter': 'طالب سنتر (حضور)',
		'studyTypeOnline': 'طالب أونلاين',
		'scheduleLabel': 'اختر الميعاد',
		'onlineConfirmation': 'هيوصلك تفاصيل الأونلاين بعد الموافقة.',
		'dayFriday': 'جمعة',
		'daySaturday': 'سبت',
		'daySunday': 'أحد',
		'centerSmartMaadi': 'سنتر سمارت - المعادي',
		'centerNoorNasr': 'سنتر النور - مدينة نصر',
		'centerElmHaram': 'سنتر العلم - الهرم',
		'timeSlot1': '6:00 م - 8:00 م',
		'timeSlot2': '4:00 م - 6:00 م',
		'timeSlot3': '5:00 م - 7:00 م',
		'governorateLabel': 'المحافظة',
		'governorateHint': 'اختر المحافظة',
		'governorateCairo': 'القاهرة',
		'governorateGiza': 'الجيزة',
		'governorateAlex': 'الإسكندرية',
		'governorateMansura': 'المنصورة',
		'regionLabel': 'المنطقة',
		'regionHint': 'اختر المنطقة',
		'regionNasrCity': 'مدينة نصر',
		'regionMaadi': 'المعادي',
		'regionHaram': 'الهرم',
		'regionShorouk': 'الشروق',
		'regionDokki': 'الدقي',
		'regionSheikhZayed': 'الشيخ زايد',
		'regionSmouha': 'سموحة',
		'regionGleem': 'جليم',
		'gradeLabel': 'الصف الدراسي',
		'gradeHint': 'اختر الصف',
		'gradeFirstSecondary': 'أولى ثانوي',
		'gradeSecondSecondary': 'تانية ثانوي',
		'gradeThirdSecondary': 'تالتة ثانوي',
		'schoolNameLabel': 'اسم المدرسة',
		'schoolNameHint': 'أدخل اسم المدرسة',
		'educationAdminLabel': 'الإدارة التعليمية',
		'educationAdminHint': 'أدخل الإدارة التعليمية',
		'selectTeacherLabel': 'اختر المدرس',
		'teacherInfoNote': 'المحتوى والكورسات والكويزات هتكون مخصصة للمدرس اللي اخترته',
		'teacher1Name': 'أ. أحمد',
		'teacher1Subject': 'فيزياء',
		'teacher2Name': 'أ. محمد',
		'teacher2Subject': 'كيمياء',
		'teacher3Name': 'أ. خالد',
		'teacher3Subject': 'رياضيات',
		'contactInfoLabel': 'بيانات التواصل',
		'passwordAndPhotosLabel': 'كلمة المرور والصور',
		'confirmAndCreateAccount': 'تأكيد وإنشاء الحساب',
		'submissionTitle': 'تم استلام طلبك',
		'submissionDescription': 'حسابك دلوقتي قيد المراجعة. هيوصلك رسالة واتساب بكل التفاصيل بعد الموافقة.',
		'whatsappDetailsTitle': 'الرسالة هتحتوي على:',
		'studentCodeLabel': 'كود الطالب',
		'firstClassLabel': 'ميعاد أول حصة',
		'firstClassDate': 'الجمعة 10:00 ص',
		'centerLocationLabel': 'مكان السنتر',
		'groupLinkLabel': 'لينك جروب واتساب',
		'groupLinkValue': 'whatsapp.com/invite/MentorX',
		'socialLinksLabel': 'روابط السوشيال',
		'socialLinksValue': 'facebook.com/MentorX | instagram.com/MentorX',
		'submitRegistration': 'إرسال التسجيل',
		'pendingTitle': 'الحساب قيد المراجعة',
		'pendingDescription': 'حسابك لسه بيتراجع دلوقتي. لأي استفسار كلّم الدعم.',
		'whatsappSupport': 'تواصل واتساب',
		'supportPhoneLabel': 'رقم الدعم',
		'supportPhoneValue': '01127798986',
		'backToLogin': 'رجوع لتسجيل الدخول',
		'rejectedTitle': 'تم رفض طلبك',
		'rejectedDescription': 'للأسف تم رفض طلب التسجيل. تقدر تعدّل بياناتك وتقدّم تاني.',
		'rejectedReason': 'السبب: صورة البطاقة مش واضحة. ارفع صورة أوضح وقدّم تاني.',
		'editAndResubmit': 'عدّل البيانات وقدّم تاني',
		'backLabel': 'رجوع',
		'blockedTitle': 'الحساب محظور',
		'blockedDescription': 'حسابك محظور. لأي استفسار كلّم الدعم.',
		'deviceLimitTitle': 'مسجّل على جهاز تاني',
		'deviceLimitDescription': 'حسابك مفتوح على جهاز تاني. لازم تعمل تسجيل خروج من الجهاز التاني الأول، أو كلّم الدعم.',
		'deviceRegisteredLabel': 'الجهاز المسجل',
		'deviceRegisteredValue': 'Iphone 13 pro max',
		'contactTechSupport': 'تواصل مع الدعم الفني',
		'forgotTitle': 'نسيت كلمة المرور',
		'forgotHeading': 'استعادة كلمة المرور',
		'forgotDescription': 'أدخل رقم موبايلك المسجل وهنبعتلك كود التحقق على واتساب',
		'sendCode': 'ابعت كود التحقق',
		'resetTitle': 'تغيير كلمة المرور',
		'resetHeading': 'كلمة مرور جديدة',
		'resetDescription': 'أدخل كلمة المرور الجديدة',
		'newPasswordLabel': 'كلمة المرور الجديدة',
		'newPasswordHint': 'أدخل كلمة المرور الجديدة',
		'savePassword': 'حفظ كلمة المرور',
		'requiredField': 'الحقل ده مطلوب.',
		'incorrectCredentials': 'الرقم أو كلمة المرور غلط.',
		'deviceMismatch': 'أنت مسجّل على جهاز تاني. اعمل تسجيل خروج من الجهاز التاني الأول.',
		'phoneAlreadyRegistered': 'رقمك مسجل قبل كده. جرّب تسجّل دخول.',
		'phoneNotRegistered': 'الرقم ده مش مسجل.',
		'passwordMismatch': 'كلمتا المرور مش متطابقين.',
		'idMissing': 'لازم ترفع الصور المطلوبة.',
		'otpError': 'اكتب الكود كامل.',
		'appName': 'MentorX',
		'platformTagline': '',
		'splashTagline': 'علّم • نظّم • وصّل',
		'commonSkip': 'تخطي',
		'commonStartNow': 'ابدأ دلوقتي',
		'commonOr': 'أو',
		'commonSave': 'حفظ',
		'commonCancel': 'إلغاء',
		'commonConfirm': 'تأكيد',
		'commonDone': 'تم',
		'commonClose': 'إغلاق',
		'commonSearch': 'بحث',
		'commonSeeAll': 'عرض الكل',
		'commonLoading': 'جاري التحميل...',
		'commonError': 'حصل خطأ',
		'commonRetry': 'حاول تاني',
		'commonYes': 'أيوه',
		'commonNo': 'لأ',
		'commonDelete': 'حذف',
		'commonEdit': 'تعديل',
		'egp': 'ج.م',
		'coursesTitle': 'الدروس',
		'coursePhysics': 'الفيزياء - تالتة ثانوي',
		'unitPrefix': 'الوحدة',
		'sessions': 'حصص',
		'completed': 'مكتمل',
		'locked': 'مقفول',
		'inProgress': 'جاري',
		'sessionsTab': 'الحصص',
		'quizzesTab': 'الكويزات',
		'assignmentsTab': 'الواجبات',
		'filesTab': 'ملفات',
		'minutes': 'دقيقة',
		'video': 'فيديو',
		'pdf': 'PDF',
		'quiz': 'كويز',
		'assignment': 'واجب',
		'free': 'مجاني',
		'open': 'مفتوح',
		'premium': 'مدفوع',
		'lessonExplanation': 'شرح الدرس',
		'part1': 'الجزء الأول',
		'part2': 'الجزء الثاني',
		'lessonSummary': 'ملخص الدرس',
		'quickQuiz': 'كويز سريع',
		'lessonAssignment': 'واجب الدرس',
		'submissionRequired': 'مطلوب تسليم',
		'pages': 'صفحات',
		'questions': 'أسئلة',
		'videoViews': 'مشاهدات',
		'videoDuration': 'المدة',
		'pdfPageOf': 'من',
		'lockedContentTitle': 'هذا المحتوى مقفول',
		'lockedContentDesc': 'يمكنك فتح هذا المحتوى عن طريق الشراء من المحفظة أو إدخال كود الحصة',
		'buyFor': 'شراء بـ',
		'enterCode': 'إدخال كود',
		'unitMechanics': 'الوحدة الأولى: الميكانيكا',
		'unitElectricity': 'الوحدة الثانية: الكهربية',
		'unitWaves': 'الوحدة الثالثة: الموجات',
		'unitDynamics': 'الوحدة الرابعة: الديناميكا',
		'unitHeat': 'الوحدة الخامسة: الحرارة',
		'introToWaves': 'مقدمة في الموجات',
		'typesOfWaves': 'أنواع الموجات',
		'waveProperties': 'خصائص الموجات',
		'soundWaves': 'الموجات الصوتية',
		'reviewAndPractice': 'مراجعة وتدريبات',
		'dashboardTitle': 'الصفحة الرئيسية',
		'welcome': 'أهلاً',
		'homeGreeting': 'أهلاً بك',
		'homeTitle': 'الصفحة الرئيسية',
		'myLessons': 'حصصي',
		'myExams': 'امتحاناتي',
		'myGrades': 'درجاتي',
		'wallet': 'المحفظة',
		'notifications': 'الإشعارات',
		'settings': 'الإعدادات',
		'noLessonsToday': 'مفيش حصص النهاردة',
		'upcomingLessons': 'الحصص القادمة',
		'attendance': 'الحضور',
		'profile': 'الملف الشخصي',
		'logout': 'تسجيل خروج',
		'myCourses': 'كورساتي',
		'aiChat': 'المساعد الذكي',
		'attendanceRate': 'نسبة الحضور',
		'averageScore': 'متوسط الدرجات',
		'pendingAssignments': 'واجبات معلقة',
		'walletBalance': 'رصيد المحفظة',
		'quickActions': 'إجراءات سريعة',
		'navHome': 'الرئيسية',
		'navCourses': 'الدروس',
		'navQuizzes': 'الكويزات',
		'navWallet': 'المحفظة',
		'navAccount': 'حسابي',
		'welcomeBack': 'أهلاً بعودتك،',
		'welcomeSubtitle': 'مستعد تكمل رحلتك التعليمية؟',
		'goToDashboard': 'الذهاب للرئيسية',
		'notificationsTitle': 'الإشعارات',
		'markAllRead': 'تعيين الكل كمقروء',
		'minutesAgo': 'منذ %s دقائق',
		'hoursAgo': 'منذ %s ساعات',
		'daysAgo': 'منذ %s أيام',
		'quizCorrected': 'تم تصحيح الكويز',
		'newAssignment': 'واجب جديد',
		'sessionReminder': 'تذكير بالحضور',
		'walletCharged': 'تم شحن المحفظة',
		'absenceAlert': 'تنبيه غياب',
		'store': 'المتجر',
		'addToCart': 'إضافة للسلة',
		'shoppingCart': 'سلة التسوق',
		'products': 'المنتجات',
		'checkout': 'إتمام الشراء',
		'pagesCount': 'الصفحات',
		'availability': 'الحالة',
		'available': 'متوفر',
		'physicsBook': 'ملزمة الفيزياء',
		'practiceWorkbook': 'كراسة تدريبات',
		'mentorxTshirt': 'تيشيرت MentorX',
		'studentBag': 'حقيبة الطالب',
		'orderSummary': 'ملخص الطلب',
		'profileTitle': 'الملف الشخصي',
		'personalData': 'البيانات الشخصية',
		'name': 'الاسم',
		'phone': 'الهاتف',
		'grade': 'الصف',
		'center': 'السنتر',
		'editRequest': 'طلب تعديل',
		'editProfile': 'طلب تعديل',
		'editsNeedApproval': 'التعديلات تحتاج موافقة',
		'school': 'المدرسة',
		'reasonForEdit': 'سبب التعديل',
		'sendRequest': 'إرسال الطلب',
		'changePassword': 'تغيير كلمة المرور',
		'currentPassword': 'كلمة المرور الحالية',
		'newPassword': 'كلمة المرور الجديدة',
		'confirmNewPassword': 'تأكيد كلمة المرور الجديدة',
		'saveChanges': 'حفظ التغييرات',
		'quizIntroTitle': 'معلومات الكويز',
		'quizUnitTitle': 'كويز الوحدة الثالثة',
		'quizTitle': 'كويز الموجات',
		'quizSubtitle': 'اختبر معلوماتك في درس الموجات',
		'questionCount': 'عدد الأسئلة',
		'duration': 'المدة',
		'passGrade': 'درجة النجاح',
		'attempts': 'المحاولات',
		'instructions': 'تعليمات:',
		'instructionRead': 'اقرأ كل سؤال بعناية قبل الإجابة',
		'instructionReview': 'يمكنك مراجعة إجاباتك قبل التسليم',
		'instructionNoReturn': 'لا يمكن العودة بعد تسليم الكويز',
		'startQuiz': 'ابدأ الكويز',
		'questionOf': 'السؤال %s من %s',
		'submitQuiz': 'تسليم الكويز',
		'backToQuestions': 'العودة للأسئلة',
		'answeredCount': 'تم الإجابة على',
		'jumpToQuestion': 'انتقل لسؤال محدد:',
		'unansweredNote': '%s أسئلة لم تتم إجابتها',
		'quizResult': 'نتيجة الكويز',
		'excellent': 'ممتاز!',
		'veryGood': 'جيد جداً',
		'good': 'جيد',
		'fail': 'حاول تاني',
		'greatResult': 'أحسنت! نتيجة رائعة',
		'correctAnswers': 'إجابة صحيحة',
		'wrongAnswers': 'إجابة خاطئة',
		'timeTaken': 'الوقت المستغرق',
		'reviewAnswers': 'مراجعة الإجابات',
		'correctAnswer': 'الإجابة الصحيحة:',
		'minutesShort': 'د',
		'claimReward': 'احصل على مكافأتك',
		'quizRewardsTitle': 'مكافآت الكويز',
		'congratulations': 'مبروك!',
		'rewardEarnedMsg': 'حققت درجة ممتازة وحصلت على مكافأة خاصة!',
		'yourScore': 'درجتك',
		'pointsEarned': 'نقاط مكتسبة',
		'excellentBadge': 'شارة التميز',
		'badgeUnlocked': 'تم فتح الشارة - أضيفت لملفك الشخصي',
		'backToQuizzes': 'العودة للرئيسية',
		'quizListTitle': 'الكويزات',
		'gamificationTitle': 'المكافآت والإنجازات',
		'goldLevel': 'المستوى الذهبي',
		'xpPoints': 'نقاط XP',
		'quizCompleted': 'كويز مكتمل',
		'badge': 'شارة',
		'toNextLevel': 'للمستوى التالي',
		'dailyStreak': 'سلسلة الحل اليومي',
		'streakDaysMsg': '%s أيام متتالية - واصل للمكافأة!',
		'earnedBadges': 'الشارات المكتسبة',
		'leaderboard': 'ترتيب المتفوقين',
		'sat': 'سبت',
		'sun': 'أحد',
		'mon': 'اثنين',
		'tue': 'ثلاثاء',
		'wed': 'أربعاء',
		'thu': 'خميس',
		'fri': 'جمعة',
		'lightningSpeed': 'سرعة البرق',
		'perfectScore': 'درجة كاملة',
		'fiveDayStreak': '5 أيام متتالية',
		'tenQuizzes': '10 كويزات',
		'physicsLion': 'أسد الفيزياء',
		'settingsTitle': 'الإعدادات',
		'changePasswordSetting': 'تغيير كلمة المرور',
		'notificationsSetting': 'الإشعارات',
		'supportSetting': 'الدعم الفني',
		'aboutSetting': 'عن التطبيق',
		'logoutSetting': 'تسجيل الخروج',
		'supportTitle': 'تواصل معنا',
		'supportDesc': 'نحن هنا لمساعدتك! تواصل معنا عبر أي من القنوات التالية',
		'whatsapp': 'واتساب',
		'phoneCall': 'هاتف',
		'email': 'البريد',
		'aboutTitle': 'عن التطبيق',
		'aboutDesc': 'منصة تعليمية متكاملة تربط بين المحاضرين والطلاب',
		'version': 'الإصدار',
		'lastUpdate': 'آخر تحديث',
		'walletTitle': 'المحفظة',
		'currentBalance': 'الرصيد الحالي',
		'charge': 'شحن',
		'code': 'كود',
		'history': 'السجل',
		'recentTransactions': 'آخر المعاملات',
		'addBalance': 'شحن رصيد',
		'amount': 'المبلغ',
		'choosePaymentMethod': 'اختر وسيلة الدفع',
		'vodafoneCash': 'فودافون كاش',
		'vodafoneDesc': 'الدفع من محفظة فودافون',
		'instaPay': 'إنستا باي',
		'instaPayDesc': 'تحويل عبر إنستا باي',
		'fawry': 'فوري',
		'fawryDesc': 'الدفع من خلال فوري',
		'continueBtn': 'متابعة',
		'redeemCode': 'استخدام كود',
		'enterCodeDesc': 'أدخل كود الخصم أو الحصة',
		'activateCode': 'تفعيل الكود',
		'purchaseConfirm': 'تأكيد العملية',
		'paymentMethod': 'وسيلة الدفع',
		'total': 'الإجمالي',
		'confirmPayment': 'تأكيد الدفع',
		'paymentSuccess': 'تمت العملية بنجاح!',
		'balanceAdded': 'تم إضافة %s ج.م إلى رصيدك',
		'newBalance': 'الرصيد الجديد',
		'backToWallet': 'العودة للمحفظة',
		'transactionsTitle': 'سجل المعاملات',
		'chargeBalance': 'شحن رصيد',
		'purchaseCourse': 'شراء حصة',
		'discountCode': 'كود خصم',
		'purchaseBook': 'شراء - كتاب',
		'today': 'اليوم',
		'yesterday': 'أمس',
	};
	@override late final _TranslationsParentAr parent = _TranslationsParentAr._(_root);
	@override late final _TranslationsAssignmentsAr assignments = _TranslationsAssignmentsAr._(_root);
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

// Path: student.analytics
class _TranslationsStudentAnalyticsAr implements TranslationsStudentAnalyticsEn {
	_TranslationsStudentAnalyticsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تحليلات الأداء';
	@override String get gradeVsPeers => 'درجتك وسط زملائك';
	@override String rank({required Object rank}) => 'الترتيب: #${rank}';
	@override String get yourScore => 'درجتك';
	@override String get classAverage => 'متوسط الفصل';
	@override String studentsCount({required Object count}) => 'من أصل ${count} طالبًا';
	@override String get aboveAverage => 'أعلى من المتوسط';
	@override String get belowAverage => 'أقل من المتوسط';
	@override String get performanceTrend => 'درمان النمو الطالبة';
	@override String get studyPeakHours => 'ساعات الذروة للدراسة';
	@override String get badgesAndAchievements => 'الشارات والإنجازات';
	@override String get streakTitle => 'سلسلة الحماس';
	@override String streakDays({required Object count}) => '${count} يوم متتالي';
	@override String get streakEncouragement => 'استمر! أنت في تقدم مستمر';
	@override String get bestStreak => 'أفضل سلسلة';
	@override String get quizSpeedMetrics => 'مقاييس سرعة الاختبارات';
	@override String get secondsPerQuestion => 'ثانية/سؤال';
	@override String get yourAverage => 'متوسطك';
	@override String get peerAverage => 'متوسط الطلاب';
	@override String get speedEncouragement => 'أنت أسرع من متوسط الطلاب بـ %15! استمر في هذا الأداء.';
	@override String get allCourses => 'جميع الكورسات';
}

// Path: parent
class _TranslationsParentAr implements TranslationsParentEn {
	_TranslationsParentAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get dashboardTitle => 'بوابة ولي الأمر';
	@override String get welcomeBack => 'أهلاً بعودتك،';
	@override String get services => 'الخدمات';
	@override String get recentActivity => 'آخر النشاطات';
	@override String get viewAll => 'عرض الكل';
	@override String get retry => 'إعادة المحاولة';
	@override String get unableToLoad => 'غير قادر على تحميل لوحة التحكم';
	@override String get myProfile => 'ملفي الشخصي';
	@override String get signOut => 'تسجيل الخروج';
	@override String get accountInfo => 'معلومات الحساب';
	@override String get appSettings => 'إعدادات التطبيق';
	@override String get notifications => 'الإشعارات';
	@override String get security => 'الأمان';
	@override String get childSwitcher => 'تبديل الأبناء';
	@override String get noData => 'لا توجد بيانات';
	@override String get announcements => 'الإعلانات';
	@override String get academicMonitor => 'المتابعة الأكاديمية';
	@override String get financialMonitor => 'المتابعة المالية';
	@override String get attendanceMonitor => 'متابعة الغياب';
	@override String get overallAverage => 'المعدل العام';
	@override String get enrolledCourses => 'الدورات المسجل بها';
	@override String get childWalletBalance => 'رصيد محفظة الابن';
	@override String get spentThisMonth => 'المنفق هذا الشهر';
	@override String get transactionHistory => 'سجل المعاملات';
	@override String get pointsEarned => 'النقاط المكتسبة';
	@override late final _TranslationsParentHomeAr home = _TranslationsParentHomeAr._(_root);
	@override late final _TranslationsParentQuickActionsAr quickActions = _TranslationsParentQuickActionsAr._(_root);
	@override late final _TranslationsParentOnboardingAr onboarding = _TranslationsParentOnboardingAr._(_root);
	@override late final _TranslationsParentAuthAr auth = _TranslationsParentAuthAr._(_root);
	@override late final _TranslationsParentProfileAr profile = _TranslationsParentProfileAr._(_root);
	@override late final _TranslationsParentCommunicationAr communication = _TranslationsParentCommunicationAr._(_root);
	@override late final _TranslationsParentAcademicAr academic = _TranslationsParentAcademicAr._(_root);
	@override late final _TranslationsParentFinancialAr financial = _TranslationsParentFinancialAr._(_root);
	@override late final _TranslationsParentAttendanceTrackingAr attendanceTracking = _TranslationsParentAttendanceTrackingAr._(_root);
	@override late final _TranslationsParentAssessmentsAr assessments = _TranslationsParentAssessmentsAr._(_root);
	@override late final _TranslationsParentChildrenAr children = _TranslationsParentChildrenAr._(_root);
	@override late final _TranslationsParentCourseDetailAr courseDetail = _TranslationsParentCourseDetailAr._(_root);
	@override late final _TranslationsParentGradeDetailAr gradeDetail = _TranslationsParentGradeDetailAr._(_root);
	@override late final _TranslationsParentSplashAr splash = _TranslationsParentSplashAr._(_root);
	@override late final _TranslationsParentAppAr app = _TranslationsParentAppAr._(_root);
}

// Path: assignments
class _TranslationsAssignmentsAr implements TranslationsAssignmentsEn {
	_TranslationsAssignmentsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get listTitle => 'الواجبات';
	@override String dueAt({required Object date}) => 'تاريخ التسليم: ${date}';
	@override String get noDeadline => 'لا يوجد موعد تسليم';
	@override String get submitAssignment => 'تسليم الواجب';
	@override String get viewFeedback => 'عرض الملاحظات';
	@override String get submitted => 'تم التسليم';
	@override String get notSubmitted => 'لم يتم التسليم';
	@override String get grading => 'جاري التصحيح';
	@override String get graded => 'تم التصحيح';
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
	@override String get noResults => 'لا توجد نتائج';
	@override String opening({required Object url}) => 'جاري فتح: ${url}';
	@override String get comingSoon => 'قريباً';
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
	@override String get allLevels => 'جميع الصفوف';
	@override String get sortBy => 'ترتيب حسب';
	@override String get sortNewest => 'الأحدث';
	@override String get sortPriceAsc => 'السعر: من الأقل للأعلى';
	@override String get sortPriceDesc => 'السعر: من الأعلى للأقل';
	@override String get sortPopular => 'الأكثر شعبية';
	@override String get noCourses => 'لم يتم العثور على كورسات';
	@override String get noCoursesDescription => 'حاول تعديل البحث أو الفلاتر.';
	@override String coursesFound({required Object count}) => 'تم العثور على ${count} كورس';
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
	@override String durationShort({required Object mins, required Object secs}) => '${mins}د ${secs}ث';
	@override String pagesCount({required Object count}) => '${count} صفحة';
	@override String get yourProgress => 'تقدمك الحالي';
	@override String completePercent({required Object percent}) => '${percent}% مكتمل';
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

// Path: parent.home
class _TranslationsParentHomeAr implements TranslationsParentHomeEn {
	_TranslationsParentHomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get parentAccount => 'حساب ولي الأمر';
	@override String get addChild => 'إضافة ابن';
	@override String get academicStanding => 'المستوى الأكاديمي';
	@override String get avgGrade => 'متوسط الدرجات';
	@override String get attendance => 'الحضور';
	@override String get unpaidFees => 'رسوم غير مدفوعة';
	@override String get noRecentActivity => 'لا يوجد نشاط حديث';
	@override String get noRecentActivityHint => 'ستظهر النشاطات هنا بمجرد أن يبدأ ابنك في رحلته التعليمية.';
	@override String get noChildrenTitle => 'لم يتم ربط أبناء';
	@override String get noChildrenHint => 'اربط أول ابن لك لمتابعة تقدمه.';
	@override String get linkChild => 'ربط ابن';
	@override String updatedAt({required Object time}) => 'آخر تحديث ${time}';
	@override String get upcomingSessions => 'الحصص القادمة';
	@override String get noUpcomingSessions => 'لا توجد حصص قادمة';
	@override String get recentGrades => 'أحدث الدرجات';
	@override String get noRecentGrades => 'لا توجد درجات بعد';
	@override String get viewDetails => 'عرض التفاصيل';
}

// Path: parent.quickActions
class _TranslationsParentQuickActionsAr implements TranslationsParentQuickActionsEn {
	_TranslationsParentQuickActionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get attendance => 'الحضور';
	@override String get courses => 'الكورسات';
	@override String get fees => 'المصاريف';
	@override String get messages => 'الرسائل';
	@override String get grades => 'الدرجات';
	@override String get announcements => 'الإعلانات';
	@override String get schedule => 'الجدول';
	@override String get support => 'الدعم';
}

// Path: parent.onboarding
class _TranslationsParentOnboardingAr implements TranslationsParentOnboardingEn {
	_TranslationsParentOnboardingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get parentPortalTag => 'بوابة ولي الأمر';
	@override String get slide1Title => 'تابع التقدم';
	@override String get slide1Description => 'تابع درجات ابنك وحضوره وإنجازاته الأكاديمية لحظة بلحظة.';
	@override String get slide2Title => 'ابقَ على تواصل';
	@override String get slide2Description => 'تواصل مباشر مع المعلمين وإدارة المدرسة لتجربة تعليمية أفضل.';
	@override String get slide3Title => 'مدفوعات آمنة';
	@override String get slide3Description => 'أدر المصاريف المدرسية ورصيد محفظة ابنك بأمان وسهولة.';
	@override String get skip => 'تخطّي';
	@override String get getStarted => 'ابدأ الآن';
}

// Path: parent.auth
class _TranslationsParentAuthAr implements TranslationsParentAuthEn {
	_TranslationsParentAuthAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get otpTitle => 'تأكيد رقم الهاتف';
	@override String otpSubtitle({required Object phone}) => 'أدخل الكود المكوّن من 6 أرقام المُرسل إلى\n${phone}';
	@override String get otpFieldLabel => 'كود التحقق';
	@override String get otpFieldHint => '000000';
	@override String get verifyAndContinue => 'تأكيد ومتابعة';
	@override String get resending => 'جاري إعادة الإرسال…';
	@override String get resendCode => 'إعادة إرسال الكود';
	@override String resendInSeconds({required Object seconds}) => 'إعادة الإرسال خلال ${seconds} ثانية';
	@override String get verificationFailed => 'فشل التحقق';
	@override String get appName => 'MentorX لولي الأمر';
	@override String get loginTagline => 'تابع رحلة ابنك الأكاديمية بثقة كاملة';
	@override String get phoneNumberLabel => 'رقم الهاتف';
	@override String get phoneNumberHint => 'أدخل رقم هاتفك';
	@override String get phoneRequired => 'من فضلك أدخل رقم الهاتف';
	@override String get passwordLabel => 'كلمة المرور';
	@override String get passwordRequired => 'من فضلك أدخل كلمة المرور';
	@override String get forgotPassword => 'نسيت كلمة المرور؟';
	@override String get signInToDashboard => 'تسجيل الدخول';
	@override String get newToMentorX => 'جديد في MentorX؟';
	@override String get createAccount => 'إنشاء حساب';
	@override String get loginFailed => 'فشل تسجيل الدخول. حاول مرة أخرى.';
	@override String get passwordRecoveryHeading => 'استرجاع كلمة المرور';
	@override String get forgotPasswordTitle => 'نسيت كلمة المرور؟';
	@override String get forgotPasswordSubtitle => 'لا تقلق! أدخل رقم هاتفك المسجّل وسنرسل لك كود تحقق لإعادة تعيين حسابك بأمان.';
	@override String get sendVerificationCode => 'إرسال كود التحقق';
	@override String get backToLogin => 'الرجوع لتسجيل الدخول';
	@override String get sendCodeFailed => 'تعذّر إرسال الكود';
	@override String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';
	@override String resetPasswordSubtitle({required Object phone}) => 'أدخل الكود المكوّن من 6 أرقام المُرسل إلى\n${phone}';
	@override String get otpCodeLabel => 'كود التحقق';
	@override String get newPasswordLabel => 'كلمة المرور الجديدة';
	@override String get confirmPasswordLabel => 'تأكيد كلمة المرور';
	@override String get passwordPlaceholder => '••••••••';
	@override String get updatePasswordNow => 'تحديث كلمة المرور';
	@override String get validationCheckInputs => 'من فضلك تحقّق من البيانات المدخلة وحاول مرة أخرى';
	@override String get passwordResetSuccess => 'تم إعادة تعيين كلمة المرور بنجاح';
	@override String get regStep1Title => 'ربط ابنك';
	@override String get regStep2Title => 'البيانات الشخصية';
	@override String get regStep3Title => 'الأمان';
	@override String get regDefaultTitle => 'التسجيل';
	@override String get regFindStudent => 'ابحث عن الطالب';
	@override String get regConfirmChild => 'أكّد الابن';
	@override String get regContinue => 'متابعة';
	@override String get regCreateAccount => 'إنشاء حساب';
	@override String get regPleaseWait => 'جاري المعالجة…';
	@override String get regAlreadyHaveAccount => 'لديك حساب بالفعل؟ تسجيل الدخول';
	@override String get regLookupPhoneTab => 'الهاتف';
	@override String get regLookupCodeTab => 'كود الطالب';
	@override String get regChildPhoneLabel => 'هاتف الابن';
	@override String get regChildPhoneHint => 'أدخل رقم الهاتف المسجّل';
	@override String get regStudentCodeLabel => 'كود الطالب';
	@override String get regStudentCodeHint => 'أدخل الكود المميّز';
	@override String get regFirstNameLabel => 'الاسم الأول';
	@override String get regFirstNameHint => 'مثال: أحمد';
	@override String get regLastNameLabel => 'الاسم الأخير';
	@override String get regLastNameHint => 'مثال: محمد';
	@override String get regYourPhoneHint => 'رقم هاتفك';
	@override String get regEmailLabel => 'البريد الإلكتروني';
	@override String get regEmailHint => 'اختياري';
	@override String get regSecurityHint => 'اضبط كلمة مرور قوية لحماية الوصول إلى حسابك.';
	@override String get regRelationshipLabel => 'صلة القرابة بالابن';
	@override String get regChildConfirmed => 'تم تأكيد الابن بنجاح';
	@override String get regConfirmIsYourChild => 'أكّد إذا كان هذا هو ابنك';
	@override String get regErrorLookupEmpty => 'من فضلك أدخل رقم هاتف الابن أو كود الطالب.';
	@override String get regErrorStudentNotFound => 'لم يتم العثور على طالب بهذا الرقم.';
	@override String get regErrorFindFailed => 'تعذّر البحث عن الطالب. حاول مرة أخرى.';
	@override String get regErrorFindChildFirst => 'من فضلك ابحث عن ابنك أولًا.';
	@override String get regErrorConfirmChild => 'من فضلك أكّد أن هذا هو ابنك.';
	@override String get regErrorFirstNameShort => 'الاسم الأول يجب أن يكون حرفين على الأقل.';
	@override String get regErrorLastNameShort => 'الاسم الأخير يجب أن يكون حرفين على الأقل.';
	@override String get regErrorInvalidPhone => 'من فضلك أدخل رقم هاتف مصري صحيح.';
	@override String get regErrorInvalidEmail => 'من فضلك أدخل بريدًا إلكترونيًا صحيحًا.';
	@override String get regErrorRelationshipRequired => 'من فضلك اختر صلة القرابة بالابن.';
	@override String get regErrorPasswordWeak => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.';
	@override String get regErrorPasswordMismatch => 'كلمتا المرور غير متطابقتين.';
	@override String get regErrorRegistrationFailed => 'فشل التسجيل. حاول مرة أخرى.';
	@override String get regErrorPhoneAlreadyExists => 'يوجد حساب مسجّل بهذا الرقم بالفعل.';
}

// Path: parent.profile
class _TranslationsParentProfileAr implements TranslationsParentProfileEn {
	_TranslationsParentProfileAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get verifiedAccount => 'حساب موثّق';
	@override String get fullNameLabel => 'الاسم بالكامل';
	@override String get phoneNumberLabel => 'رقم الهاتف';
	@override String get emailLabel => 'البريد الإلكتروني';
	@override String get notificationsEnabled => 'مفعّلة';
	@override String get notificationsDisabled => 'متوقّفة';
	@override String get securityValue => 'كلمة المرور والمصادقة الحيوية';
	@override String get signOutConfirmTitle => 'تسجيل الخروج؟';
	@override String get signOutConfirmMessage => 'سيتم تسجيل خروجك وإعادتك إلى شاشة تسجيل الدخول.';
	@override String get signOutAction => 'تسجيل الخروج';
	@override String get signOutCancel => 'إلغاء';
	@override String get fallbackName => 'ولي أمر';
	@override String get settingsTitle => 'الإعدادات';
	@override String get appConfigurationSection => 'إعدادات التطبيق';
	@override String get preferencesSection => 'التفضيلات';
	@override String get supportSection => 'الدعم';
	@override String get pushNotifications => 'إشعارات الدفع';
	@override String get themeMode => 'وضع الواجهة';
	@override String get themeSystem => 'النظام';
	@override String get themeLight => 'فاتح';
	@override String get themeDark => 'داكن';
	@override String get appLanguage => 'لغة التطبيق';
	@override String get languageEnglish => 'English';
	@override String get languageArabic => 'العربية';
	@override String get helpCenter => 'مركز المساعدة';
	@override String get helpCenterValue => 'الأسئلة الشائعة والدعم';
	@override String get aboutTitle => 'عن MentorX';
	@override String aboutVersion({required Object version}) => 'الإصدار ${version}';
}

// Path: parent.communication
class _TranslationsParentCommunicationAr implements TranslationsParentCommunicationEn {
	_TranslationsParentCommunicationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get notificationsTitle => 'الإشعارات';
	@override String get announcementsTitle => 'الإعلانات';
	@override String get whatsAppTitle => 'مجموعات واتساب';
	@override String get noNotificationsTitle => 'لا توجد إشعارات';
	@override String get noNotificationsHint => 'كل شيء على ما يرام — ستظهر التحديثات الجديدة هنا.';
	@override String get noAnnouncementsTitle => 'لا توجد إعلانات';
	@override String get noAnnouncementsHint => 'ابق على اطلاع! ستظهر إعلانات المدرسة هنا.';
	@override String get noGroupsTitle => 'لا توجد مجموعات';
	@override String get noGroupsHint => 'لا توجد مجموعات واتساب متاحة لهذا الابن بعد.';
	@override String get readMore => 'اقرأ المزيد';
	@override String get joinGroup => 'انضمام';
	@override String get groupSubtitle => 'اضغط للانضمام والحصول على آخر التحديثات';
}

// Path: parent.academic
class _TranslationsParentAcademicAr implements TranslationsParentAcademicEn {
	_TranslationsParentAcademicAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'المتابعة الأكاديمية';
	@override String get overallAverageHeading => 'المعدل العام';
	@override String get averageLabel => 'المعدل';
	@override String get gradedLabel => 'المصححة';
	@override String get pendingLabel => 'المعلقة';
	@override String get noCoursesTitle => 'لا توجد كورسات';
	@override String get noCoursesHint => 'ستظهر البيانات الأكاديمية هنا بمجرد توفرها.';
	@override String sessionsCount({required Object count}) => '${count} حصة';
	@override String completedSessionsLabel({required Object completed, required Object total}) => '${completed} / ${total} حصة';
	@override String get courseDetailsTitle => 'تفاصيل الكورس';
}

// Path: parent.financial
class _TranslationsParentFinancialAr implements TranslationsParentFinancialEn {
	_TranslationsParentFinancialAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get balance => 'الرصيد';
	@override String get spent => 'المنفق';
	@override String get points => 'النقاط';
	@override String get noDataTitle => 'لا توجد بيانات';
	@override String get noDataHint => 'ستظهر البيانات المالية هنا بمجرد توفرها.';
	@override String get noTransactionsTitle => 'لا توجد معاملات';
	@override String get noTransactionsHint => 'لم يتم العثور على سجل معاملات لهذا الابن.';
	@override String get credit => 'إيداع';
	@override String get debit => 'خصم';
	@override String get deposit => 'شحن';
	@override String get withdrawal => 'سحب';
	@override String get payment => 'دفع';
	@override String get refund => 'استرجاع';
	@override String get reward => 'مكافأة';
	@override String get statusPending => 'قيد المعالجة';
	@override String get statusSuccess => 'ناجحة';
	@override String get statusFailed => 'فاشلة';
}

// Path: parent.attendanceTracking
class _TranslationsParentAttendanceTrackingAr implements TranslationsParentAttendanceTrackingEn {
	_TranslationsParentAttendanceTrackingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'متابعة الحضور';
	@override String get attendanceLog => 'سجل الحضور';
	@override String get present => 'حاضر';
	@override String get absent => 'غائب';
	@override String get late => 'متأخر';
	@override String get excused => 'بعذر';
	@override String get noRecordsTitle => 'لا توجد سجلات';
	@override String get noRecordsHint => 'لم يتم العثور على سجلات حضور لهذا الطالب.';
	@override String get regularSession => 'حصة عادية';
	@override String get generalAcademic => 'عام';
	@override String get onlineSession => 'أونلاين';
	@override String checkInTimeLabel({required Object time}) => 'تم التسجيل في ${time}';
}

// Path: parent.assessments
class _TranslationsParentAssessmentsAr implements TranslationsParentAssessmentsEn {
	_TranslationsParentAssessmentsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'الأداء الأكاديمي';
	@override String get overallPerformance => 'الأداء العام';
	@override String get average => 'المعدل';
	@override String get graded => 'المصححة';
	@override String get pending => 'المعلقة';
	@override String get passed => 'ناجح';
	@override String get failed => 'راسب';
	@override String get assessmentHistory => 'سجل التقييمات';
	@override String get noAssessmentsTitle => 'لا توجد تقييمات';
	@override String get noAssessmentsHint => 'ستظهر بيانات التقييم الأكاديمي هنا فور تقديمها.';
	@override String get passLabel => 'ناجح';
	@override String get failLabel => 'راسب';
	@override String scoreLabel({required Object score, required Object total}) => 'الدرجة: ${score}/${total}';
	@override String get quizPrefix => 'اختبار';
	@override String get assignmentPrefix => 'واجب';
	@override String get examPrefix => 'امتحان';
	@override String get trendUp => 'في تحسن';
	@override String get trendDown => 'في انخفاض';
	@override String get trendStable => 'مستقر';
}

// Path: parent.children
class _TranslationsParentChildrenAr implements TranslationsParentChildrenEn {
	_TranslationsParentChildrenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الأبناء المرتبطين';
	@override String get linkNewChild => 'ربط ابن جديد';
	@override String get linkChildTitle => 'اربط ابنك';
	@override String get linkChildHint => 'أدخل رقم القيد الخاص بابنك أو رقم الهاتف المسجل لربط حسابه.';
	@override String get searchLabel => 'ابحث عن الابن';
	@override String get searchHint => 'رقم القيد / رقم الهاتف';
	@override String get confirmLink => 'تأكيد وربط الابن';
	@override String get specifyRelationship => 'حدد صلة القرابة';
	@override String get linkSuccess => 'تم ربط الابن بنجاح';
	@override String get unlinkConfirmTitle => 'إزالة الابن؟';
	@override String unlinkConfirmMessage({required Object name}) => 'سيتم إلغاء ربط ${name} من حسابك. يمكنك إعادة الربط في أي وقت.';
	@override String get unlink => 'إلغاء الربط';
	@override String get unlinkSuccess => 'تم إلغاء ربط الابن';
	@override String studentIdLabel({required Object id}) => 'رقم الطالب: ${id}';
	@override String studentCodeLabel({required Object code}) => 'الكود: ${code}';
	@override String gradeLabel({required Object grade}) => 'الصف: ${grade}';
	@override String centerLabel({required Object center}) => 'السنتر: ${center}';
	@override String get cancel => 'إلغاء';
	@override late final _TranslationsParentChildrenRelationshipAr relationship = _TranslationsParentChildrenRelationshipAr._(_root);
	@override String get errorAlreadyLinked => 'هذا الابن مرتبط بالفعل بحسابك.';
	@override String get errorStudentNotFound => 'لم نجد طالبًا بهذا الرقم.';
	@override String get errorNetwork => 'مشكلة في الشبكة. تحقّق من اتصالك وحاول مرة أخرى.';
	@override String get errorGeneric => 'حدث خطأ ما. حاول مرة أخرى.';
	@override String get lookupEmpty => 'اكتب رقم القيد أو رقم الهاتف أولًا.';
}

// Path: parent.courseDetail
class _TranslationsParentCourseDetailAr implements TranslationsParentCourseDetailEn {
	_TranslationsParentCourseDetailAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'تفاصيل الكورس';
	@override String get courseBreakdown => 'تفاصيل المادة';
	@override String get courseId => 'رقم الكورس';
	@override String get fullTitle => 'العنوان الكامل';
	@override String get status => 'الحالة';
	@override String get statusActive => 'نشط';
	@override String get sessions => 'الحصص';
	@override String get progress => 'التقدم';
	@override String get id => 'المعرّف';
}

// Path: parent.gradeDetail
class _TranslationsParentGradeDetailAr implements TranslationsParentGradeDetailEn {
	_TranslationsParentGradeDetailAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'تفاصيل الدرجة';
	@override String get quizDetail => 'تفاصيل الاختبار';
	@override String get quizScore => 'نتيجة الاختبار';
	@override String get assessmentInfo => 'معلومات التقييم';
	@override String get score => 'الدرجة';
	@override String get percentage => 'النسبة';
	@override String get result => 'النتيجة';
	@override String get pass => 'ناجح';
	@override String get fail => 'راسب';
	@override String get questionBreakdown => 'تفصيل الأسئلة';
	@override String questionLabel({required Object number}) => 'السؤال ${number}';
	@override String get correctAnswer => 'إجابة صحيحة';
	@override String get incorrectAnswer => 'إجابة خاطئة';
	@override String get additionalDetails => 'تفاصيل إضافية';
	@override String get quizId => 'رقم الاختبار';
	@override String get submittedAt => 'تاريخ التسليم';
	@override String get passCriteria => 'حد النجاح';
	@override String get notFound => 'لم يتم العثور على محاولة الاختبار.';
}

// Path: parent.splash
class _TranslationsParentSplashAr implements TranslationsParentSplashEn {
	_TranslationsParentSplashAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'MENTORX';
	@override String get tagline => 'بوابة ولي الأمر';
}

// Path: parent.app
class _TranslationsParentAppAr implements TranslationsParentAppEn {
	_TranslationsParentAppAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'MentorX لولي الأمر';
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
	@override String get assignments => 'الواجبات';
	@override String get rewards => 'المكافآت';
	@override String get marketplace => 'المتجر';
	@override String get analytics => 'تحليلات الأداء';
}

// Path: parent.children.relationship
class _TranslationsParentChildrenRelationshipAr implements TranslationsParentChildrenRelationshipEn {
	_TranslationsParentChildrenRelationshipAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get father => 'أب';
	@override String get mother => 'أم';
	@override String get guardian => 'وصي';
	@override String get other => 'أخرى';
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
			'ui.common.noResults' => 'لا توجد نتائج',
			'ui.common.opening' => ({required Object url}) => 'جاري فتح: ${url}',
			'ui.common.comingSoon' => 'قريباً',
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
			'home.dashboard.actions.assignments' => 'الواجبات',
			'home.dashboard.actions.rewards' => 'المكافآت',
			'home.dashboard.actions.marketplace' => 'المتجر',
			'home.dashboard.actions.analytics' => 'تحليلات الأداء',
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
			'course.catalog.allLevels' => 'جميع الصفوف',
			'course.catalog.sortBy' => 'ترتيب حسب',
			'course.catalog.sortNewest' => 'الأحدث',
			'course.catalog.sortPriceAsc' => 'السعر: من الأقل للأعلى',
			'course.catalog.sortPriceDesc' => 'السعر: من الأعلى للأقل',
			'course.catalog.sortPopular' => 'الأكثر شعبية',
			'course.catalog.noCourses' => 'لم يتم العثور على كورسات',
			'course.catalog.noCoursesDescription' => 'حاول تعديل البحث أو الفلاتر.',
			'course.catalog.coursesFound' => ({required Object count}) => 'تم العثور على ${count} كورس',
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
			'course.detail.durationShort' => ({required Object mins, required Object secs}) => '${mins}د ${secs}ث',
			'course.detail.pagesCount' => ({required Object count}) => '${count} صفحة',
			'course.detail.yourProgress' => 'تقدمك الحالي',
			'course.detail.completePercent' => ({required Object percent}) => '${percent}% مكتمل',
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
			'student.aiAssistant' => 'المساعد الذكي',
			'student.aiSubtitle' => 'مساعد AI للفيزياء',
			'student.aiWelcome' => 'أهلاً بك! أنا المساعد الذكي للفيزياء. اسألني أي سؤال!',
			'student.typeQuestion' => 'اكتب سؤالك هنا...',
			'student.analytics.title' => 'تحليلات الأداء',
			'student.analytics.gradeVsPeers' => 'درجتك وسط زملائك',
			'student.analytics.rank' => ({required Object rank}) => 'الترتيب: #${rank}',
			'student.analytics.yourScore' => 'درجتك',
			'student.analytics.classAverage' => 'متوسط الفصل',
			'student.analytics.studentsCount' => ({required Object count}) => 'من أصل ${count} طالبًا',
			'student.analytics.aboveAverage' => 'أعلى من المتوسط',
			'student.analytics.belowAverage' => 'أقل من المتوسط',
			'student.analytics.performanceTrend' => 'درمان النمو الطالبة',
			'student.analytics.studyPeakHours' => 'ساعات الذروة للدراسة',
			'student.analytics.badgesAndAchievements' => 'الشارات والإنجازات',
			'student.analytics.streakTitle' => 'سلسلة الحماس',
			'student.analytics.streakDays' => ({required Object count}) => '${count} يوم متتالي',
			'student.analytics.streakEncouragement' => 'استمر! أنت في تقدم مستمر',
			'student.analytics.bestStreak' => 'أفضل سلسلة',
			'student.analytics.quizSpeedMetrics' => 'مقاييس سرعة الاختبارات',
			'student.analytics.secondsPerQuestion' => 'ثانية/سؤال',
			'student.analytics.yourAverage' => 'متوسطك',
			'student.analytics.peerAverage' => 'متوسط الطلاب',
			'student.analytics.speedEncouragement' => 'أنت أسرع من متوسط الطلاب بـ %15! استمر في هذا الأداء.',
			'student.analytics.allCourses' => 'جميع الكورسات',
			'student.assignmentDetail' => 'تفاصيل الواجب',
			'student.assignmentTitle' => 'واجب الموجات',
			'student.assignmentUnit' => 'الوحدة الثالثة - الحصة 2',
			'student.deadline' => 'آخر موعد',
			'student.maxScore' => 'الدرجة',
			'student.points' => 'درجة',
			'student.instructionsLabel' => 'التعليمات:',
			'student.assignmentInstructions' => 'حل المسائل التالية على الموجات الميكانيكية. يجب حل جميع المسائل وتوضيح خطوات الحل كاملة.',
			'student.assignmentFile' => 'ملف الواجب',
			'student.submitAssignment' => 'تسليم الواجب',
			'student.uploadFile' => 'اضغط لرفع الملف',
			'student.uploadHint' => 'PDF, صور (حد أقصى 10 MB)',
			'student.notesOptional' => 'ملاحظات (اختياري):',
			'student.notesHint' => 'أضف ملاحظة للمحاضر...',
			'student.feedbackTitle' => 'التعليقات',
			'student.instructorFeedback' => 'تعليق المحاضر:',
			'student.registerAttendance' => 'تسجيل الحضور',
			'student.attendanceHistory' => 'سجل الحضور',
			'student.yourAttendanceCode' => 'كود الحضور الخاص بك',
			'student.exitQuizTitle' => 'خروج من الواجب؟',
			'student.exitQuizDesc' => 'لن يتم حفظ تقدمك. هل أنت متأكد أنك تريد الخروج؟',
			'student.cancel' => 'إلغاء',
			'student.exit' => 'خروج',
			'student.yourResponse' => 'إجابتك',
			'student.writeResponse' => 'اكتب إجابتك هنا...',
			'student.responseHint' => 'ابدأ الكتابة...',
			'student.attachments' => 'المرفقات',
			'student.noFiles' => 'لا توجد ملفات مرفقة بعد',
			'student.chooseCorrect' => 'اختر الإجابة الصحيحة:',
			'student.questionLabel' => 'سؤال',
			'student.assignmentSubmitted' => 'تم تسليم الواجب بنجاح',
			'student.alreadySubmitted' => 'لقد قمت بتسليم هذا الواجب بالفعل',
			'student.assignmentNotFound' => 'الواجب غير موجود',
			'student.commonBack' => 'رجوع',
			'student.commonNext' => 'التالي',
			'student.commonPrevious' => 'السابق',
			'student.commonSubmit' => 'إرسال',
			'student.review' => 'مراجعة',
			'student.quizNotFound' => 'الاختبار غير موجود',
			'student.noQuestions' => 'لا توجد أسئلة متاحة',
			'student.yourAnswer' => 'إجابتك:',
			'student.typeAnswerHere' => 'اكتب إجابتك هنا...',
			'student.showCodeInstruction' => 'اعرض الكود للمحاضر أو المساعد لتسجيل حضورك',
			'student.codeValidFor' => 'الكود صالح لمدة 5 دقايق',
			'student.viewAttendance' => 'سجل الحضور',
			'student.totalAttendance' => 'نسبة الحضور الكلية',
			'student.present' => 'حاضر',
			_ => null,
		} ?? switch (path) {
			'student.absent' => 'غائب',
			'student.presentCount' => '%s حضور',
			'student.absentCount' => '%s غياب',
			'student.loginWelcome' => 'أهلاً بيك! سجّل دخولك',
			'student.phoneLabel' => 'رقم الموبايل',
			'student.phoneHint' => '01xxxxxxxxx',
			'student.passwordLabel' => 'كلمة المرور',
			'student.passwordHintLogin' => '••••••••',
			'student.forgotPassword' => 'نسيت كلمة المرور؟',
			'student.loginButton' => 'تسجيل الدخول',
			'student.newStudentPrompt' => 'طالب جديد؟',
			'student.registerHere' => 'سجّل هنا',
			'student.phoneNotRegisteredLogin' => 'الرقم ده مش مسجّل عندنا. لو طالب جديد سجّل من تحت.',
			'student.wrongPasswordLogin' => 'رقمك أو الباسورد غلط. راجع بياناتك أو غيّر كلمة المرور.',
			'student.registerHintFromLogin' => 'لو أنت طالب جديد، سجّل من هنا',
			'student.registerTitle' => 'إنشاء حساب جديد',
			'student.stepLabel1' => 'الخطوة 1 من 6 - البيانات الشخصية',
			'student.stepLabel2' => 'الخطوة 2 من 6 - بيانات التواصل',
			'student.stepLabel3' => 'الخطوة 3 من 6 - البيانات الدراسية',
			'student.stepLabel4' => 'الخطوة 4 من 6 - نوع الدراسة',
			'student.stepLabel5' => 'الخطوة 5 من 6 - كلمة المرور والصور',
			'student.stepLabel6' => 'الخطوة 6 من 6 - تأكيد رقم الهاتف',
			'student.studentPhoneLabel' => 'رقم هاتف الطالب',
			'student.phoneValidationError' => 'رقم الموبايل لازم يكون 11 رقم ويبدأ بـ 01.',
			'student.otpVerifyTitle' => 'تأكيد رقم الهاتف',
			'student.otpSentWhatsapp' => 'تم إرسال كود التحقق على واتساب على الرقم',
			'student.resendCode' => 'إعادة إرسال الكود',
			'student.resendIn' => 'إعادة الإرسال خلال',
			'student.editNumber' => 'تعديل الرقم',
			'student.verifyOtp' => 'تأكيد الكود',
			'student.fullNameLabel' => 'الاسم رباعي',
			'student.firstNameLabel' => 'الاسم الأول',
			'student.secondNameLabel' => 'الاسم الثاني',
			'student.thirdNameLabel' => 'الاسم الثالث',
			'student.fourthNameLabel' => 'الاسم الرابع',
			'student.birthDateLabel' => 'تاريخ الميلاد',
			'student.birthDateHint' => 'اختر التاريخ',
			'student.genderLabel' => 'النوع',
			'student.genderMale' => 'ذكر',
			'student.genderFemale' => 'أنثى',
			'student.parentNameLabel' => 'اسم ولي الأمر',
			'student.parentPhoneLabel' => 'رقم هاتف ولي الأمر',
			'student.parentVerified' => 'تم تأكيد رقم ولي الأمر',
			'student.verifyParentPhone' => 'تأكيد رقم ولي الأمر',
			'student.parentOtpSent' => 'تم إرسال كود التحقق لولي الأمر على واتساب',
			'student.parentOtpRequired' => 'لازم تأكد رقم ولي الأمر الأول.',
			'student.passwordHintRegister' => 'أدخل كلمة المرور (8 حروف على الأقل)',
			'student.confirmPasswordLabel' => 'تأكيد كلمة المرور',
			'student.confirmPasswordHintRegister' => 'أعد إدخال كلمة المرور',
			'student.passwordRules' => 'كلمة المرور لازم تكون 8 حروف أو أرقام على الأقل.',
			'student.passwordRulesHint' => 'حد أدنى 8 أحرف أو أرقام.',
			'student.uploadPhotosLabel' => 'ارفع الصور المطلوبة',
			'student.personalPhotoLabel' => 'صورة شخصية',
			'student.nationalIdPhotoLabel' => 'بطاقة الطالب',
			'student.studyTypeLabel' => 'اختر نوع الدراسة',
			'student.studyTypeCenter' => 'طالب سنتر (حضور)',
			'student.studyTypeOnline' => 'طالب أونلاين',
			'student.scheduleLabel' => 'اختر الميعاد',
			'student.onlineConfirmation' => 'هيوصلك تفاصيل الأونلاين بعد الموافقة.',
			'student.dayFriday' => 'جمعة',
			'student.daySaturday' => 'سبت',
			'student.daySunday' => 'أحد',
			'student.centerSmartMaadi' => 'سنتر سمارت - المعادي',
			'student.centerNoorNasr' => 'سنتر النور - مدينة نصر',
			'student.centerElmHaram' => 'سنتر العلم - الهرم',
			'student.timeSlot1' => '6:00 م - 8:00 م',
			'student.timeSlot2' => '4:00 م - 6:00 م',
			'student.timeSlot3' => '5:00 م - 7:00 م',
			'student.governorateLabel' => 'المحافظة',
			'student.governorateHint' => 'اختر المحافظة',
			'student.governorateCairo' => 'القاهرة',
			'student.governorateGiza' => 'الجيزة',
			'student.governorateAlex' => 'الإسكندرية',
			'student.governorateMansura' => 'المنصورة',
			'student.regionLabel' => 'المنطقة',
			'student.regionHint' => 'اختر المنطقة',
			'student.regionNasrCity' => 'مدينة نصر',
			'student.regionMaadi' => 'المعادي',
			'student.regionHaram' => 'الهرم',
			'student.regionShorouk' => 'الشروق',
			'student.regionDokki' => 'الدقي',
			'student.regionSheikhZayed' => 'الشيخ زايد',
			'student.regionSmouha' => 'سموحة',
			'student.regionGleem' => 'جليم',
			'student.gradeLabel' => 'الصف الدراسي',
			'student.gradeHint' => 'اختر الصف',
			'student.gradeFirstSecondary' => 'أولى ثانوي',
			'student.gradeSecondSecondary' => 'تانية ثانوي',
			'student.gradeThirdSecondary' => 'تالتة ثانوي',
			'student.schoolNameLabel' => 'اسم المدرسة',
			'student.schoolNameHint' => 'أدخل اسم المدرسة',
			'student.educationAdminLabel' => 'الإدارة التعليمية',
			'student.educationAdminHint' => 'أدخل الإدارة التعليمية',
			'student.selectTeacherLabel' => 'اختر المدرس',
			'student.teacherInfoNote' => 'المحتوى والكورسات والكويزات هتكون مخصصة للمدرس اللي اخترته',
			'student.teacher1Name' => 'أ. أحمد',
			'student.teacher1Subject' => 'فيزياء',
			'student.teacher2Name' => 'أ. محمد',
			'student.teacher2Subject' => 'كيمياء',
			'student.teacher3Name' => 'أ. خالد',
			'student.teacher3Subject' => 'رياضيات',
			'student.contactInfoLabel' => 'بيانات التواصل',
			'student.passwordAndPhotosLabel' => 'كلمة المرور والصور',
			'student.confirmAndCreateAccount' => 'تأكيد وإنشاء الحساب',
			'student.submissionTitle' => 'تم استلام طلبك',
			'student.submissionDescription' => 'حسابك دلوقتي قيد المراجعة. هيوصلك رسالة واتساب بكل التفاصيل بعد الموافقة.',
			'student.whatsappDetailsTitle' => 'الرسالة هتحتوي على:',
			'student.studentCodeLabel' => 'كود الطالب',
			'student.firstClassLabel' => 'ميعاد أول حصة',
			'student.firstClassDate' => 'الجمعة 10:00 ص',
			'student.centerLocationLabel' => 'مكان السنتر',
			'student.groupLinkLabel' => 'لينك جروب واتساب',
			'student.groupLinkValue' => 'whatsapp.com/invite/MentorX',
			'student.socialLinksLabel' => 'روابط السوشيال',
			'student.socialLinksValue' => 'facebook.com/MentorX | instagram.com/MentorX',
			'student.submitRegistration' => 'إرسال التسجيل',
			'student.pendingTitle' => 'الحساب قيد المراجعة',
			'student.pendingDescription' => 'حسابك لسه بيتراجع دلوقتي. لأي استفسار كلّم الدعم.',
			'student.whatsappSupport' => 'تواصل واتساب',
			'student.supportPhoneLabel' => 'رقم الدعم',
			'student.supportPhoneValue' => '01127798986',
			'student.backToLogin' => 'رجوع لتسجيل الدخول',
			'student.rejectedTitle' => 'تم رفض طلبك',
			'student.rejectedDescription' => 'للأسف تم رفض طلب التسجيل. تقدر تعدّل بياناتك وتقدّم تاني.',
			'student.rejectedReason' => 'السبب: صورة البطاقة مش واضحة. ارفع صورة أوضح وقدّم تاني.',
			'student.editAndResubmit' => 'عدّل البيانات وقدّم تاني',
			'student.backLabel' => 'رجوع',
			'student.blockedTitle' => 'الحساب محظور',
			'student.blockedDescription' => 'حسابك محظور. لأي استفسار كلّم الدعم.',
			'student.deviceLimitTitle' => 'مسجّل على جهاز تاني',
			'student.deviceLimitDescription' => 'حسابك مفتوح على جهاز تاني. لازم تعمل تسجيل خروج من الجهاز التاني الأول، أو كلّم الدعم.',
			'student.deviceRegisteredLabel' => 'الجهاز المسجل',
			'student.deviceRegisteredValue' => 'Iphone 13 pro max',
			'student.contactTechSupport' => 'تواصل مع الدعم الفني',
			'student.forgotTitle' => 'نسيت كلمة المرور',
			'student.forgotHeading' => 'استعادة كلمة المرور',
			'student.forgotDescription' => 'أدخل رقم موبايلك المسجل وهنبعتلك كود التحقق على واتساب',
			'student.sendCode' => 'ابعت كود التحقق',
			'student.resetTitle' => 'تغيير كلمة المرور',
			'student.resetHeading' => 'كلمة مرور جديدة',
			'student.resetDescription' => 'أدخل كلمة المرور الجديدة',
			'student.newPasswordLabel' => 'كلمة المرور الجديدة',
			'student.newPasswordHint' => 'أدخل كلمة المرور الجديدة',
			'student.savePassword' => 'حفظ كلمة المرور',
			'student.requiredField' => 'الحقل ده مطلوب.',
			'student.incorrectCredentials' => 'الرقم أو كلمة المرور غلط.',
			'student.deviceMismatch' => 'أنت مسجّل على جهاز تاني. اعمل تسجيل خروج من الجهاز التاني الأول.',
			'student.phoneAlreadyRegistered' => 'رقمك مسجل قبل كده. جرّب تسجّل دخول.',
			'student.phoneNotRegistered' => 'الرقم ده مش مسجل.',
			'student.passwordMismatch' => 'كلمتا المرور مش متطابقين.',
			'student.idMissing' => 'لازم ترفع الصور المطلوبة.',
			'student.otpError' => 'اكتب الكود كامل.',
			'student.appName' => 'MentorX',
			'student.platformTagline' => '',
			'student.splashTagline' => 'علّم • نظّم • وصّل',
			'student.commonSkip' => 'تخطي',
			'student.commonStartNow' => 'ابدأ دلوقتي',
			'student.commonOr' => 'أو',
			'student.commonSave' => 'حفظ',
			'student.commonCancel' => 'إلغاء',
			'student.commonConfirm' => 'تأكيد',
			'student.commonDone' => 'تم',
			'student.commonClose' => 'إغلاق',
			'student.commonSearch' => 'بحث',
			'student.commonSeeAll' => 'عرض الكل',
			'student.commonLoading' => 'جاري التحميل...',
			'student.commonError' => 'حصل خطأ',
			'student.commonRetry' => 'حاول تاني',
			'student.commonYes' => 'أيوه',
			'student.commonNo' => 'لأ',
			'student.commonDelete' => 'حذف',
			'student.commonEdit' => 'تعديل',
			'student.egp' => 'ج.م',
			'student.coursesTitle' => 'الدروس',
			'student.coursePhysics' => 'الفيزياء - تالتة ثانوي',
			'student.unitPrefix' => 'الوحدة',
			'student.sessions' => 'حصص',
			'student.completed' => 'مكتمل',
			'student.locked' => 'مقفول',
			'student.inProgress' => 'جاري',
			'student.sessionsTab' => 'الحصص',
			'student.quizzesTab' => 'الكويزات',
			'student.assignmentsTab' => 'الواجبات',
			'student.filesTab' => 'ملفات',
			'student.minutes' => 'دقيقة',
			'student.video' => 'فيديو',
			'student.pdf' => 'PDF',
			'student.quiz' => 'كويز',
			'student.assignment' => 'واجب',
			'student.free' => 'مجاني',
			'student.open' => 'مفتوح',
			'student.premium' => 'مدفوع',
			'student.lessonExplanation' => 'شرح الدرس',
			'student.part1' => 'الجزء الأول',
			'student.part2' => 'الجزء الثاني',
			'student.lessonSummary' => 'ملخص الدرس',
			'student.quickQuiz' => 'كويز سريع',
			'student.lessonAssignment' => 'واجب الدرس',
			'student.submissionRequired' => 'مطلوب تسليم',
			'student.pages' => 'صفحات',
			'student.questions' => 'أسئلة',
			'student.videoViews' => 'مشاهدات',
			'student.videoDuration' => 'المدة',
			'student.pdfPageOf' => 'من',
			'student.lockedContentTitle' => 'هذا المحتوى مقفول',
			'student.lockedContentDesc' => 'يمكنك فتح هذا المحتوى عن طريق الشراء من المحفظة أو إدخال كود الحصة',
			'student.buyFor' => 'شراء بـ',
			'student.enterCode' => 'إدخال كود',
			'student.unitMechanics' => 'الوحدة الأولى: الميكانيكا',
			'student.unitElectricity' => 'الوحدة الثانية: الكهربية',
			'student.unitWaves' => 'الوحدة الثالثة: الموجات',
			'student.unitDynamics' => 'الوحدة الرابعة: الديناميكا',
			'student.unitHeat' => 'الوحدة الخامسة: الحرارة',
			'student.introToWaves' => 'مقدمة في الموجات',
			'student.typesOfWaves' => 'أنواع الموجات',
			'student.waveProperties' => 'خصائص الموجات',
			'student.soundWaves' => 'الموجات الصوتية',
			'student.reviewAndPractice' => 'مراجعة وتدريبات',
			'student.dashboardTitle' => 'الصفحة الرئيسية',
			'student.welcome' => 'أهلاً',
			'student.homeGreeting' => 'أهلاً بك',
			'student.homeTitle' => 'الصفحة الرئيسية',
			'student.myLessons' => 'حصصي',
			'student.myExams' => 'امتحاناتي',
			'student.myGrades' => 'درجاتي',
			'student.wallet' => 'المحفظة',
			'student.notifications' => 'الإشعارات',
			'student.settings' => 'الإعدادات',
			'student.noLessonsToday' => 'مفيش حصص النهاردة',
			'student.upcomingLessons' => 'الحصص القادمة',
			'student.attendance' => 'الحضور',
			'student.profile' => 'الملف الشخصي',
			'student.logout' => 'تسجيل خروج',
			'student.myCourses' => 'كورساتي',
			'student.aiChat' => 'المساعد الذكي',
			'student.attendanceRate' => 'نسبة الحضور',
			'student.averageScore' => 'متوسط الدرجات',
			'student.pendingAssignments' => 'واجبات معلقة',
			'student.walletBalance' => 'رصيد المحفظة',
			'student.quickActions' => 'إجراءات سريعة',
			'student.navHome' => 'الرئيسية',
			'student.navCourses' => 'الدروس',
			'student.navQuizzes' => 'الكويزات',
			'student.navWallet' => 'المحفظة',
			'student.navAccount' => 'حسابي',
			'student.welcomeBack' => 'أهلاً بعودتك،',
			'student.welcomeSubtitle' => 'مستعد تكمل رحلتك التعليمية؟',
			'student.goToDashboard' => 'الذهاب للرئيسية',
			'student.notificationsTitle' => 'الإشعارات',
			'student.markAllRead' => 'تعيين الكل كمقروء',
			'student.minutesAgo' => 'منذ %s دقائق',
			'student.hoursAgo' => 'منذ %s ساعات',
			'student.daysAgo' => 'منذ %s أيام',
			'student.quizCorrected' => 'تم تصحيح الكويز',
			'student.newAssignment' => 'واجب جديد',
			'student.sessionReminder' => 'تذكير بالحضور',
			'student.walletCharged' => 'تم شحن المحفظة',
			'student.absenceAlert' => 'تنبيه غياب',
			'student.store' => 'المتجر',
			'student.addToCart' => 'إضافة للسلة',
			'student.shoppingCart' => 'سلة التسوق',
			'student.products' => 'المنتجات',
			'student.checkout' => 'إتمام الشراء',
			'student.pagesCount' => 'الصفحات',
			'student.availability' => 'الحالة',
			'student.available' => 'متوفر',
			'student.physicsBook' => 'ملزمة الفيزياء',
			'student.practiceWorkbook' => 'كراسة تدريبات',
			'student.mentorxTshirt' => 'تيشيرت MentorX',
			'student.studentBag' => 'حقيبة الطالب',
			'student.orderSummary' => 'ملخص الطلب',
			'student.profileTitle' => 'الملف الشخصي',
			'student.personalData' => 'البيانات الشخصية',
			'student.name' => 'الاسم',
			'student.phone' => 'الهاتف',
			'student.grade' => 'الصف',
			'student.center' => 'السنتر',
			'student.editRequest' => 'طلب تعديل',
			'student.editProfile' => 'طلب تعديل',
			'student.editsNeedApproval' => 'التعديلات تحتاج موافقة',
			'student.school' => 'المدرسة',
			'student.reasonForEdit' => 'سبب التعديل',
			'student.sendRequest' => 'إرسال الطلب',
			'student.changePassword' => 'تغيير كلمة المرور',
			'student.currentPassword' => 'كلمة المرور الحالية',
			'student.newPassword' => 'كلمة المرور الجديدة',
			'student.confirmNewPassword' => 'تأكيد كلمة المرور الجديدة',
			'student.saveChanges' => 'حفظ التغييرات',
			'student.quizIntroTitle' => 'معلومات الكويز',
			'student.quizUnitTitle' => 'كويز الوحدة الثالثة',
			'student.quizTitle' => 'كويز الموجات',
			'student.quizSubtitle' => 'اختبر معلوماتك في درس الموجات',
			'student.questionCount' => 'عدد الأسئلة',
			'student.duration' => 'المدة',
			'student.passGrade' => 'درجة النجاح',
			'student.attempts' => 'المحاولات',
			'student.instructions' => 'تعليمات:',
			'student.instructionRead' => 'اقرأ كل سؤال بعناية قبل الإجابة',
			'student.instructionReview' => 'يمكنك مراجعة إجاباتك قبل التسليم',
			'student.instructionNoReturn' => 'لا يمكن العودة بعد تسليم الكويز',
			'student.startQuiz' => 'ابدأ الكويز',
			'student.questionOf' => 'السؤال %s من %s',
			'student.submitQuiz' => 'تسليم الكويز',
			'student.backToQuestions' => 'العودة للأسئلة',
			'student.answeredCount' => 'تم الإجابة على',
			'student.jumpToQuestion' => 'انتقل لسؤال محدد:',
			'student.unansweredNote' => '%s أسئلة لم تتم إجابتها',
			'student.quizResult' => 'نتيجة الكويز',
			'student.excellent' => 'ممتاز!',
			'student.veryGood' => 'جيد جداً',
			'student.good' => 'جيد',
			'student.fail' => 'حاول تاني',
			'student.greatResult' => 'أحسنت! نتيجة رائعة',
			'student.correctAnswers' => 'إجابة صحيحة',
			'student.wrongAnswers' => 'إجابة خاطئة',
			'student.timeTaken' => 'الوقت المستغرق',
			'student.reviewAnswers' => 'مراجعة الإجابات',
			'student.correctAnswer' => 'الإجابة الصحيحة:',
			'student.minutesShort' => 'د',
			'student.claimReward' => 'احصل على مكافأتك',
			'student.quizRewardsTitle' => 'مكافآت الكويز',
			'student.congratulations' => 'مبروك!',
			'student.rewardEarnedMsg' => 'حققت درجة ممتازة وحصلت على مكافأة خاصة!',
			'student.yourScore' => 'درجتك',
			'student.pointsEarned' => 'نقاط مكتسبة',
			'student.excellentBadge' => 'شارة التميز',
			'student.badgeUnlocked' => 'تم فتح الشارة - أضيفت لملفك الشخصي',
			'student.backToQuizzes' => 'العودة للرئيسية',
			'student.quizListTitle' => 'الكويزات',
			'student.gamificationTitle' => 'المكافآت والإنجازات',
			'student.goldLevel' => 'المستوى الذهبي',
			'student.xpPoints' => 'نقاط XP',
			'student.quizCompleted' => 'كويز مكتمل',
			'student.badge' => 'شارة',
			'student.toNextLevel' => 'للمستوى التالي',
			'student.dailyStreak' => 'سلسلة الحل اليومي',
			'student.streakDaysMsg' => '%s أيام متتالية - واصل للمكافأة!',
			'student.earnedBadges' => 'الشارات المكتسبة',
			'student.leaderboard' => 'ترتيب المتفوقين',
			'student.sat' => 'سبت',
			'student.sun' => 'أحد',
			'student.mon' => 'اثنين',
			'student.tue' => 'ثلاثاء',
			'student.wed' => 'أربعاء',
			'student.thu' => 'خميس',
			'student.fri' => 'جمعة',
			'student.lightningSpeed' => 'سرعة البرق',
			'student.perfectScore' => 'درجة كاملة',
			'student.fiveDayStreak' => '5 أيام متتالية',
			'student.tenQuizzes' => '10 كويزات',
			'student.physicsLion' => 'أسد الفيزياء',
			'student.settingsTitle' => 'الإعدادات',
			'student.changePasswordSetting' => 'تغيير كلمة المرور',
			'student.notificationsSetting' => 'الإشعارات',
			'student.supportSetting' => 'الدعم الفني',
			'student.aboutSetting' => 'عن التطبيق',
			'student.logoutSetting' => 'تسجيل الخروج',
			'student.supportTitle' => 'تواصل معنا',
			'student.supportDesc' => 'نحن هنا لمساعدتك! تواصل معنا عبر أي من القنوات التالية',
			'student.whatsapp' => 'واتساب',
			'student.phoneCall' => 'هاتف',
			'student.email' => 'البريد',
			'student.aboutTitle' => 'عن التطبيق',
			'student.aboutDesc' => 'منصة تعليمية متكاملة تربط بين المحاضرين والطلاب',
			'student.version' => 'الإصدار',
			'student.lastUpdate' => 'آخر تحديث',
			'student.walletTitle' => 'المحفظة',
			'student.currentBalance' => 'الرصيد الحالي',
			'student.charge' => 'شحن',
			'student.code' => 'كود',
			'student.history' => 'السجل',
			'student.recentTransactions' => 'آخر المعاملات',
			'student.addBalance' => 'شحن رصيد',
			'student.amount' => 'المبلغ',
			'student.choosePaymentMethod' => 'اختر وسيلة الدفع',
			'student.vodafoneCash' => 'فودافون كاش',
			'student.vodafoneDesc' => 'الدفع من محفظة فودافون',
			'student.instaPay' => 'إنستا باي',
			'student.instaPayDesc' => 'تحويل عبر إنستا باي',
			'student.fawry' => 'فوري',
			'student.fawryDesc' => 'الدفع من خلال فوري',
			'student.continueBtn' => 'متابعة',
			'student.redeemCode' => 'استخدام كود',
			'student.enterCodeDesc' => 'أدخل كود الخصم أو الحصة',
			'student.activateCode' => 'تفعيل الكود',
			'student.purchaseConfirm' => 'تأكيد العملية',
			'student.paymentMethod' => 'وسيلة الدفع',
			'student.total' => 'الإجمالي',
			'student.confirmPayment' => 'تأكيد الدفع',
			'student.paymentSuccess' => 'تمت العملية بنجاح!',
			'student.balanceAdded' => 'تم إضافة %s ج.م إلى رصيدك',
			'student.newBalance' => 'الرصيد الجديد',
			'student.backToWallet' => 'العودة للمحفظة',
			'student.transactionsTitle' => 'سجل المعاملات',
			'student.chargeBalance' => 'شحن رصيد',
			'student.purchaseCourse' => 'شراء حصة',
			'student.discountCode' => 'كود خصم',
			'student.purchaseBook' => 'شراء - كتاب',
			'student.today' => 'اليوم',
			'student.yesterday' => 'أمس',
			'parent.dashboardTitle' => 'بوابة ولي الأمر',
			'parent.welcomeBack' => 'أهلاً بعودتك،',
			'parent.services' => 'الخدمات',
			'parent.recentActivity' => 'آخر النشاطات',
			'parent.viewAll' => 'عرض الكل',
			'parent.retry' => 'إعادة المحاولة',
			'parent.unableToLoad' => 'غير قادر على تحميل لوحة التحكم',
			'parent.myProfile' => 'ملفي الشخصي',
			'parent.signOut' => 'تسجيل الخروج',
			'parent.accountInfo' => 'معلومات الحساب',
			'parent.appSettings' => 'إعدادات التطبيق',
			'parent.notifications' => 'الإشعارات',
			'parent.security' => 'الأمان',
			'parent.childSwitcher' => 'تبديل الأبناء',
			'parent.noData' => 'لا توجد بيانات',
			'parent.announcements' => 'الإعلانات',
			'parent.academicMonitor' => 'المتابعة الأكاديمية',
			'parent.financialMonitor' => 'المتابعة المالية',
			'parent.attendanceMonitor' => 'متابعة الغياب',
			'parent.overallAverage' => 'المعدل العام',
			'parent.enrolledCourses' => 'الدورات المسجل بها',
			'parent.childWalletBalance' => 'رصيد محفظة الابن',
			'parent.spentThisMonth' => 'المنفق هذا الشهر',
			'parent.transactionHistory' => 'سجل المعاملات',
			'parent.pointsEarned' => 'النقاط المكتسبة',
			'parent.home.parentAccount' => 'حساب ولي الأمر',
			'parent.home.addChild' => 'إضافة ابن',
			'parent.home.academicStanding' => 'المستوى الأكاديمي',
			'parent.home.avgGrade' => 'متوسط الدرجات',
			'parent.home.attendance' => 'الحضور',
			'parent.home.unpaidFees' => 'رسوم غير مدفوعة',
			'parent.home.noRecentActivity' => 'لا يوجد نشاط حديث',
			'parent.home.noRecentActivityHint' => 'ستظهر النشاطات هنا بمجرد أن يبدأ ابنك في رحلته التعليمية.',
			'parent.home.noChildrenTitle' => 'لم يتم ربط أبناء',
			'parent.home.noChildrenHint' => 'اربط أول ابن لك لمتابعة تقدمه.',
			'parent.home.linkChild' => 'ربط ابن',
			'parent.home.updatedAt' => ({required Object time}) => 'آخر تحديث ${time}',
			'parent.home.upcomingSessions' => 'الحصص القادمة',
			'parent.home.noUpcomingSessions' => 'لا توجد حصص قادمة',
			'parent.home.recentGrades' => 'أحدث الدرجات',
			'parent.home.noRecentGrades' => 'لا توجد درجات بعد',
			'parent.home.viewDetails' => 'عرض التفاصيل',
			'parent.quickActions.attendance' => 'الحضور',
			'parent.quickActions.courses' => 'الكورسات',
			'parent.quickActions.fees' => 'المصاريف',
			'parent.quickActions.messages' => 'الرسائل',
			'parent.quickActions.grades' => 'الدرجات',
			'parent.quickActions.announcements' => 'الإعلانات',
			'parent.quickActions.schedule' => 'الجدول',
			'parent.quickActions.support' => 'الدعم',
			'parent.onboarding.parentPortalTag' => 'بوابة ولي الأمر',
			'parent.onboarding.slide1Title' => 'تابع التقدم',
			'parent.onboarding.slide1Description' => 'تابع درجات ابنك وحضوره وإنجازاته الأكاديمية لحظة بلحظة.',
			'parent.onboarding.slide2Title' => 'ابقَ على تواصل',
			'parent.onboarding.slide2Description' => 'تواصل مباشر مع المعلمين وإدارة المدرسة لتجربة تعليمية أفضل.',
			'parent.onboarding.slide3Title' => 'مدفوعات آمنة',
			'parent.onboarding.slide3Description' => 'أدر المصاريف المدرسية ورصيد محفظة ابنك بأمان وسهولة.',
			'parent.onboarding.skip' => 'تخطّي',
			'parent.onboarding.getStarted' => 'ابدأ الآن',
			'parent.auth.otpTitle' => 'تأكيد رقم الهاتف',
			'parent.auth.otpSubtitle' => ({required Object phone}) => 'أدخل الكود المكوّن من 6 أرقام المُرسل إلى\n${phone}',
			'parent.auth.otpFieldLabel' => 'كود التحقق',
			'parent.auth.otpFieldHint' => '000000',
			'parent.auth.verifyAndContinue' => 'تأكيد ومتابعة',
			'parent.auth.resending' => 'جاري إعادة الإرسال…',
			'parent.auth.resendCode' => 'إعادة إرسال الكود',
			'parent.auth.resendInSeconds' => ({required Object seconds}) => 'إعادة الإرسال خلال ${seconds} ثانية',
			'parent.auth.verificationFailed' => 'فشل التحقق',
			'parent.auth.appName' => 'MentorX لولي الأمر',
			'parent.auth.loginTagline' => 'تابع رحلة ابنك الأكاديمية بثقة كاملة',
			'parent.auth.phoneNumberLabel' => 'رقم الهاتف',
			'parent.auth.phoneNumberHint' => 'أدخل رقم هاتفك',
			'parent.auth.phoneRequired' => 'من فضلك أدخل رقم الهاتف',
			'parent.auth.passwordLabel' => 'كلمة المرور',
			'parent.auth.passwordRequired' => 'من فضلك أدخل كلمة المرور',
			'parent.auth.forgotPassword' => 'نسيت كلمة المرور؟',
			'parent.auth.signInToDashboard' => 'تسجيل الدخول',
			'parent.auth.newToMentorX' => 'جديد في MentorX؟',
			'parent.auth.createAccount' => 'إنشاء حساب',
			'parent.auth.loginFailed' => 'فشل تسجيل الدخول. حاول مرة أخرى.',
			'parent.auth.passwordRecoveryHeading' => 'استرجاع كلمة المرور',
			'parent.auth.forgotPasswordTitle' => 'نسيت كلمة المرور؟',
			'parent.auth.forgotPasswordSubtitle' => 'لا تقلق! أدخل رقم هاتفك المسجّل وسنرسل لك كود تحقق لإعادة تعيين حسابك بأمان.',
			'parent.auth.sendVerificationCode' => 'إرسال كود التحقق',
			'parent.auth.backToLogin' => 'الرجوع لتسجيل الدخول',
			'parent.auth.sendCodeFailed' => 'تعذّر إرسال الكود',
			'parent.auth.resetPasswordTitle' => 'إعادة تعيين كلمة المرور',
			'parent.auth.resetPasswordSubtitle' => ({required Object phone}) => 'أدخل الكود المكوّن من 6 أرقام المُرسل إلى\n${phone}',
			'parent.auth.otpCodeLabel' => 'كود التحقق',
			'parent.auth.newPasswordLabel' => 'كلمة المرور الجديدة',
			'parent.auth.confirmPasswordLabel' => 'تأكيد كلمة المرور',
			'parent.auth.passwordPlaceholder' => '••••••••',
			'parent.auth.updatePasswordNow' => 'تحديث كلمة المرور',
			'parent.auth.validationCheckInputs' => 'من فضلك تحقّق من البيانات المدخلة وحاول مرة أخرى',
			'parent.auth.passwordResetSuccess' => 'تم إعادة تعيين كلمة المرور بنجاح',
			'parent.auth.regStep1Title' => 'ربط ابنك',
			'parent.auth.regStep2Title' => 'البيانات الشخصية',
			'parent.auth.regStep3Title' => 'الأمان',
			'parent.auth.regDefaultTitle' => 'التسجيل',
			'parent.auth.regFindStudent' => 'ابحث عن الطالب',
			'parent.auth.regConfirmChild' => 'أكّد الابن',
			'parent.auth.regContinue' => 'متابعة',
			'parent.auth.regCreateAccount' => 'إنشاء حساب',
			'parent.auth.regPleaseWait' => 'جاري المعالجة…',
			'parent.auth.regAlreadyHaveAccount' => 'لديك حساب بالفعل؟ تسجيل الدخول',
			'parent.auth.regLookupPhoneTab' => 'الهاتف',
			'parent.auth.regLookupCodeTab' => 'كود الطالب',
			'parent.auth.regChildPhoneLabel' => 'هاتف الابن',
			'parent.auth.regChildPhoneHint' => 'أدخل رقم الهاتف المسجّل',
			'parent.auth.regStudentCodeLabel' => 'كود الطالب',
			'parent.auth.regStudentCodeHint' => 'أدخل الكود المميّز',
			'parent.auth.regFirstNameLabel' => 'الاسم الأول',
			_ => null,
		} ?? switch (path) {
			'parent.auth.regFirstNameHint' => 'مثال: أحمد',
			'parent.auth.regLastNameLabel' => 'الاسم الأخير',
			'parent.auth.regLastNameHint' => 'مثال: محمد',
			'parent.auth.regYourPhoneHint' => 'رقم هاتفك',
			'parent.auth.regEmailLabel' => 'البريد الإلكتروني',
			'parent.auth.regEmailHint' => 'اختياري',
			'parent.auth.regSecurityHint' => 'اضبط كلمة مرور قوية لحماية الوصول إلى حسابك.',
			'parent.auth.regRelationshipLabel' => 'صلة القرابة بالابن',
			'parent.auth.regChildConfirmed' => 'تم تأكيد الابن بنجاح',
			'parent.auth.regConfirmIsYourChild' => 'أكّد إذا كان هذا هو ابنك',
			'parent.auth.regErrorLookupEmpty' => 'من فضلك أدخل رقم هاتف الابن أو كود الطالب.',
			'parent.auth.regErrorStudentNotFound' => 'لم يتم العثور على طالب بهذا الرقم.',
			'parent.auth.regErrorFindFailed' => 'تعذّر البحث عن الطالب. حاول مرة أخرى.',
			'parent.auth.regErrorFindChildFirst' => 'من فضلك ابحث عن ابنك أولًا.',
			'parent.auth.regErrorConfirmChild' => 'من فضلك أكّد أن هذا هو ابنك.',
			'parent.auth.regErrorFirstNameShort' => 'الاسم الأول يجب أن يكون حرفين على الأقل.',
			'parent.auth.regErrorLastNameShort' => 'الاسم الأخير يجب أن يكون حرفين على الأقل.',
			'parent.auth.regErrorInvalidPhone' => 'من فضلك أدخل رقم هاتف مصري صحيح.',
			'parent.auth.regErrorInvalidEmail' => 'من فضلك أدخل بريدًا إلكترونيًا صحيحًا.',
			'parent.auth.regErrorRelationshipRequired' => 'من فضلك اختر صلة القرابة بالابن.',
			'parent.auth.regErrorPasswordWeak' => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.',
			'parent.auth.regErrorPasswordMismatch' => 'كلمتا المرور غير متطابقتين.',
			'parent.auth.regErrorRegistrationFailed' => 'فشل التسجيل. حاول مرة أخرى.',
			'parent.auth.regErrorPhoneAlreadyExists' => 'يوجد حساب مسجّل بهذا الرقم بالفعل.',
			'parent.profile.verifiedAccount' => 'حساب موثّق',
			'parent.profile.fullNameLabel' => 'الاسم بالكامل',
			'parent.profile.phoneNumberLabel' => 'رقم الهاتف',
			'parent.profile.emailLabel' => 'البريد الإلكتروني',
			'parent.profile.notificationsEnabled' => 'مفعّلة',
			'parent.profile.notificationsDisabled' => 'متوقّفة',
			'parent.profile.securityValue' => 'كلمة المرور والمصادقة الحيوية',
			'parent.profile.signOutConfirmTitle' => 'تسجيل الخروج؟',
			'parent.profile.signOutConfirmMessage' => 'سيتم تسجيل خروجك وإعادتك إلى شاشة تسجيل الدخول.',
			'parent.profile.signOutAction' => 'تسجيل الخروج',
			'parent.profile.signOutCancel' => 'إلغاء',
			'parent.profile.fallbackName' => 'ولي أمر',
			'parent.profile.settingsTitle' => 'الإعدادات',
			'parent.profile.appConfigurationSection' => 'إعدادات التطبيق',
			'parent.profile.preferencesSection' => 'التفضيلات',
			'parent.profile.supportSection' => 'الدعم',
			'parent.profile.pushNotifications' => 'إشعارات الدفع',
			'parent.profile.themeMode' => 'وضع الواجهة',
			'parent.profile.themeSystem' => 'النظام',
			'parent.profile.themeLight' => 'فاتح',
			'parent.profile.themeDark' => 'داكن',
			'parent.profile.appLanguage' => 'لغة التطبيق',
			'parent.profile.languageEnglish' => 'English',
			'parent.profile.languageArabic' => 'العربية',
			'parent.profile.helpCenter' => 'مركز المساعدة',
			'parent.profile.helpCenterValue' => 'الأسئلة الشائعة والدعم',
			'parent.profile.aboutTitle' => 'عن MentorX',
			'parent.profile.aboutVersion' => ({required Object version}) => 'الإصدار ${version}',
			'parent.communication.notificationsTitle' => 'الإشعارات',
			'parent.communication.announcementsTitle' => 'الإعلانات',
			'parent.communication.whatsAppTitle' => 'مجموعات واتساب',
			'parent.communication.noNotificationsTitle' => 'لا توجد إشعارات',
			'parent.communication.noNotificationsHint' => 'كل شيء على ما يرام — ستظهر التحديثات الجديدة هنا.',
			'parent.communication.noAnnouncementsTitle' => 'لا توجد إعلانات',
			'parent.communication.noAnnouncementsHint' => 'ابق على اطلاع! ستظهر إعلانات المدرسة هنا.',
			'parent.communication.noGroupsTitle' => 'لا توجد مجموعات',
			'parent.communication.noGroupsHint' => 'لا توجد مجموعات واتساب متاحة لهذا الابن بعد.',
			'parent.communication.readMore' => 'اقرأ المزيد',
			'parent.communication.joinGroup' => 'انضمام',
			'parent.communication.groupSubtitle' => 'اضغط للانضمام والحصول على آخر التحديثات',
			'parent.academic.pageTitle' => 'المتابعة الأكاديمية',
			'parent.academic.overallAverageHeading' => 'المعدل العام',
			'parent.academic.averageLabel' => 'المعدل',
			'parent.academic.gradedLabel' => 'المصححة',
			'parent.academic.pendingLabel' => 'المعلقة',
			'parent.academic.noCoursesTitle' => 'لا توجد كورسات',
			'parent.academic.noCoursesHint' => 'ستظهر البيانات الأكاديمية هنا بمجرد توفرها.',
			'parent.academic.sessionsCount' => ({required Object count}) => '${count} حصة',
			'parent.academic.completedSessionsLabel' => ({required Object completed, required Object total}) => '${completed} / ${total} حصة',
			'parent.academic.courseDetailsTitle' => 'تفاصيل الكورس',
			'parent.financial.balance' => 'الرصيد',
			'parent.financial.spent' => 'المنفق',
			'parent.financial.points' => 'النقاط',
			'parent.financial.noDataTitle' => 'لا توجد بيانات',
			'parent.financial.noDataHint' => 'ستظهر البيانات المالية هنا بمجرد توفرها.',
			'parent.financial.noTransactionsTitle' => 'لا توجد معاملات',
			'parent.financial.noTransactionsHint' => 'لم يتم العثور على سجل معاملات لهذا الابن.',
			'parent.financial.credit' => 'إيداع',
			'parent.financial.debit' => 'خصم',
			'parent.financial.deposit' => 'شحن',
			'parent.financial.withdrawal' => 'سحب',
			'parent.financial.payment' => 'دفع',
			'parent.financial.refund' => 'استرجاع',
			'parent.financial.reward' => 'مكافأة',
			'parent.financial.statusPending' => 'قيد المعالجة',
			'parent.financial.statusSuccess' => 'ناجحة',
			'parent.financial.statusFailed' => 'فاشلة',
			'parent.attendanceTracking.pageTitle' => 'متابعة الحضور',
			'parent.attendanceTracking.attendanceLog' => 'سجل الحضور',
			'parent.attendanceTracking.present' => 'حاضر',
			'parent.attendanceTracking.absent' => 'غائب',
			'parent.attendanceTracking.late' => 'متأخر',
			'parent.attendanceTracking.excused' => 'بعذر',
			'parent.attendanceTracking.noRecordsTitle' => 'لا توجد سجلات',
			'parent.attendanceTracking.noRecordsHint' => 'لم يتم العثور على سجلات حضور لهذا الطالب.',
			'parent.attendanceTracking.regularSession' => 'حصة عادية',
			'parent.attendanceTracking.generalAcademic' => 'عام',
			'parent.attendanceTracking.onlineSession' => 'أونلاين',
			'parent.attendanceTracking.checkInTimeLabel' => ({required Object time}) => 'تم التسجيل في ${time}',
			'parent.assessments.pageTitle' => 'الأداء الأكاديمي',
			'parent.assessments.overallPerformance' => 'الأداء العام',
			'parent.assessments.average' => 'المعدل',
			'parent.assessments.graded' => 'المصححة',
			'parent.assessments.pending' => 'المعلقة',
			'parent.assessments.passed' => 'ناجح',
			'parent.assessments.failed' => 'راسب',
			'parent.assessments.assessmentHistory' => 'سجل التقييمات',
			'parent.assessments.noAssessmentsTitle' => 'لا توجد تقييمات',
			'parent.assessments.noAssessmentsHint' => 'ستظهر بيانات التقييم الأكاديمي هنا فور تقديمها.',
			'parent.assessments.passLabel' => 'ناجح',
			'parent.assessments.failLabel' => 'راسب',
			'parent.assessments.scoreLabel' => ({required Object score, required Object total}) => 'الدرجة: ${score}/${total}',
			'parent.assessments.quizPrefix' => 'اختبار',
			'parent.assessments.assignmentPrefix' => 'واجب',
			'parent.assessments.examPrefix' => 'امتحان',
			'parent.assessments.trendUp' => 'في تحسن',
			'parent.assessments.trendDown' => 'في انخفاض',
			'parent.assessments.trendStable' => 'مستقر',
			'parent.children.title' => 'الأبناء المرتبطين',
			'parent.children.linkNewChild' => 'ربط ابن جديد',
			'parent.children.linkChildTitle' => 'اربط ابنك',
			'parent.children.linkChildHint' => 'أدخل رقم القيد الخاص بابنك أو رقم الهاتف المسجل لربط حسابه.',
			'parent.children.searchLabel' => 'ابحث عن الابن',
			'parent.children.searchHint' => 'رقم القيد / رقم الهاتف',
			'parent.children.confirmLink' => 'تأكيد وربط الابن',
			'parent.children.specifyRelationship' => 'حدد صلة القرابة',
			'parent.children.linkSuccess' => 'تم ربط الابن بنجاح',
			'parent.children.unlinkConfirmTitle' => 'إزالة الابن؟',
			'parent.children.unlinkConfirmMessage' => ({required Object name}) => 'سيتم إلغاء ربط ${name} من حسابك. يمكنك إعادة الربط في أي وقت.',
			'parent.children.unlink' => 'إلغاء الربط',
			'parent.children.unlinkSuccess' => 'تم إلغاء ربط الابن',
			'parent.children.studentIdLabel' => ({required Object id}) => 'رقم الطالب: ${id}',
			'parent.children.studentCodeLabel' => ({required Object code}) => 'الكود: ${code}',
			'parent.children.gradeLabel' => ({required Object grade}) => 'الصف: ${grade}',
			'parent.children.centerLabel' => ({required Object center}) => 'السنتر: ${center}',
			'parent.children.cancel' => 'إلغاء',
			'parent.children.relationship.father' => 'أب',
			'parent.children.relationship.mother' => 'أم',
			'parent.children.relationship.guardian' => 'وصي',
			'parent.children.relationship.other' => 'أخرى',
			'parent.children.errorAlreadyLinked' => 'هذا الابن مرتبط بالفعل بحسابك.',
			'parent.children.errorStudentNotFound' => 'لم نجد طالبًا بهذا الرقم.',
			'parent.children.errorNetwork' => 'مشكلة في الشبكة. تحقّق من اتصالك وحاول مرة أخرى.',
			'parent.children.errorGeneric' => 'حدث خطأ ما. حاول مرة أخرى.',
			'parent.children.lookupEmpty' => 'اكتب رقم القيد أو رقم الهاتف أولًا.',
			'parent.courseDetail.pageTitle' => 'تفاصيل الكورس',
			'parent.courseDetail.courseBreakdown' => 'تفاصيل المادة',
			'parent.courseDetail.courseId' => 'رقم الكورس',
			'parent.courseDetail.fullTitle' => 'العنوان الكامل',
			'parent.courseDetail.status' => 'الحالة',
			'parent.courseDetail.statusActive' => 'نشط',
			'parent.courseDetail.sessions' => 'الحصص',
			'parent.courseDetail.progress' => 'التقدم',
			'parent.courseDetail.id' => 'المعرّف',
			'parent.gradeDetail.pageTitle' => 'تفاصيل الدرجة',
			'parent.gradeDetail.quizDetail' => 'تفاصيل الاختبار',
			'parent.gradeDetail.quizScore' => 'نتيجة الاختبار',
			'parent.gradeDetail.assessmentInfo' => 'معلومات التقييم',
			'parent.gradeDetail.score' => 'الدرجة',
			'parent.gradeDetail.percentage' => 'النسبة',
			'parent.gradeDetail.result' => 'النتيجة',
			'parent.gradeDetail.pass' => 'ناجح',
			'parent.gradeDetail.fail' => 'راسب',
			'parent.gradeDetail.questionBreakdown' => 'تفصيل الأسئلة',
			'parent.gradeDetail.questionLabel' => ({required Object number}) => 'السؤال ${number}',
			'parent.gradeDetail.correctAnswer' => 'إجابة صحيحة',
			'parent.gradeDetail.incorrectAnswer' => 'إجابة خاطئة',
			'parent.gradeDetail.additionalDetails' => 'تفاصيل إضافية',
			'parent.gradeDetail.quizId' => 'رقم الاختبار',
			'parent.gradeDetail.submittedAt' => 'تاريخ التسليم',
			'parent.gradeDetail.passCriteria' => 'حد النجاح',
			'parent.gradeDetail.notFound' => 'لم يتم العثور على محاولة الاختبار.',
			'parent.splash.appName' => 'MENTORX',
			'parent.splash.tagline' => 'بوابة ولي الأمر',
			'parent.app.title' => 'MentorX لولي الأمر',
			'assignments.listTitle' => 'الواجبات',
			'assignments.dueAt' => ({required Object date}) => 'تاريخ التسليم: ${date}',
			'assignments.noDeadline' => 'لا يوجد موعد تسليم',
			'assignments.submitAssignment' => 'تسليم الواجب',
			'assignments.viewFeedback' => 'عرض الملاحظات',
			'assignments.submitted' => 'تم التسليم',
			'assignments.notSubmitted' => 'لم يتم التسليم',
			'assignments.grading' => 'جاري التصحيح',
			'assignments.graded' => 'تم التصحيح',
			_ => null,
		};
	}
}
