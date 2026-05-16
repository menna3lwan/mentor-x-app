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
class TranslationsAr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAccountstatusAr accountstatus = _TranslationsAccountstatusAr._(_root);
	@override late final _TranslationsAichatAr aichat = _TranslationsAichatAr._(_root);
	@override late final _TranslationsAnalyticsAr analytics = _TranslationsAnalyticsAr._(_root);
	@override late final _TranslationsAssignmentsAr assignments = _TranslationsAssignmentsAr._(_root);
	@override late final _TranslationsAttendanceAr attendance = _TranslationsAttendanceAr._(_root);
	@override late final _TranslationsAuthAr auth = _TranslationsAuthAr._(_root);
	@override late final _TranslationsCoreAr core = _TranslationsCoreAr._(_root);
	@override late final _TranslationsCourseAr course = _TranslationsCourseAr._(_root);
	@override late final _TranslationsHomeAr home = _TranslationsHomeAr._(_root);
	@override late final _TranslationsMarketplaceAr marketplace = _TranslationsMarketplaceAr._(_root);
	@override late final _TranslationsNotificationsAr notifications = _TranslationsNotificationsAr._(_root);
	@override late final _TranslationsOnboardingAr onboarding = _TranslationsOnboardingAr._(_root);
	@override late final _TranslationsProfileAr profile = _TranslationsProfileAr._(_root);
	@override late final _TranslationsQuizzesAr quizzes = _TranslationsQuizzesAr._(_root);
	@override late final _TranslationsRewardsAr rewards = _TranslationsRewardsAr._(_root);
	@override late final _TranslationsSettingsAr settings = _TranslationsSettingsAr._(_root);
	@override late final _TranslationsShellAr shell = _TranslationsShellAr._(_root);
	@override late final _TranslationsStudentcardAr studentcard = _TranslationsStudentcardAr._(_root);
	@override late final _TranslationsWalletAr wallet = _TranslationsWalletAr._(_root);
}

// Path: accountstatus
class _TranslationsAccountstatusAr extends TranslationsAccountstatusEn {
	_TranslationsAccountstatusAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get blockedTitle => 'الحساب محظور';
	@override String get blockedDescription => 'تم حظر حسابك بسبب انتهاك شروط الخدمة الخاصة بنا.';
	@override String get blockedSupportInfo => 'إذا كنت تعتقد أن هذا خطأ، يرجى الاتصال بالدعم.';
	@override String get pendingTitle => 'الحساب قيد المراجعة';
	@override String get pendingDescription => 'حسابك قيد المراجعة حاليًا.';
	@override String get pendingSupportInfo => 'سنقوم بإخطارك بمجرد الموافقة على حسابك.';
	@override String get refreshStatus => 'تحديث الحالة';
	@override String get rejectedTitle => 'تم رفض الحساب';
	@override String get rejectedDescription => 'تم رفض حسابك.';
	@override String get rejectedReason => 'يرجى التحقق من معلوماتك والمحاولة مرة أخرى.';
	@override String get studentCodeLabel => 'كود الطالب';
}

// Path: aichat
class _TranslationsAichatAr extends TranslationsAichatEn {
	_TranslationsAichatAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get aiTutorHistory => 'سجل المعلم الذكي';
	@override String get newChat => 'دردشة جديدة';
	@override String get unableToLoadConversations => 'غير قادر على تحميل المحادثات.';
	@override String get noConversationsYet => 'لا توجد محادثات بعد';
	@override String get noConversationsDesc => 'ابدأ محادثة مع معلمك الذكي للحصول على مساعدة في دراستك.';
	@override String messagesCount({required Object count}) => '${count} رسائل';
	@override String get rename => 'إعادة تسمية';
	@override String get delete => 'حذف';
	@override String get studySession => 'جلسة دراسية';
	@override String get renameChat => 'إعادة تسمية الدردشة';
	@override String get enterNewTitle => 'أدخل العنوان الجديد';
	@override String get cancel => 'إلغاء';
	@override String get save => 'حفظ';
	@override String get aiAssistant => 'المساعد الذكي';
	@override String get commonLoading => 'جاري المعالجة...';
	@override String get aiSubtitle => 'هنا دائمًا للمساعدة';
	@override String get typeQuestion => 'اسألني أي شيء...';
}

// Path: analytics
class _TranslationsAnalyticsAr extends TranslationsAnalyticsEn {
	_TranslationsAnalyticsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تحليلات الأداء';
	@override String get performanceDashboard => 'لوحة الأداء';
	@override String get academicJourney => 'رحلتك الأكاديمية';
	@override String get gradeVsPeers => 'درجتك مقارنة بزملائك';
	@override String rank({required Object rank}) => 'الترتيب #${rank}';
	@override String get yourScore => 'درجتك';
	@override String get classAverage => 'متوسط الفصل';
	@override String studentsCount({required Object count}) => '${count} طالب';
	@override String get aboveAverage => 'أعلى من المتوسط';
	@override String get belowAverage => 'أقل من المتوسط';
	@override String get performanceTrend => 'اتجاه الأداء';
	@override String get studyConsistency => 'اتساق الدراسة';
	@override String daysStreak({required Object days}) => '${days} أيام متتالية';
	@override String personalBestLabel({required Object count}) => 'أفضل نتيجة شخصية: ${count}';
	@override String get newRecord => 'رقم قياسي جديد!';
	@override String get leaderboardError => 'تعذر تحميل لوحة المتصدرين';
	@override String get studyPeakHours => 'ساعات الدراسة الذروة';
	@override String get badgesAndAchievements => 'الشارات والإنجازات';
	@override String get streakTitle => 'سلسلة التفاعل';
	@override String get streakEncouragement => 'استمر! أنت تحرز تقدماً ثابتاً';
	@override String get bestStreak => 'أفضل سلسلة';
	@override String get quizSpeedMetrics => 'مقاييس سرعة الاختبار';
	@override String get secondsPerQuestion => 'ثانية/سؤال';
	@override String get yourAverage => 'متوسطك';
	@override String get peerAverage => 'متوسط الزملاء';
	@override String get speedEncouragement => 'أنت أسرع بنسبة 15% من متوسط زملائك! حافظ على هذا المستوى.';
	@override String get allCourses => 'كل الدورات';
	@override String get noRankingsTitle => 'لا توجد ترتيبات متاحة';
	@override String get noRankingsDesc => 'كن أول من ينضم إلى لوحة المتصدرين بإكمال دوراتك.';
	@override String get yourStanding => 'مركزك الحالي';
	@override String get you => 'أنت';
}

// Path: assignments
class _TranslationsAssignmentsAr extends TranslationsAssignmentsEn {
	_TranslationsAssignmentsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get detail => 'تفاصيل الواجب';
	@override String get title => 'واجب الموجات';
	@override String get featureTitle => 'الواجبات';
	@override String get unit => 'الوحدة 3 - الحصة 2';
	@override String get deadline => 'الموعد النهائي';
	@override String get maxScore => 'الدرجة';
	@override String get points => 'نقاط';
	@override String get instructionsLabel => 'التعليمات:';
	@override String get instructions => 'حل المسائل التالية عن الموجات الميكانيكية. يجب حل جميع المسائل وتوضيح خطوات الحل كاملة.';
	@override String get file => 'ملف الواجب';
	@override String get submit => 'إرسال الواجب';
	@override String get uploadFile => 'اضغط لرفع الملف';
	@override String get uploadHint => 'PDF، صور (بحد أقصى 10 ميجابايت)';
	@override String get notesOptional => 'ملاحظات (اختياري):';
	@override String get notesHint => 'أضف ملاحظة للمعلم...';
	@override String get feedbackTitle => 'التعليقات';
	@override String get instructorFeedback => 'تعليق المعلم:';
	@override String get registerAttendance => 'تسجيل الحضور';
	@override String get attendanceHistory => 'سجل الحضور';
	@override String get yourAttendanceCode => 'كود الحضور الخاص بك';
	@override String get exitTitle => 'خروج من الواجب؟';
	@override String get exitDesc => 'لن يتم حفظ تقدمك. هل أنت متأكد من الخروج؟';
	@override String get yourResponse => 'إجابتك';
	@override String get writeResponse => 'اكتب إجابتك هنا...';
	@override String get responseHint => 'ابدأ الكتابة...';
	@override String get attachments => 'المرفقات';
	@override String get noFiles => 'لا توجد ملفات مرفقة بعد';
	@override String get chooseCorrect => 'اختر الإجابة الصحيحة:';
	@override String get questionLabel => 'سؤال';
	@override String get submitted => 'تم إرسال الواجب بنجاح';
	@override String get alreadySubmitted => 'لقد قمت بإرسال هذا الواجب بالفعل';
	@override String get notFound => 'الواجب غير موجود';
	@override String get noAssignments => 'لا توجد واجبات متاحة';
	@override String get noAssignmentsDesc => 'تحقق لاحقاً من وجود واجبات جديدة.';
	@override String dueAt({required Object date}) => 'تاريخ التسليم: ${date}';
	@override String get noDeadline => 'بدون موعد تسليم';
	@override String get cancel => 'إلغاء';
	@override String get exit => 'خروج';
	@override String get previous => 'السابق';
	@override String get next => 'التالي';
	@override String get result => 'نتيجة الواجب';
	@override String get veryGood => 'جيد جداً';
	@override String get commonBack => 'رجوع';
	@override String get viewResult => 'عرض النتائج';
	@override String get graded => 'تم التقييم';
	@override String get excellent => 'ممتاز';
	@override String get good => 'جيد';
	@override String get passed => 'ناجح';
	@override String get failed => 'راسب';
}

// Path: attendance
class _TranslationsAttendanceAr extends TranslationsAttendanceEn {
	_TranslationsAttendanceAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noAttendance => 'لا توجد سجلات حضور بعد';
	@override String get attendanceHistory => 'سجل الحضور';
	@override String get attendanceRate => 'نسبة الحضور';
	@override String get present => 'حاضر';
	@override String get absent => 'غائب';
	@override String get session => 'الحصة';
	@override String get attendanceHistoryDesc => 'سيظهر سجل الحضور الخاص بك هنا';
	@override String get registerAttendance => 'تسجيل الحضور';
	@override String get yourAttendanceCode => 'رمز الحضور الخاص بك';
	@override String get showCodeInstruction => 'اعرض هذا الرمز للمعلم لتسجيل حضورك.';
}

// Path: auth
class _TranslationsAuthAr extends TranslationsAuthEn {
	_TranslationsAuthAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get welcomeBack => 'مرحباً بك مجدداً';
	@override String get signInToContinue => 'قم بتسجيل الدخول للمتابعة';
	@override String get forgotPassword => 'نسيت كلمة المرور؟';
	@override String get signIn => 'تسجيل الدخول';
	@override String get loginWithBiometrics => 'الدخول بالبصمة';
	@override String get dontHaveAccount => 'ليس لديك حساب؟';
	@override String get registerNow => 'سجل الآن';
	@override String get welcome => 'مرحباً';
	@override String get letsGetStarted => 'لنبدأ الآن';
	@override String get basicDetailsDesc => 'من فضلك أدخل بيانات الاتصال الأساسية';
	@override String get firstNameLabel => 'الاسم الأول';
	@override String get phoneLabel => 'رقم الهاتف';
	@override String get parentPhoneLabel => 'رقم هاتف ولي الأمر';
	@override String get phoneAlreadyRegistered => 'رقم الهاتف مسجل بالفعل';
	@override String get otpVerifyTitle => 'تأكيد رقم الهاتف';
	@override String get otpSentWhatsapp => 'لقد أرسلنا كود التأكيد إلى واتساب الخاص بك';
	@override String get resetTitle => 'إعادة تعيين كلمة المرور';
	@override String get forgotPasswordTitle => 'نسيت كلمة المرور؟';
	@override String get forgotPasswordDesc => 'لا تقلق! أدخل رقم هاتفك أدناه وسنرسل لك كوداً لإعادة تعيين كلمة المرور الخاصة بك.';
	@override String get sendResetCode => 'إرسال كود إعادة التعيين';
	@override String get resetOtpSentPrefix => 'لقد أرسلنا كود التأكيد إلى ';
	@override String get resetOtpSentSuffix => '. أدخله أدناه لإعادة تعيين كلمة المرور.';
	@override String get resetOtpLabel => 'كود التأكيد';
	@override String get resetOtpHint => '000000';
	@override String get resetOtpError => 'من فضلك أدخل كود صحيح مكون من 6 أرقام';
	@override String get newPasswordLabel => 'كلمة المرور الجديدة';
	@override String get newPasswordHint => 'أدخل كلمة المرور الجديدة';
	@override String get passwordRules => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
	@override String get confirmPasswordHint => 'أعد إدخال كلمة المرور';
	@override String get otpSentGeneric => 'تم إرسال كود التأكيد إلى هاتفك';
	@override String get otpSentPrefix => 'لقد أرسلنا كوداً إلى ';
	@override String get didNotReceiveCode => 'لم تصلك الرسالة؟';
	@override String get resendCode => 'إعادة إرسال الكود';
	@override String get resendWhatsapp => 'إعادة الإرسال عبر واتساب';
	@override String get resendIn => 'إعادة الإرسال خلال';
	@override String get verifyOtp => 'تأكيد الكود';
	@override String get editNumber => 'تعديل الرقم';
	@override String get gradeLabel => 'الصف الدراسي';
	@override String get governorateLabel => 'المحافظة';
	@override String get passwordAndPhotosLabel => 'كلمة المرور والصورة';
	@override String get passwordHint => 'أدخل كلمة المرور';
	@override String get submitRegistration => 'إتمام التسجيل';
	@override String get commonNext => 'التالي';
	@override String get alreadyHaveAccount => 'لديك حساب بالفعل؟';
	@override String get loginButton => 'تسجيل الدخول';
	@override String get submissionTitle => 'تم إرسال طلب التسجيل';
	@override String get submissionDescription => 'حسابك الآن تحت المراجعة. ستتلقى رسالة عبر واتساب ببيانات الدخول بعد الموافقة.';
	@override String get passwordResetSuccess => 'تم إعادة تعيين كلمة المرور بنجاح!';
	@override String get backToLogin => 'العودة لتسجيل الدخول';
	@override String get codeLabel => 'كود الطالب';
	@override String get registerTitle => 'إنشاء حساب';
	@override String get secondNameLabel => 'الاسم الثاني';
	@override String get thirdNameLabel => 'الاسم الثالث';
	@override String get fourthNameLabel => 'الاسم الرابع';
	@override String get personalPhotoLabel => 'الصورة الشخصية';
	@override String get personalInfoDesc => 'من فضلك أدخل اسمك بالكامل كما هو موجود في الأوراق الرسمية.';
	@override String get academicInfoTitle => 'المعلومات الأكاديمية';
	@override String get academicInfoDesc => 'أخبرنا عن مستواك الدراسي';
	@override String get schoolNameLabel => 'اسم المدرسة';
	@override String get educationAdminLabel => 'الإدارة التعليمية';
	@override String get gradeHint => 'اختر الصف الدراسي';
	@override String get studyTypeLabel => 'نوع الدراسة';
	@override String get studyTypeOnline => 'أونلاين';
	@override String get studyTypeCenter => 'سنتر';
	@override String get centerNameLabel => 'اسم السنتر';
	@override String get locationDetailsTitle => 'تفاصيل العنوان';
	@override String get locationDetailsDesc => 'أخبرنا بمكان سكنك';
	@override String get governorateHint => 'اختر المحافظة';
	@override String get regionLabel => 'المنطقة';
	@override String get regionHint => 'اختر المنطقة';
	@override String get confirmPasswordLabel => 'تأكيد كلمة المرور';
	@override String get passwordMismatch => 'كلمات المرور غير متطابقة';
	@override String get securityIdentityTitle => 'الأمان والهوية';
	@override String get securityIdentityDesc => 'احمِ حسابك وأكد هويتك';
	@override String get passwordWeak => 'ضعيفة';
	@override String get passwordFair => 'متوسطة';
	@override String get passwordGood => 'جيدة';
	@override String get passwordStrong => 'قوية';
	@override String get nationalIdPhotoLabel => 'صورة البطاقة الشخصية';
	@override String get uploadIdFront => 'رفع وجه البطاقة';
	@override String get biometricHint => 'تسجيل الدخول بالبصمة سيكون متاحاً بعد أول عملية دخول ناجحة على هذا الجهاز.';
	@override String get registrationLabel => 'تسجيل حساب';
	@override String get gallery => 'المعرض';
	@override String get camera => 'الكاميرا';
	@override late final _TranslationsAuthLoginAr login = _TranslationsAuthLoginAr._(_root);
	@override late final _TranslationsAuthFormsAr forms = _TranslationsAuthFormsAr._(_root);
}

// Path: core
class _TranslationsCoreAr extends TranslationsCoreEn {
	_TranslationsCoreAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'MentorX Student';
	@override String get currency => 'ج.م';
	@override String price({required num amount}) => '${amount} ${_root.core.currency}';
	@override Map<String, String> get languages => {
		'en': 'English',
		'ar': 'العربية',
	};
	@override late final _TranslationsCoreInitialLanguageAr initialLanguage = _TranslationsCoreInitialLanguageAr._(_root);
	@override String get logoutSetting => 'تسجيل الخروج';
	@override String get logoutConfirmTitle => 'تسجيل الخروج';
	@override String get logoutConfirmDesc => 'هل أنت متأكد من تسجيل الخروج؟';
	@override String get preview => 'معاينة';
	@override String get comingSoon => 'قريباً';
	@override String opening({required Object url}) => 'جاري فتح ${url}...';
	@override String get search => 'بحث';
	@override String get viewAll => 'عرض الكل';
	@override String get skip => 'تخطي';
	@override String get next => 'التالي';
	@override String get getStarted => 'ابدأ الآن';
	@override String get retry => 'إعادة المحاولة';
	@override String get cancel => 'إلغاء';
	@override String get settingsTitle => 'الإعدادات';
	@override String get editProfile => 'تعديل الملف الشخصي';
	@override String get studentCard => 'بطاقة الطالب';
	@override String get digitalId => 'الهوية الرقمية';
	@override String get personalData => 'البيانات الشخصية';
	@override String get name => 'الاسم';
	@override String get phone => 'الهاتف';
	@override String get grade => 'الصف';
	@override String get center => 'السنتر';
	@override String get school => 'المدرسة';
	@override String get attendance => 'الحضور';
	@override String get wallet => 'المحفظة';
	@override String get sendRequest => 'إرسال الطلب';
	@override String get tEditionPro => 'نسخة MentorX برو';
	@override String get aboutDesc => 'منصة MentorX هي منصة تعليمية شاملة تهدف لتمكين الطلاب وأولياء الأمور.';
	@override String version({required Object v}) => 'الإصدار ${v}';
	@override String lastUpdate({required Object date}) => 'آخر تحديث: ${date}';
	@override String buildLabel({required Object b}) => 'بناء: ${b}';
	@override String get allRightsReserved => 'جميع الحقوق محفوظة © 2026 MentorX';
	@override String get unableToLoadDevices => 'تعذر تحميل الأجهزة';
	@override String get noRegisteredDevices => 'لا يوجد أجهزة مسجلة';
	@override String get activeSessionsDesc => 'إدارة جلساتك النشطة وأجهزتك.';
	@override String get deactivateDevice => 'إلغاء تنشيط الجهاز';
	@override String get deactivatedLabel => 'تم إلغاء التنشيط';
	@override String get activeLabel => 'نشط';
	@override String get inactiveLabel => 'غير نشط';
	@override String get language => 'اللغة';
	@override String get account => 'الحساب';
	@override String get changePasswordSetting => 'تغيير كلمة المرور';
	@override String get deviceManagement => 'إدارة الأجهزة';
	@override String get communication => 'التواصل';
	@override String get notificationsSetting => 'التنبيهات';
	@override String get whatsappGroups => 'مجموعات واتساب';
	@override String get helpAndInfo => 'المساعدة والمعلومات';
	@override String get aboutSetting => 'عن التطبيق';
	@override String lastUsedAt({required Object date}) => 'آخر استخدام في ${date}';
	@override String get excellent => 'ممتاز';
	@override String get veryGood => 'جيد جداً';
	@override String get fail => 'تحتاج لمزيد من الجهد';
	@override String of({required Object count}) => 'من ${count}';
}

// Path: course
class _TranslationsCourseAr extends TranslationsCourseEn {
	_TranslationsCourseAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String lessonProgress({required Object completed, required Object total}) => '${completed}/${total} درساً';
	@override String get myAcademy => 'أكاديميتي';
	@override String get courseDetail => 'تفاصيل الدورة';
	@override String get myCourses => 'دوراتي';
	@override late final _TranslationsCourseTabsAr tabs = _TranslationsCourseTabsAr._(_root);
	@override late final _TranslationsCourseEmptyAr empty = _TranslationsCourseEmptyAr._(_root);
	@override late final _TranslationsCourseDetailAr detail = _TranslationsCourseDetailAr._(_root);
	@override late final _TranslationsCourseErrorsAr errors = _TranslationsCourseErrorsAr._(_root);
	@override late final _TranslationsCoursePlayerAr player = _TranslationsCoursePlayerAr._(_root);
	@override String get lessonsCompleted => 'الدروس المكتملة';
	@override String get timeSpent => 'الوقت المستغرق';
	@override String get quizzesTaken => 'الاختبارات المجتازة';
	@override String get avgQuizScore => 'متوسط درجة الاختبار';
	@override late final _TranslationsCourseCatalogAr catalog = _TranslationsCourseCatalogAr._(_root);
	@override late final _TranslationsCourseMyGradesAr myGrades = _TranslationsCourseMyGradesAr._(_root);
	@override String get markAsDone => 'تحديد كمكتمل';
}

// Path: home
class _TranslationsHomeAr extends TranslationsHomeEn {
	_TranslationsHomeAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeDashboardAr dashboard = _TranslationsHomeDashboardAr._(_root);
}

// Path: marketplace
class _TranslationsMarketplaceAr extends TranslationsMarketplaceEn {
	_TranslationsMarketplaceAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get orderPlaced => 'تم تقديم الطلب بنجاح!';
	@override String get orderFailed => 'فشل في تقديم الطلب';
	@override String get apply => 'تطبيق';
	@override String get deliveryAddress => 'عنوان التوصيل';
	@override String get phoneNumber => 'رقم الهاتف';
	@override String get deliveryNotes => 'ملاحظات التوصيل';
	@override String get walletBalance => 'رصيد المحفظة';
	@override String get subtotal => 'المجموع الفرعي';
	@override String get discount => 'الخصم';
	@override String get delivery => 'التوصيل';
	@override String get search => 'بحث';
	@override String get searchProducts => 'البحث عن المنتجات...';
	@override String get all => 'الكل';
	@override String get errorLoadingProducts => 'خطأ في تحميل المنتجات';
	@override String get noProductsFound => 'لم يتم العثور على منتجات';
	@override String get store => 'المتجر';
	@override String get egp => 'ج.م';
	@override String get addedToCart => 'تمت الإضافة إلى السلة';
	@override String get explore => 'استكشف';
	@override String get hot => 'شائع';
	@override String get tryAgainLater => 'حاول مرة أخرى لاحقاً';
	@override String get errorLoadingProduct => 'خطأ في تحميل المنتج';
	@override String get addToCart => 'إضافة إلى السلة';
	@override String get description => 'الوصف';
	@override String get stockStatus => 'حالة المخزون';
	@override String get inStock => 'في المخزن';
	@override String get outOfStock => 'غير متوفر';
	@override String get onlyLeft => 'متبقي فقط';
	@override String get items => 'قطع';
	@override late final _TranslationsMarketplaceCartAr cart = _TranslationsMarketplaceCartAr._(_root);
	@override late final _TranslationsMarketplaceOrdersAr orders = _TranslationsMarketplaceOrdersAr._(_root);
}

// Path: notifications
class _TranslationsNotificationsAr extends TranslationsNotificationsEn {
	_TranslationsNotificationsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noNotifications => 'لا توجد إشعارات بعد';
	@override String get noNotificationsDesc => 'سنقوم بإخطارك عندما يحدث شيء مهم.';
	@override String get notificationsTitle => 'الإشعارات';
}

// Path: onboarding
class _TranslationsOnboardingAr extends TranslationsOnboardingEn {
	_TranslationsOnboardingAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get somethingWentWrong => 'حدث خطأ ما.';
	@override String get retry => 'إعادة المحاولة';
	@override late final _TranslationsOnboardingStepsAr steps = _TranslationsOnboardingStepsAr._(_root);
}

// Path: profile
class _TranslationsProfileAr extends TranslationsProfileEn {
	_TranslationsProfileAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الملف الشخصي';
	@override String get wallet => 'المحفظة';
	@override String get attendance => 'الحضور';
	@override String get personalData => 'البيانات الشخصية';
	@override String get name => 'الاسم';
	@override String get phone => 'رقم الهاتف';
	@override String get grade => 'السنة الدراسية';
	@override String get center => 'المركز';
	@override String get school => 'المدرسة';
	@override String get firstName => 'الاسم الأول';
	@override String get secondName => 'الاسم الثاني';
	@override String get thirdName => 'الاسم الثالث';
	@override String get fourthName => 'الاسم الرابع';
	@override String get governorate => 'المحافظة';
	@override String get area => 'المنطقة';
	@override String get educationDepartment => 'الإدارة التعليمية';
	@override String get digitalId => 'الهوية الرقمية';
	@override String get editProfile => 'تعديل الملف الشخصي';
	@override String get settingsTitle => 'الإعدادات';
	@override String get logoutSetting => 'تسجيل الخروج';
	@override String get logoutConfirmTitle => 'تأكيد تسجيل الخروج';
	@override String get logoutConfirmDesc => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';
	@override String get cancel => 'إلغاء';
	@override String get editsNeedApproval => 'التعديلات تحتاج إلى موافقة المعلم';
	@override String get personalInfo => 'البيانات الشخصية';
	@override String get requiredField => 'هذا الحقل مطلوب';
	@override String get academicInfo => 'البيانات الأكاديمية';
	@override String get reasonForEdit => 'سبب التعديل';
	@override String get provideReason => 'يرجى ذكر السبب';
	@override String get reasonHint => 'اكتب سبب تعديل ملفك الشخصي...';
	@override String get sendRequest => 'إرسال الطلب';
	@override String get changePasswordDesc => 'تحديث كلمة مرور حسابك';
	@override String get currentPassword => 'كلمة المرور الحالية';
	@override String get newPassword => 'كلمة المرور الجديدة';
	@override String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';
	@override String get passwordTooShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
	@override String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';
	@override String get saveChanges => 'حفظ التغييرات';
	@override String get changePassword => 'تغيير كلمة المرور';
	@override String get noChangesDetected => 'لم يتم اكتشاف أي تغييرات';
	@override String get requestSentSuccess => 'تم إرسال الطلب بنجاح';
}

// Path: quizzes
class _TranslationsQuizzesAr extends TranslationsQuizzesEn {
	_TranslationsQuizzesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الاختبارات';
	@override String get noQuizzes => 'لا توجد اختبارات متاحة';
	@override String get noQuizzesDesc => 'تحقق لاحقاً من وجود اختبارات جديدة.';
	@override String get quizResult => 'نتيجة الاختبار';
	@override String get score => 'النتيجة';
	@override String get timeTaken => 'الوقت المستغرق';
	@override String get correctAnswers => 'صحيحة';
	@override String get wrongAnswers => 'خاطئة';
	@override String get reviewAnswers => 'مراجعة الإجابات';
	@override String get yourAnswer => 'إجابتك';
	@override String get correctAnswer => 'الإجابة الصحيحة';
	@override String get leaderboard => 'لوحة الصدارة';
	@override String get claimReward => 'المطالبة بالمكافأة';
	@override String get assessments => 'التقييمات';
	@override String get navQuizzes => 'الاختبارات';
	@override String get questions => 'أسئلة';
	@override String get minutesShort => 'دقيقة';
	@override String get quizNotFound => 'الاختبار غير موجود';
	@override String get resumeQuiz => 'استئناف الاختبار';
	@override String get startQuiz => 'بدء الاختبار';
	@override String get commonBack => 'رجوع';
	@override String get quizUnitTitle => 'اختبار الوحدة';
	@override String get quizSubtitle => 'اختبر معلوماتك في هذه الوحدة';
	@override String get questionCount => 'عدد الأسئلة';
	@override String get duration => 'المدة';
	@override String get passGrade => 'درجة النجاح';
	@override String get attempts => 'المحاولات';
	@override String get instructions => 'التعليمات';
	@override String get instructionRead => 'اقرأ الأسئلة بعناية قبل الإجابة.';
	@override String get instructionReview => 'يمكنك مراجعة إجاباتك في النهاية.';
	@override String get instructionNoReturn => 'بمجرد الإرسال، لا يمكنك تغيير إجاباتك.';
	@override String get resultNotFound => 'لم يتم العثور على نتيجة الاختبار';
	@override String get excellent => 'ممتاز';
	@override String get veryGood => 'جيد جداً';
	@override String get fail => 'راسب';
	@override String get greatResult => 'نتيجة رائعة!';
	@override String get noQuestions => 'لا توجد أسئلة متاحة';
	@override String get exitQuizTitle => 'الخروج من الاختبار؟';
	@override String get exitQuizDesc => 'يتم حفظ تقدمك تلقائياً. يمكنك استئناف هذا الاختبار لاحقاً من صفحة المقدمة.';
	@override String get cancel => 'إلغاء';
	@override String get exit => 'خروج';
	@override String get questionLabel => 'سؤال';
	@override String get chooseCorrect => 'اختر الإجابة الصحيحة:';
	@override String get typeAnswerHere => 'اكتب إجابتك هنا...';
	@override String get commonPrevious => 'السابق';
	@override String get commonSubmit => 'إرسال';
	@override String get commonNext => 'التالي';
	@override late final _TranslationsQuizzesRewardsAr rewards = _TranslationsQuizzesRewardsAr._(_root);
	@override late final _TranslationsQuizzesReviewAr review = _TranslationsQuizzesReviewAr._(_root);
}

// Path: rewards
class _TranslationsRewardsAr extends TranslationsRewardsEn {
	_TranslationsRewardsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noRewards => 'لا توجد مكافآت متاحة';
	@override String get noRewardsDesc => 'تحقق مرة أخرى لاحقًا لرؤية العناصر الجديدة.';
	@override String get rewardsTitle => 'كتالوج المكافآت';
	@override String get pointsBalance => 'رصيد النقاط';
	@override String get points => 'نقاط';
	@override String get redeemPointsDesc => 'استبدل نقاطك بمكافآت حصرية.';
	@override String get redeem => 'استبدال';
	@override String get noHistory => 'لا توجد سجلات نقاط بعد';
	@override String get noHistoryDesc => 'اكسب النقاط عن طريق إكمال المهام والمشاركة في الأنشطة.';
	@override String get rewardsHistoryTitle => 'سجل النقاط';
	@override String balance({required Object balance}) => 'الرصيد: ${balance}';
}

// Path: settings
class _TranslationsSettingsAr extends TranslationsSettingsEn {
	_TranslationsSettingsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإعدادات';
	@override String get language => 'اللغة';
	@override String get account => 'الحساب';
	@override String get changePasswordSetting => 'تغيير كلمة المرور';
	@override String get studentCard => 'بطاقة الطالب';
	@override String get deviceManagement => 'إدارة الأجهزة';
	@override String get communication => 'الاتصالات';
	@override String get notificationsSetting => 'الإشعارات';
	@override String get whatsappGroups => 'مجموعات الواتساب';
	@override String get whatsappGroupsDesc => 'انضم إلى مجموعات الواتساب الرسمية لدينا للبقاء على اطلاع بآخر الأخبار والإعلانات.';
	@override String get helpAndInfo => 'المساعدة والمعلومات';
	@override String get aboutSetting => 'عن التطبيق';
	@override String get logoutSetting => 'تسجيل الخروج';
	@override String membersActive({required Object count}) => '${count} عضو نشط';
	@override String get linkCopied => 'تم نسخ الرابط إلى الحافظة';
	@override String get copyInviteLink => 'نسخ رابط الدعوة';
	@override String get preferencesLabel => 'التفضيلات';
	@override String get logoutConfirmTitle => 'تسجيل الخروج';
	@override String get logoutConfirmDesc => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';
	@override String get communityLabel => 'المجتمع';
	@override String get tEditionPro => 'مينتور إكس برو';
	@override String get aboutDesc => 'مينتور إكس هي منصة شاملة مصممة لتبسيط إدارة الطلاب وتتبع الأداء وتعزيز التواصل.';
	@override String get version => 'الإصدار';
	@override String get lastUpdate => 'آخر تحديث';
	@override String get buildLabel => 'البناء';
	@override String get allRightsReserved => '© 2026 مينتور إكس. جميع الحقوق محفوظة.';
	@override String get appInfoLabel => 'معلومات التطبيق';
	@override String get unableToLoadDevices => 'تعذر تحميل الأجهزة';
	@override String get settingsLabel => 'الإعدادات';
	@override String get noRegisteredDevices => 'لا توجد أجهزة مسجلة';
	@override String get activeSessionsDesc => 'يمكنك إدارة جلساتك النشطة هنا.';
	@override String lastUsedAt({required Object date}) => 'آخر استخدام: ${date}';
	@override String get deactivateDevice => 'إلغاء التنشيط';
	@override String get deactivatedLabel => 'تم إلغاء التنشيط';
	@override String get activeLabel => 'نشط';
	@override String get inactiveLabel => 'غير نشط';
}

// Path: shell
class _TranslationsShellAr extends TranslationsShellEn {
	_TranslationsShellAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get navHome => 'الرئيسية';
	@override String get navCourses => 'الدورات';
	@override String get navQuizzes => 'الاختبارات';
	@override String get navWallet => 'المحفظة';
	@override String get navAccount => 'الحساب';
}

// Path: studentcard
class _TranslationsStudentcardAr extends TranslationsStudentcardEn {
	_TranslationsStudentcardAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بطاقة الطالب';
	@override String get platformName => 'منصة MentorX';
	@override String get codeLabel => 'كود الطالب';
	@override String get scanForAttendance => 'امسح الكود لتسجيل الحضور';
	@override String get secureDigitalId => 'هوية رقمية آمنة';
	@override String get gradeLabel => 'الصف الدراسي';
	@override String get digitalId => 'الهوية الرقمية';
	@override String get errorLoading => 'خطأ في تحميل البطاقة';
	@override String get refreshStatus => 'تحديث الحالة';
	@override String get errorLoadingMessage => 'لم نتمكن من تحميل بطاقة الطالب الخاصة بك. يرجى المحاولة مرة أخرى.';
}

// Path: wallet
class _TranslationsWalletAr extends TranslationsWalletEn {
	_TranslationsWalletAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get addBalance => 'إضافة رصيد';
	@override String get redeemCode => 'شحن كود';
	@override String get myOrders => 'طلباتي';
	@override String get recentTransactions => 'المعاملات الأخيرة';
	@override String get seeAll => 'عرض الكل';
	@override String get noTransactions => 'لا توجد معاملات بعد';
	@override String get walletTitle => 'محفظتك';
	@override String get walletBalance => 'رصيد المحفظة';
	@override String get egp => 'ج.م';
	@override String get points => 'نقاط';
	@override String get transactionsTitle => 'المعاملات';
	@override String get vodafoneCash => 'فودافون كاش';
	@override String get vodafoneDesc => 'الدفع باستخدام محفظة فودافون كاش';
	@override String get instaPay => 'إنستا باي';
	@override String get instaPayDesc => 'الدفع باستخدام تطبيق إنستا باي';
	@override String get fawry => 'فوري';
	@override String get fawryDesc => 'الدفع في أي نقطة بيع فوري';
	@override String get amount => 'المبلغ';
	@override String get choosePaymentMethod => 'اختر طريقة الدفع';
	@override String get continueBtn => 'استمرار';
	@override String get redeemCodeTitle => 'شحن الكود الخاص بك';
	@override String get enterCodeDesc => 'أدخل الكود الذي استلمته لإضافة رصيد إلى محفظتك.';
	@override String get activateCode => 'تفعيل الكود';
	@override String get redeemPolicy => 'بتفعيل هذا الكود، فإنك توافق على الشروط والأحكام الخاصة بنا.';
	@override String get purchaseConfirm => 'تأكيد الشراء';
	@override String get failedToLoadPayment => 'فشل في تحميل الدفع';
	@override String get paymentMethod => 'طريقة الدفع';
	@override String get reference => 'المرجع';
	@override String get total => 'الإجمالي';
	@override String get confirmPayment => 'تأكيد الدفع';
	@override String get paymentSuccess => 'تم الدفع بنجاح';
	@override String get balanceAdded => 'تم إضافة الرصيد: %s';
	@override String get newBalance => 'الرصيد الجديد';
	@override String get backToWallet => 'العودة إلى المحفظة';
}

// Path: auth.login
class _TranslationsAuthLoginAr extends TranslationsAuthLoginEn {
	_TranslationsAuthLoginAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get phoneNumber => 'رقم الهاتف';
	@override String get password => 'كلمة المرور';
	@override String get signIn => 'تسجيل الدخول';
	@override String get phoneValidationError => 'من فضلك أدخل رقم هاتف مصري صحيح';
}

// Path: auth.forms
class _TranslationsAuthFormsAr extends TranslationsAuthFormsEn {
	_TranslationsAuthFormsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get required => 'هذا الحقل مطلوب';
	@override String minLength({required int length}) => 'الحد الأدنى ${length} أحرف';
}

// Path: core.initialLanguage
class _TranslationsCoreInitialLanguageAr extends TranslationsCoreInitialLanguageEn {
	_TranslationsCoreInitialLanguageAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'يرجى تحديد اللغة المفضلة';
	@override String get kContinue => 'موافق';
}

// Path: course.tabs
class _TranslationsCourseTabsAr extends TranslationsCourseTabsEn {
	_TranslationsCourseTabsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get inProgress => 'قيد التنفيذ';
	@override String get completed => 'مكتملة';
	@override String get expired => 'منتهية';
	@override String get description => 'الوصف';
	@override String get sessions => 'الحصص';
}

// Path: course.empty
class _TranslationsCourseEmptyAr extends TranslationsCourseEmptyEn {
	_TranslationsCourseEmptyAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noEnrolledCourses => 'لا توجد دورات مسجلة';
	@override String get noEnrolledCoursesDescription => 'لم تقم بالتسجيل في أي دورات بعد.';
	@override String get browseCatalog => 'تصفح الكتالوج';
}

// Path: course.detail
class _TranslationsCourseDetailAr extends TranslationsCourseDetailEn {
	_TranslationsCourseDetailAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get enrollSuccess => 'تم التسجيل بنجاح!';
	@override String get enrollFailed => 'فشل التسجيل.';
	@override String get yourPerformance => 'أداؤك';
	@override String get daysLeft => 'أيام متبقية';
	@override String get items => 'عناصر';
	@override String get sessionFree => 'مجاني';
	@override String get aboutCourse => 'عن هذه الدورة';
	@override String get videos => 'فيديو';
	@override String get minutes => 'دقيقة';
	@override String get students => 'طالب';
	@override String get sessions => 'الحصص';
	@override String get free => 'مجاني';
	@override String get yourProgress => 'تقدمك';
	@override String completePercent({required Object percent}) => '${percent}% مكتمل';
	@override String get continueStudying => 'استكمل الدراسة';
	@override String get courseCompleted => 'الدورة مكتملة';
	@override String get courseExpired => 'انتهت صلاحية الدورة';
	@override String get enrollNow => 'سجل الآن';
	@override String get pointsReward => 'جائزة نقاط';
	@override String durationShort({required Object mins, required Object secs}) => '${mins}د ${secs}ث';
}

// Path: course.errors
class _TranslationsCourseErrorsAr extends TranslationsCourseErrorsEn {
	_TranslationsCourseErrorsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get failedToLoadSessions => 'فشل في تحميل حصص الدورة';
	@override String get tryRefreshing => 'حاول تحديث الصفحة';
}

// Path: course.player
class _TranslationsCoursePlayerAr extends TranslationsCoursePlayerEn {
	_TranslationsCoursePlayerAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'مكتمل';
	@override String get duration => 'المدة';
	@override String get status => 'الحالة';
	@override String get watching => 'جاري المشاهدة';
}

// Path: course.catalog
class _TranslationsCourseCatalogAr extends TranslationsCourseCatalogEn {
	_TranslationsCourseCatalogAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get allCategories => 'كل التصنيفات';
	@override String get allLevels => 'كل المستويات';
	@override String coursesFound({required Object count}) => 'تم العثور على ${count} دورة';
	@override String get noCourses => 'لم يتم العثور على دورات';
	@override String get noCoursesDescription => 'حاول تغيير الفلاتر أو كلمات البحث';
	@override String get searchHint => 'ابحث عن الدورات...';
	@override String get sortBy => 'ترتيب حسب';
	@override String get sortNewest => 'الأحدث';
	@override String get sortPriceAsc => 'السعر: من الأقل للأعلى';
	@override String get sortPriceDesc => 'السعر: من الأعلى للأقل';
	@override String get sortPopular => 'الأكثر شيوعاً';
}

// Path: course.myGrades
class _TranslationsCourseMyGradesAr extends TranslationsCourseMyGradesEn {
	_TranslationsCourseMyGradesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'درجاتي';
	@override String get noGrades => 'لا توجد درجات متاحة بعد.';
	@override String get completeAssessmentsDesc => 'أكمل الاختبارات والمهام لعرض درجاتك.';
	@override String get overallAverage => 'الأداء العام';
	@override String get allCourses => 'كل الدورات';
}

// Path: home.dashboard
class _TranslationsHomeDashboardAr extends TranslationsHomeDashboardEn {
	_TranslationsHomeDashboardAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
	@override String get myCourses => 'دوراتي';
	@override String get attendance => 'الحضور';
	@override String get grades => 'الدرجات';
	@override String get aiAssistant => 'مساعد AI';
	@override String get assignments => 'الواجبات';
	@override String get rewards => 'المكافآت';
	@override String get marketplace => 'المتجر';
	@override String get analytics => 'تحليلات الأداء';
	@override String get courseCatalog => 'كتالوج الدورات';
	@override String get leaderboard => 'لوحة المتصدرين';
}

// Path: marketplace.cart
class _TranslationsMarketplaceCartAr extends TranslationsMarketplaceCartEn {
	_TranslationsMarketplaceCartAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سلتي';
	@override String get empty => 'سلة التسوق فارغة';
	@override String get emptyDesc => 'يبدو أنك لم تضف أي شيء بعد.';
	@override String get startShopping => 'ابدأ التسوق';
	@override String get checkout => 'إتمام الشراء';
	@override String get confirmOrder => 'تأكيد الطلب';
	@override String get deliveryDetails => 'تفاصيل التوصيل';
	@override String get insufficientBalance => 'الرصيد غير كافٍ';
	@override String insufficientBalanceDesc({required Object amount}) => 'الرصيد غير كافٍ. يرجى شحن ${amount} ج.م لإتمام الطلب.';
	@override String get couponApplied => 'تم تطبيق الكوبون!';
	@override String get haveCoupon => 'هل لديك كود خصم؟';
	@override String get viewCodes => 'عرض الأكواد';
}

// Path: marketplace.orders
class _TranslationsMarketplaceOrdersAr extends TranslationsMarketplaceOrdersEn {
	_TranslationsMarketplaceOrdersAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سجل الطلبات';
	@override String get noOrders => 'لم تقم بتقديم أي طلبات بعد.';
	@override String get startShoppingDesc => 'استكشف متجرنا وقدم طلبك الأول!';
	@override String orderNumber({required Object number}) => 'طلب رقم #${number}';
	@override String itemsCount({required Object count}) => '${count} قطع';
	@override late final _TranslationsMarketplaceOrdersStatusAr status = _TranslationsMarketplaceOrdersStatusAr._(_root);
}

// Path: onboarding.steps
class _TranslationsOnboardingStepsAr extends TranslationsOnboardingStepsEn {
	_TranslationsOnboardingStepsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingStepsLearnAr learn = _TranslationsOnboardingStepsLearnAr._(_root);
	@override late final _TranslationsOnboardingStepsTrackProgressAr trackProgress = _TranslationsOnboardingStepsTrackProgressAr._(_root);
	@override late final _TranslationsOnboardingStepsQuizzesAr quizzes = _TranslationsOnboardingStepsQuizzesAr._(_root);
}

// Path: quizzes.rewards
class _TranslationsQuizzesRewardsAr extends TranslationsQuizzesRewardsEn {
	_TranslationsQuizzesRewardsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'نظام النقاط';
	@override String get goldLevel => 'ذهبي';
	@override String get toNextLevel => 'للمستوى التالي';
	@override String get xpPoints => 'نقاط الخبرة';
	@override String get quizCompleted => 'الاختبارات';
	@override String get badge => 'الأوسمة';
	@override String get dailyStreak => 'النشاط اليومي';
	@override String streakDaysMsg({required Object days}) => 'لديك سلسلة نشاط لمدة ${days} أيام!';
	@override String get earnedBadges => 'الأوسمة';
	@override String get leaderboard => 'لوحة الصدارة';
	@override late final _TranslationsQuizzesRewardsDaysAr days = _TranslationsQuizzesRewardsDaysAr._(_root);
	@override late final _TranslationsQuizzesRewardsBadgesAr badges = _TranslationsQuizzesRewardsBadgesAr._(_root);
}

// Path: quizzes.review
class _TranslationsQuizzesReviewAr extends TranslationsQuizzesReviewEn {
	_TranslationsQuizzesReviewAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مراجعة الإجابات';
	@override String get jumpToQuestion => 'الانتقال إلى سؤال';
	@override String get submitQuiz => 'إرسال الاختبار';
	@override String get backToQuestions => 'العودة للأسئلة';
	@override String get answeredCount => 'الأسئلة المجابة';
	@override String unansweredNote({required Object count}) => 'متبقي ${count} أسئلة';
}

// Path: marketplace.orders.status
class _TranslationsMarketplaceOrdersStatusAr extends TranslationsMarketplaceOrdersStatusEn {
	_TranslationsMarketplaceOrdersStatusAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pending => 'قيد الانتظار';
	@override String get confirmed => 'تم التأكيد';
	@override String get processing => 'جاري التنفيذ';
	@override String get shipped => 'تم الشحن';
	@override String get delivered => 'تم التوصيل';
	@override String get cancelled => 'ملغي';
}

// Path: onboarding.steps.learn
class _TranslationsOnboardingStepsLearnAr extends TranslationsOnboardingStepsLearnEn {
	_TranslationsOnboardingStepsLearnAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تعلم في أي وقت وفي أي مكان';
	@override String get description => 'الوصول إلى الدورات والمواد الخاصة بك أثناء التنقل. تعلم بالسرعة التي تناسبك.';
}

// Path: onboarding.steps.trackProgress
class _TranslationsOnboardingStepsTrackProgressAr extends TranslationsOnboardingStepsTrackProgressEn {
	_TranslationsOnboardingStepsTrackProgressAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تتبع تقدمك';
	@override String get description => 'تتبع درجاتك وحضورك وأدائك في مكان واحد.';
}

// Path: onboarding.steps.quizzes
class _TranslationsOnboardingStepsQuizzesAr extends TranslationsOnboardingStepsQuizzesEn {
	_TranslationsOnboardingStepsQuizzesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختبارات تفاعلية';
	@override String get description => 'اختبر معلوماتك باختبارات تفاعلية واحصل على تعليقات فورية.';
}

// Path: quizzes.rewards.days
class _TranslationsQuizzesRewardsDaysAr extends TranslationsQuizzesRewardsDaysEn {
	_TranslationsQuizzesRewardsDaysAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get sat => 'سبت';
	@override String get sun => 'أحد';
	@override String get mon => 'اثنين';
	@override String get tue => 'ثلاثاء';
	@override String get wed => 'أربعاء';
	@override String get thu => 'خميس';
	@override String get fri => 'جمعة';
}

// Path: quizzes.rewards.badges
class _TranslationsQuizzesRewardsBadgesAr extends TranslationsQuizzesRewardsBadgesEn {
	_TranslationsQuizzesRewardsBadgesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get lightningSpeed => 'سرعة البرق';
	@override String get perfectScore => 'الدرجة الكاملة';
	@override String get fiveDayStreak => '5 أيام متتالية';
	@override String get tenQuizzes => '10 اختبارات';
	@override String get physicsLion => 'أسد الفيزياء';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accountstatus.blockedTitle' => 'الحساب محظور',
			'accountstatus.blockedDescription' => 'تم حظر حسابك بسبب انتهاك شروط الخدمة الخاصة بنا.',
			'accountstatus.blockedSupportInfo' => 'إذا كنت تعتقد أن هذا خطأ، يرجى الاتصال بالدعم.',
			'accountstatus.pendingTitle' => 'الحساب قيد المراجعة',
			'accountstatus.pendingDescription' => 'حسابك قيد المراجعة حاليًا.',
			'accountstatus.pendingSupportInfo' => 'سنقوم بإخطارك بمجرد الموافقة على حسابك.',
			'accountstatus.refreshStatus' => 'تحديث الحالة',
			'accountstatus.rejectedTitle' => 'تم رفض الحساب',
			'accountstatus.rejectedDescription' => 'تم رفض حسابك.',
			'accountstatus.rejectedReason' => 'يرجى التحقق من معلوماتك والمحاولة مرة أخرى.',
			'accountstatus.studentCodeLabel' => 'كود الطالب',
			'aichat.aiTutorHistory' => 'سجل المعلم الذكي',
			'aichat.newChat' => 'دردشة جديدة',
			'aichat.unableToLoadConversations' => 'غير قادر على تحميل المحادثات.',
			'aichat.noConversationsYet' => 'لا توجد محادثات بعد',
			'aichat.noConversationsDesc' => 'ابدأ محادثة مع معلمك الذكي للحصول على مساعدة في دراستك.',
			'aichat.messagesCount' => ({required Object count}) => '${count} رسائل',
			'aichat.rename' => 'إعادة تسمية',
			'aichat.delete' => 'حذف',
			'aichat.studySession' => 'جلسة دراسية',
			'aichat.renameChat' => 'إعادة تسمية الدردشة',
			'aichat.enterNewTitle' => 'أدخل العنوان الجديد',
			'aichat.cancel' => 'إلغاء',
			'aichat.save' => 'حفظ',
			'aichat.aiAssistant' => 'المساعد الذكي',
			'aichat.commonLoading' => 'جاري المعالجة...',
			'aichat.aiSubtitle' => 'هنا دائمًا للمساعدة',
			'aichat.typeQuestion' => 'اسألني أي شيء...',
			'analytics.title' => 'تحليلات الأداء',
			'analytics.performanceDashboard' => 'لوحة الأداء',
			'analytics.academicJourney' => 'رحلتك الأكاديمية',
			'analytics.gradeVsPeers' => 'درجتك مقارنة بزملائك',
			'analytics.rank' => ({required Object rank}) => 'الترتيب #${rank}',
			'analytics.yourScore' => 'درجتك',
			'analytics.classAverage' => 'متوسط الفصل',
			'analytics.studentsCount' => ({required Object count}) => '${count} طالب',
			'analytics.aboveAverage' => 'أعلى من المتوسط',
			'analytics.belowAverage' => 'أقل من المتوسط',
			'analytics.performanceTrend' => 'اتجاه الأداء',
			'analytics.studyConsistency' => 'اتساق الدراسة',
			'analytics.daysStreak' => ({required Object days}) => '${days} أيام متتالية',
			'analytics.personalBestLabel' => ({required Object count}) => 'أفضل نتيجة شخصية: ${count}',
			'analytics.newRecord' => 'رقم قياسي جديد!',
			'analytics.leaderboardError' => 'تعذر تحميل لوحة المتصدرين',
			'analytics.studyPeakHours' => 'ساعات الدراسة الذروة',
			'analytics.badgesAndAchievements' => 'الشارات والإنجازات',
			'analytics.streakTitle' => 'سلسلة التفاعل',
			'analytics.streakEncouragement' => 'استمر! أنت تحرز تقدماً ثابتاً',
			'analytics.bestStreak' => 'أفضل سلسلة',
			'analytics.quizSpeedMetrics' => 'مقاييس سرعة الاختبار',
			'analytics.secondsPerQuestion' => 'ثانية/سؤال',
			'analytics.yourAverage' => 'متوسطك',
			'analytics.peerAverage' => 'متوسط الزملاء',
			'analytics.speedEncouragement' => 'أنت أسرع بنسبة 15% من متوسط زملائك! حافظ على هذا المستوى.',
			'analytics.allCourses' => 'كل الدورات',
			'analytics.noRankingsTitle' => 'لا توجد ترتيبات متاحة',
			'analytics.noRankingsDesc' => 'كن أول من ينضم إلى لوحة المتصدرين بإكمال دوراتك.',
			'analytics.yourStanding' => 'مركزك الحالي',
			'analytics.you' => 'أنت',
			'assignments.detail' => 'تفاصيل الواجب',
			'assignments.title' => 'واجب الموجات',
			'assignments.featureTitle' => 'الواجبات',
			'assignments.unit' => 'الوحدة 3 - الحصة 2',
			'assignments.deadline' => 'الموعد النهائي',
			'assignments.maxScore' => 'الدرجة',
			'assignments.points' => 'نقاط',
			'assignments.instructionsLabel' => 'التعليمات:',
			'assignments.instructions' => 'حل المسائل التالية عن الموجات الميكانيكية. يجب حل جميع المسائل وتوضيح خطوات الحل كاملة.',
			'assignments.file' => 'ملف الواجب',
			'assignments.submit' => 'إرسال الواجب',
			'assignments.uploadFile' => 'اضغط لرفع الملف',
			'assignments.uploadHint' => 'PDF، صور (بحد أقصى 10 ميجابايت)',
			'assignments.notesOptional' => 'ملاحظات (اختياري):',
			'assignments.notesHint' => 'أضف ملاحظة للمعلم...',
			'assignments.feedbackTitle' => 'التعليقات',
			'assignments.instructorFeedback' => 'تعليق المعلم:',
			'assignments.registerAttendance' => 'تسجيل الحضور',
			'assignments.attendanceHistory' => 'سجل الحضور',
			'assignments.yourAttendanceCode' => 'كود الحضور الخاص بك',
			'assignments.exitTitle' => 'خروج من الواجب؟',
			'assignments.exitDesc' => 'لن يتم حفظ تقدمك. هل أنت متأكد من الخروج؟',
			'assignments.yourResponse' => 'إجابتك',
			'assignments.writeResponse' => 'اكتب إجابتك هنا...',
			'assignments.responseHint' => 'ابدأ الكتابة...',
			'assignments.attachments' => 'المرفقات',
			'assignments.noFiles' => 'لا توجد ملفات مرفقة بعد',
			'assignments.chooseCorrect' => 'اختر الإجابة الصحيحة:',
			'assignments.questionLabel' => 'سؤال',
			'assignments.submitted' => 'تم إرسال الواجب بنجاح',
			'assignments.alreadySubmitted' => 'لقد قمت بإرسال هذا الواجب بالفعل',
			'assignments.notFound' => 'الواجب غير موجود',
			'assignments.noAssignments' => 'لا توجد واجبات متاحة',
			'assignments.noAssignmentsDesc' => 'تحقق لاحقاً من وجود واجبات جديدة.',
			'assignments.dueAt' => ({required Object date}) => 'تاريخ التسليم: ${date}',
			'assignments.noDeadline' => 'بدون موعد تسليم',
			'assignments.cancel' => 'إلغاء',
			'assignments.exit' => 'خروج',
			'assignments.previous' => 'السابق',
			'assignments.next' => 'التالي',
			'assignments.result' => 'نتيجة الواجب',
			'assignments.veryGood' => 'جيد جداً',
			'assignments.commonBack' => 'رجوع',
			'assignments.viewResult' => 'عرض النتائج',
			'assignments.graded' => 'تم التقييم',
			'assignments.excellent' => 'ممتاز',
			'assignments.good' => 'جيد',
			'assignments.passed' => 'ناجح',
			'assignments.failed' => 'راسب',
			'attendance.noAttendance' => 'لا توجد سجلات حضور بعد',
			'attendance.attendanceHistory' => 'سجل الحضور',
			'attendance.attendanceRate' => 'نسبة الحضور',
			'attendance.present' => 'حاضر',
			'attendance.absent' => 'غائب',
			'attendance.session' => 'الحصة',
			'attendance.attendanceHistoryDesc' => 'سيظهر سجل الحضور الخاص بك هنا',
			'attendance.registerAttendance' => 'تسجيل الحضور',
			'attendance.yourAttendanceCode' => 'رمز الحضور الخاص بك',
			'attendance.showCodeInstruction' => 'اعرض هذا الرمز للمعلم لتسجيل حضورك.',
			'auth.welcomeBack' => 'مرحباً بك مجدداً',
			'auth.signInToContinue' => 'قم بتسجيل الدخول للمتابعة',
			'auth.forgotPassword' => 'نسيت كلمة المرور؟',
			'auth.signIn' => 'تسجيل الدخول',
			'auth.loginWithBiometrics' => 'الدخول بالبصمة',
			'auth.dontHaveAccount' => 'ليس لديك حساب؟',
			'auth.registerNow' => 'سجل الآن',
			'auth.welcome' => 'مرحباً',
			'auth.letsGetStarted' => 'لنبدأ الآن',
			'auth.basicDetailsDesc' => 'من فضلك أدخل بيانات الاتصال الأساسية',
			'auth.firstNameLabel' => 'الاسم الأول',
			'auth.phoneLabel' => 'رقم الهاتف',
			'auth.parentPhoneLabel' => 'رقم هاتف ولي الأمر',
			'auth.phoneAlreadyRegistered' => 'رقم الهاتف مسجل بالفعل',
			'auth.otpVerifyTitle' => 'تأكيد رقم الهاتف',
			'auth.otpSentWhatsapp' => 'لقد أرسلنا كود التأكيد إلى واتساب الخاص بك',
			'auth.resetTitle' => 'إعادة تعيين كلمة المرور',
			'auth.forgotPasswordTitle' => 'نسيت كلمة المرور؟',
			'auth.forgotPasswordDesc' => 'لا تقلق! أدخل رقم هاتفك أدناه وسنرسل لك كوداً لإعادة تعيين كلمة المرور الخاصة بك.',
			'auth.sendResetCode' => 'إرسال كود إعادة التعيين',
			'auth.resetOtpSentPrefix' => 'لقد أرسلنا كود التأكيد إلى ',
			'auth.resetOtpSentSuffix' => '. أدخله أدناه لإعادة تعيين كلمة المرور.',
			'auth.resetOtpLabel' => 'كود التأكيد',
			'auth.resetOtpHint' => '000000',
			'auth.resetOtpError' => 'من فضلك أدخل كود صحيح مكون من 6 أرقام',
			'auth.newPasswordLabel' => 'كلمة المرور الجديدة',
			'auth.newPasswordHint' => 'أدخل كلمة المرور الجديدة',
			'auth.passwordRules' => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
			'auth.confirmPasswordHint' => 'أعد إدخال كلمة المرور',
			'auth.otpSentGeneric' => 'تم إرسال كود التأكيد إلى هاتفك',
			'auth.otpSentPrefix' => 'لقد أرسلنا كوداً إلى ',
			'auth.didNotReceiveCode' => 'لم تصلك الرسالة؟',
			'auth.resendCode' => 'إعادة إرسال الكود',
			'auth.resendWhatsapp' => 'إعادة الإرسال عبر واتساب',
			'auth.resendIn' => 'إعادة الإرسال خلال',
			'auth.verifyOtp' => 'تأكيد الكود',
			'auth.editNumber' => 'تعديل الرقم',
			'auth.gradeLabel' => 'الصف الدراسي',
			'auth.governorateLabel' => 'المحافظة',
			'auth.passwordAndPhotosLabel' => 'كلمة المرور والصورة',
			'auth.passwordHint' => 'أدخل كلمة المرور',
			'auth.submitRegistration' => 'إتمام التسجيل',
			'auth.commonNext' => 'التالي',
			'auth.alreadyHaveAccount' => 'لديك حساب بالفعل؟',
			'auth.loginButton' => 'تسجيل الدخول',
			'auth.submissionTitle' => 'تم إرسال طلب التسجيل',
			'auth.submissionDescription' => 'حسابك الآن تحت المراجعة. ستتلقى رسالة عبر واتساب ببيانات الدخول بعد الموافقة.',
			'auth.passwordResetSuccess' => 'تم إعادة تعيين كلمة المرور بنجاح!',
			'auth.backToLogin' => 'العودة لتسجيل الدخول',
			'auth.codeLabel' => 'كود الطالب',
			'auth.registerTitle' => 'إنشاء حساب',
			'auth.secondNameLabel' => 'الاسم الثاني',
			'auth.thirdNameLabel' => 'الاسم الثالث',
			'auth.fourthNameLabel' => 'الاسم الرابع',
			'auth.personalPhotoLabel' => 'الصورة الشخصية',
			'auth.personalInfoDesc' => 'من فضلك أدخل اسمك بالكامل كما هو موجود في الأوراق الرسمية.',
			'auth.academicInfoTitle' => 'المعلومات الأكاديمية',
			'auth.academicInfoDesc' => 'أخبرنا عن مستواك الدراسي',
			'auth.schoolNameLabel' => 'اسم المدرسة',
			'auth.educationAdminLabel' => 'الإدارة التعليمية',
			'auth.gradeHint' => 'اختر الصف الدراسي',
			'auth.studyTypeLabel' => 'نوع الدراسة',
			'auth.studyTypeOnline' => 'أونلاين',
			'auth.studyTypeCenter' => 'سنتر',
			'auth.centerNameLabel' => 'اسم السنتر',
			'auth.locationDetailsTitle' => 'تفاصيل العنوان',
			'auth.locationDetailsDesc' => 'أخبرنا بمكان سكنك',
			'auth.governorateHint' => 'اختر المحافظة',
			'auth.regionLabel' => 'المنطقة',
			'auth.regionHint' => 'اختر المنطقة',
			'auth.confirmPasswordLabel' => 'تأكيد كلمة المرور',
			'auth.passwordMismatch' => 'كلمات المرور غير متطابقة',
			'auth.securityIdentityTitle' => 'الأمان والهوية',
			'auth.securityIdentityDesc' => 'احمِ حسابك وأكد هويتك',
			'auth.passwordWeak' => 'ضعيفة',
			'auth.passwordFair' => 'متوسطة',
			'auth.passwordGood' => 'جيدة',
			'auth.passwordStrong' => 'قوية',
			'auth.nationalIdPhotoLabel' => 'صورة البطاقة الشخصية',
			'auth.uploadIdFront' => 'رفع وجه البطاقة',
			'auth.biometricHint' => 'تسجيل الدخول بالبصمة سيكون متاحاً بعد أول عملية دخول ناجحة على هذا الجهاز.',
			'auth.registrationLabel' => 'تسجيل حساب',
			'auth.gallery' => 'المعرض',
			'auth.camera' => 'الكاميرا',
			'auth.login.phoneNumber' => 'رقم الهاتف',
			'auth.login.password' => 'كلمة المرور',
			'auth.login.signIn' => 'تسجيل الدخول',
			'auth.login.phoneValidationError' => 'من فضلك أدخل رقم هاتف مصري صحيح',
			'auth.forms.required' => 'هذا الحقل مطلوب',
			'auth.forms.minLength' => ({required int length}) => 'الحد الأدنى ${length} أحرف',
			'core.appName' => 'MentorX Student',
			'core.currency' => 'ج.م',
			'core.price' => ({required num amount}) => '${amount} ${_root.core.currency}',
			'core.languages.en' => 'English',
			'core.languages.ar' => 'العربية',
			'core.initialLanguage.header' => 'يرجى تحديد اللغة المفضلة',
			'core.initialLanguage.kContinue' => 'موافق',
			'core.logoutSetting' => 'تسجيل الخروج',
			'core.logoutConfirmTitle' => 'تسجيل الخروج',
			'core.logoutConfirmDesc' => 'هل أنت متأكد من تسجيل الخروج؟',
			'core.preview' => 'معاينة',
			'core.comingSoon' => 'قريباً',
			'core.opening' => ({required Object url}) => 'جاري فتح ${url}...',
			'core.search' => 'بحث',
			'core.viewAll' => 'عرض الكل',
			'core.skip' => 'تخطي',
			'core.next' => 'التالي',
			'core.getStarted' => 'ابدأ الآن',
			'core.retry' => 'إعادة المحاولة',
			'core.cancel' => 'إلغاء',
			'core.settingsTitle' => 'الإعدادات',
			'core.editProfile' => 'تعديل الملف الشخصي',
			'core.studentCard' => 'بطاقة الطالب',
			'core.digitalId' => 'الهوية الرقمية',
			'core.personalData' => 'البيانات الشخصية',
			'core.name' => 'الاسم',
			'core.phone' => 'الهاتف',
			'core.grade' => 'الصف',
			'core.center' => 'السنتر',
			'core.school' => 'المدرسة',
			'core.attendance' => 'الحضور',
			'core.wallet' => 'المحفظة',
			'core.sendRequest' => 'إرسال الطلب',
			'core.tEditionPro' => 'نسخة MentorX برو',
			'core.aboutDesc' => 'منصة MentorX هي منصة تعليمية شاملة تهدف لتمكين الطلاب وأولياء الأمور.',
			'core.version' => ({required Object v}) => 'الإصدار ${v}',
			'core.lastUpdate' => ({required Object date}) => 'آخر تحديث: ${date}',
			'core.buildLabel' => ({required Object b}) => 'بناء: ${b}',
			'core.allRightsReserved' => 'جميع الحقوق محفوظة © 2026 MentorX',
			'core.unableToLoadDevices' => 'تعذر تحميل الأجهزة',
			'core.noRegisteredDevices' => 'لا يوجد أجهزة مسجلة',
			'core.activeSessionsDesc' => 'إدارة جلساتك النشطة وأجهزتك.',
			'core.deactivateDevice' => 'إلغاء تنشيط الجهاز',
			'core.deactivatedLabel' => 'تم إلغاء التنشيط',
			'core.activeLabel' => 'نشط',
			'core.inactiveLabel' => 'غير نشط',
			'core.language' => 'اللغة',
			'core.account' => 'الحساب',
			'core.changePasswordSetting' => 'تغيير كلمة المرور',
			'core.deviceManagement' => 'إدارة الأجهزة',
			'core.communication' => 'التواصل',
			'core.notificationsSetting' => 'التنبيهات',
			'core.whatsappGroups' => 'مجموعات واتساب',
			'core.helpAndInfo' => 'المساعدة والمعلومات',
			'core.aboutSetting' => 'عن التطبيق',
			'core.lastUsedAt' => ({required Object date}) => 'آخر استخدام في ${date}',
			'core.excellent' => 'ممتاز',
			'core.veryGood' => 'جيد جداً',
			'core.fail' => 'تحتاج لمزيد من الجهد',
			'core.of' => ({required Object count}) => 'من ${count}',
			'course.lessonProgress' => ({required Object completed, required Object total}) => '${completed}/${total} درساً',
			'course.myAcademy' => 'أكاديميتي',
			'course.courseDetail' => 'تفاصيل الدورة',
			'course.myCourses' => 'دوراتي',
			'course.tabs.inProgress' => 'قيد التنفيذ',
			'course.tabs.completed' => 'مكتملة',
			'course.tabs.expired' => 'منتهية',
			'course.tabs.description' => 'الوصف',
			'course.tabs.sessions' => 'الحصص',
			'course.empty.noEnrolledCourses' => 'لا توجد دورات مسجلة',
			'course.empty.noEnrolledCoursesDescription' => 'لم تقم بالتسجيل في أي دورات بعد.',
			'course.empty.browseCatalog' => 'تصفح الكتالوج',
			'course.detail.enrollSuccess' => 'تم التسجيل بنجاح!',
			'course.detail.enrollFailed' => 'فشل التسجيل.',
			'course.detail.yourPerformance' => 'أداؤك',
			'course.detail.daysLeft' => 'أيام متبقية',
			'course.detail.items' => 'عناصر',
			'course.detail.sessionFree' => 'مجاني',
			'course.detail.aboutCourse' => 'عن هذه الدورة',
			'course.detail.videos' => 'فيديو',
			'course.detail.minutes' => 'دقيقة',
			'course.detail.students' => 'طالب',
			'course.detail.sessions' => 'الحصص',
			'course.detail.free' => 'مجاني',
			'course.detail.yourProgress' => 'تقدمك',
			'course.detail.completePercent' => ({required Object percent}) => '${percent}% مكتمل',
			'course.detail.continueStudying' => 'استكمل الدراسة',
			'course.detail.courseCompleted' => 'الدورة مكتملة',
			'course.detail.courseExpired' => 'انتهت صلاحية الدورة',
			'course.detail.enrollNow' => 'سجل الآن',
			'course.detail.pointsReward' => 'جائزة نقاط',
			'course.detail.durationShort' => ({required Object mins, required Object secs}) => '${mins}د ${secs}ث',
			'course.errors.failedToLoadSessions' => 'فشل في تحميل حصص الدورة',
			'course.errors.tryRefreshing' => 'حاول تحديث الصفحة',
			'course.player.completed' => 'مكتمل',
			'course.player.duration' => 'المدة',
			'course.player.status' => 'الحالة',
			'course.player.watching' => 'جاري المشاهدة',
			'course.lessonsCompleted' => 'الدروس المكتملة',
			'course.timeSpent' => 'الوقت المستغرق',
			'course.quizzesTaken' => 'الاختبارات المجتازة',
			'course.avgQuizScore' => 'متوسط درجة الاختبار',
			'course.catalog.allCategories' => 'كل التصنيفات',
			'course.catalog.allLevels' => 'كل المستويات',
			'course.catalog.coursesFound' => ({required Object count}) => 'تم العثور على ${count} دورة',
			'course.catalog.noCourses' => 'لم يتم العثور على دورات',
			'course.catalog.noCoursesDescription' => 'حاول تغيير الفلاتر أو كلمات البحث',
			'course.catalog.searchHint' => 'ابحث عن الدورات...',
			'course.catalog.sortBy' => 'ترتيب حسب',
			'course.catalog.sortNewest' => 'الأحدث',
			'course.catalog.sortPriceAsc' => 'السعر: من الأقل للأعلى',
			'course.catalog.sortPriceDesc' => 'السعر: من الأعلى للأقل',
			'course.catalog.sortPopular' => 'الأكثر شيوعاً',
			'course.myGrades.title' => 'درجاتي',
			'course.myGrades.noGrades' => 'لا توجد درجات متاحة بعد.',
			'course.myGrades.completeAssessmentsDesc' => 'أكمل الاختبارات والمهام لعرض درجاتك.',
			'course.myGrades.overallAverage' => 'الأداء العام',
			'course.myGrades.allCourses' => 'كل الدورات',
			'course.markAsDone' => 'تحديد كمكتمل',
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
			'home.dashboard.myCourses' => 'دوراتي',
			'home.dashboard.attendance' => 'الحضور',
			'home.dashboard.grades' => 'الدرجات',
			'home.dashboard.aiAssistant' => 'مساعد AI',
			'home.dashboard.assignments' => 'الواجبات',
			'home.dashboard.rewards' => 'المكافآت',
			'home.dashboard.marketplace' => 'المتجر',
			'home.dashboard.analytics' => 'تحليلات الأداء',
			'home.dashboard.courseCatalog' => 'كتالوج الدورات',
			'home.dashboard.leaderboard' => 'لوحة المتصدرين',
			'marketplace.orderPlaced' => 'تم تقديم الطلب بنجاح!',
			'marketplace.orderFailed' => 'فشل في تقديم الطلب',
			'marketplace.apply' => 'تطبيق',
			'marketplace.deliveryAddress' => 'عنوان التوصيل',
			'marketplace.phoneNumber' => 'رقم الهاتف',
			'marketplace.deliveryNotes' => 'ملاحظات التوصيل',
			'marketplace.walletBalance' => 'رصيد المحفظة',
			'marketplace.subtotal' => 'المجموع الفرعي',
			'marketplace.discount' => 'الخصم',
			'marketplace.delivery' => 'التوصيل',
			'marketplace.search' => 'بحث',
			'marketplace.searchProducts' => 'البحث عن المنتجات...',
			'marketplace.all' => 'الكل',
			'marketplace.errorLoadingProducts' => 'خطأ في تحميل المنتجات',
			'marketplace.noProductsFound' => 'لم يتم العثور على منتجات',
			'marketplace.store' => 'المتجر',
			'marketplace.egp' => 'ج.م',
			'marketplace.addedToCart' => 'تمت الإضافة إلى السلة',
			'marketplace.explore' => 'استكشف',
			'marketplace.hot' => 'شائع',
			'marketplace.tryAgainLater' => 'حاول مرة أخرى لاحقاً',
			'marketplace.errorLoadingProduct' => 'خطأ في تحميل المنتج',
			'marketplace.addToCart' => 'إضافة إلى السلة',
			'marketplace.description' => 'الوصف',
			'marketplace.stockStatus' => 'حالة المخزون',
			'marketplace.inStock' => 'في المخزن',
			'marketplace.outOfStock' => 'غير متوفر',
			'marketplace.onlyLeft' => 'متبقي فقط',
			'marketplace.items' => 'قطع',
			'marketplace.cart.title' => 'سلتي',
			'marketplace.cart.empty' => 'سلة التسوق فارغة',
			'marketplace.cart.emptyDesc' => 'يبدو أنك لم تضف أي شيء بعد.',
			'marketplace.cart.startShopping' => 'ابدأ التسوق',
			'marketplace.cart.checkout' => 'إتمام الشراء',
			'marketplace.cart.confirmOrder' => 'تأكيد الطلب',
			'marketplace.cart.deliveryDetails' => 'تفاصيل التوصيل',
			'marketplace.cart.insufficientBalance' => 'الرصيد غير كافٍ',
			'marketplace.cart.insufficientBalanceDesc' => ({required Object amount}) => 'الرصيد غير كافٍ. يرجى شحن ${amount} ج.م لإتمام الطلب.',
			'marketplace.cart.couponApplied' => 'تم تطبيق الكوبون!',
			'marketplace.cart.haveCoupon' => 'هل لديك كود خصم؟',
			'marketplace.cart.viewCodes' => 'عرض الأكواد',
			'marketplace.orders.title' => 'سجل الطلبات',
			'marketplace.orders.noOrders' => 'لم تقم بتقديم أي طلبات بعد.',
			'marketplace.orders.startShoppingDesc' => 'استكشف متجرنا وقدم طلبك الأول!',
			'marketplace.orders.orderNumber' => ({required Object number}) => 'طلب رقم #${number}',
			'marketplace.orders.itemsCount' => ({required Object count}) => '${count} قطع',
			'marketplace.orders.status.pending' => 'قيد الانتظار',
			'marketplace.orders.status.confirmed' => 'تم التأكيد',
			'marketplace.orders.status.processing' => 'جاري التنفيذ',
			'marketplace.orders.status.shipped' => 'تم الشحن',
			'marketplace.orders.status.delivered' => 'تم التوصيل',
			'marketplace.orders.status.cancelled' => 'ملغي',
			'notifications.noNotifications' => 'لا توجد إشعارات بعد',
			'notifications.noNotificationsDesc' => 'سنقوم بإخطارك عندما يحدث شيء مهم.',
			'notifications.notificationsTitle' => 'الإشعارات',
			'onboarding.somethingWentWrong' => 'حدث خطأ ما.',
			'onboarding.retry' => 'إعادة المحاولة',
			'onboarding.steps.learn.title' => 'تعلم في أي وقت وفي أي مكان',
			'onboarding.steps.learn.description' => 'الوصول إلى الدورات والمواد الخاصة بك أثناء التنقل. تعلم بالسرعة التي تناسبك.',
			'onboarding.steps.trackProgress.title' => 'تتبع تقدمك',
			'onboarding.steps.trackProgress.description' => 'تتبع درجاتك وحضورك وأدائك في مكان واحد.',
			'onboarding.steps.quizzes.title' => 'اختبارات تفاعلية',
			'onboarding.steps.quizzes.description' => 'اختبر معلوماتك باختبارات تفاعلية واحصل على تعليقات فورية.',
			'profile.title' => 'الملف الشخصي',
			'profile.wallet' => 'المحفظة',
			'profile.attendance' => 'الحضور',
			'profile.personalData' => 'البيانات الشخصية',
			'profile.name' => 'الاسم',
			'profile.phone' => 'رقم الهاتف',
			'profile.grade' => 'السنة الدراسية',
			'profile.center' => 'المركز',
			'profile.school' => 'المدرسة',
			'profile.firstName' => 'الاسم الأول',
			'profile.secondName' => 'الاسم الثاني',
			'profile.thirdName' => 'الاسم الثالث',
			'profile.fourthName' => 'الاسم الرابع',
			'profile.governorate' => 'المحافظة',
			'profile.area' => 'المنطقة',
			'profile.educationDepartment' => 'الإدارة التعليمية',
			'profile.digitalId' => 'الهوية الرقمية',
			'profile.editProfile' => 'تعديل الملف الشخصي',
			'profile.settingsTitle' => 'الإعدادات',
			'profile.logoutSetting' => 'تسجيل الخروج',
			'profile.logoutConfirmTitle' => 'تأكيد تسجيل الخروج',
			'profile.logoutConfirmDesc' => 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
			'profile.cancel' => 'إلغاء',
			'profile.editsNeedApproval' => 'التعديلات تحتاج إلى موافقة المعلم',
			'profile.personalInfo' => 'البيانات الشخصية',
			'profile.requiredField' => 'هذا الحقل مطلوب',
			'profile.academicInfo' => 'البيانات الأكاديمية',
			'profile.reasonForEdit' => 'سبب التعديل',
			'profile.provideReason' => 'يرجى ذكر السبب',
			'profile.reasonHint' => 'اكتب سبب تعديل ملفك الشخصي...',
			'profile.sendRequest' => 'إرسال الطلب',
			'profile.changePasswordDesc' => 'تحديث كلمة مرور حسابك',
			'profile.currentPassword' => 'كلمة المرور الحالية',
			'profile.newPassword' => 'كلمة المرور الجديدة',
			'profile.confirmNewPassword' => 'تأكيد كلمة المرور الجديدة',
			'profile.passwordTooShort' => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
			'profile.passwordsDoNotMatch' => 'كلمات المرور غير متطابقة',
			'profile.saveChanges' => 'حفظ التغييرات',
			'profile.changePassword' => 'تغيير كلمة المرور',
			'profile.noChangesDetected' => 'لم يتم اكتشاف أي تغييرات',
			'profile.requestSentSuccess' => 'تم إرسال الطلب بنجاح',
			'quizzes.title' => 'الاختبارات',
			'quizzes.noQuizzes' => 'لا توجد اختبارات متاحة',
			'quizzes.noQuizzesDesc' => 'تحقق لاحقاً من وجود اختبارات جديدة.',
			'quizzes.quizResult' => 'نتيجة الاختبار',
			'quizzes.score' => 'النتيجة',
			'quizzes.timeTaken' => 'الوقت المستغرق',
			'quizzes.correctAnswers' => 'صحيحة',
			'quizzes.wrongAnswers' => 'خاطئة',
			'quizzes.reviewAnswers' => 'مراجعة الإجابات',
			'quizzes.yourAnswer' => 'إجابتك',
			'quizzes.correctAnswer' => 'الإجابة الصحيحة',
			'quizzes.leaderboard' => 'لوحة الصدارة',
			'quizzes.claimReward' => 'المطالبة بالمكافأة',
			'quizzes.assessments' => 'التقييمات',
			'quizzes.navQuizzes' => 'الاختبارات',
			'quizzes.questions' => 'أسئلة',
			'quizzes.minutesShort' => 'دقيقة',
			'quizzes.quizNotFound' => 'الاختبار غير موجود',
			'quizzes.resumeQuiz' => 'استئناف الاختبار',
			'quizzes.startQuiz' => 'بدء الاختبار',
			'quizzes.commonBack' => 'رجوع',
			'quizzes.quizUnitTitle' => 'اختبار الوحدة',
			'quizzes.quizSubtitle' => 'اختبر معلوماتك في هذه الوحدة',
			'quizzes.questionCount' => 'عدد الأسئلة',
			'quizzes.duration' => 'المدة',
			'quizzes.passGrade' => 'درجة النجاح',
			'quizzes.attempts' => 'المحاولات',
			'quizzes.instructions' => 'التعليمات',
			'quizzes.instructionRead' => 'اقرأ الأسئلة بعناية قبل الإجابة.',
			'quizzes.instructionReview' => 'يمكنك مراجعة إجاباتك في النهاية.',
			'quizzes.instructionNoReturn' => 'بمجرد الإرسال، لا يمكنك تغيير إجاباتك.',
			'quizzes.resultNotFound' => 'لم يتم العثور على نتيجة الاختبار',
			'quizzes.excellent' => 'ممتاز',
			'quizzes.veryGood' => 'جيد جداً',
			'quizzes.fail' => 'راسب',
			'quizzes.greatResult' => 'نتيجة رائعة!',
			'quizzes.noQuestions' => 'لا توجد أسئلة متاحة',
			'quizzes.exitQuizTitle' => 'الخروج من الاختبار؟',
			'quizzes.exitQuizDesc' => 'يتم حفظ تقدمك تلقائياً. يمكنك استئناف هذا الاختبار لاحقاً من صفحة المقدمة.',
			'quizzes.cancel' => 'إلغاء',
			'quizzes.exit' => 'خروج',
			'quizzes.questionLabel' => 'سؤال',
			'quizzes.chooseCorrect' => 'اختر الإجابة الصحيحة:',
			'quizzes.typeAnswerHere' => 'اكتب إجابتك هنا...',
			'quizzes.commonPrevious' => 'السابق',
			'quizzes.commonSubmit' => 'إرسال',
			'quizzes.commonNext' => 'التالي',
			'quizzes.rewards.title' => 'نظام النقاط',
			'quizzes.rewards.goldLevel' => 'ذهبي',
			'quizzes.rewards.toNextLevel' => 'للمستوى التالي',
			'quizzes.rewards.xpPoints' => 'نقاط الخبرة',
			'quizzes.rewards.quizCompleted' => 'الاختبارات',
			'quizzes.rewards.badge' => 'الأوسمة',
			_ => null,
		} ?? switch (path) {
			'quizzes.rewards.dailyStreak' => 'النشاط اليومي',
			'quizzes.rewards.streakDaysMsg' => ({required Object days}) => 'لديك سلسلة نشاط لمدة ${days} أيام!',
			'quizzes.rewards.earnedBadges' => 'الأوسمة',
			'quizzes.rewards.leaderboard' => 'لوحة الصدارة',
			'quizzes.rewards.days.sat' => 'سبت',
			'quizzes.rewards.days.sun' => 'أحد',
			'quizzes.rewards.days.mon' => 'اثنين',
			'quizzes.rewards.days.tue' => 'ثلاثاء',
			'quizzes.rewards.days.wed' => 'أربعاء',
			'quizzes.rewards.days.thu' => 'خميس',
			'quizzes.rewards.days.fri' => 'جمعة',
			'quizzes.rewards.badges.lightningSpeed' => 'سرعة البرق',
			'quizzes.rewards.badges.perfectScore' => 'الدرجة الكاملة',
			'quizzes.rewards.badges.fiveDayStreak' => '5 أيام متتالية',
			'quizzes.rewards.badges.tenQuizzes' => '10 اختبارات',
			'quizzes.rewards.badges.physicsLion' => 'أسد الفيزياء',
			'quizzes.review.title' => 'مراجعة الإجابات',
			'quizzes.review.jumpToQuestion' => 'الانتقال إلى سؤال',
			'quizzes.review.submitQuiz' => 'إرسال الاختبار',
			'quizzes.review.backToQuestions' => 'العودة للأسئلة',
			'quizzes.review.answeredCount' => 'الأسئلة المجابة',
			'quizzes.review.unansweredNote' => ({required Object count}) => 'متبقي ${count} أسئلة',
			'rewards.noRewards' => 'لا توجد مكافآت متاحة',
			'rewards.noRewardsDesc' => 'تحقق مرة أخرى لاحقًا لرؤية العناصر الجديدة.',
			'rewards.rewardsTitle' => 'كتالوج المكافآت',
			'rewards.pointsBalance' => 'رصيد النقاط',
			'rewards.points' => 'نقاط',
			'rewards.redeemPointsDesc' => 'استبدل نقاطك بمكافآت حصرية.',
			'rewards.redeem' => 'استبدال',
			'rewards.noHistory' => 'لا توجد سجلات نقاط بعد',
			'rewards.noHistoryDesc' => 'اكسب النقاط عن طريق إكمال المهام والمشاركة في الأنشطة.',
			'rewards.rewardsHistoryTitle' => 'سجل النقاط',
			'rewards.balance' => ({required Object balance}) => 'الرصيد: ${balance}',
			'settings.title' => 'الإعدادات',
			'settings.language' => 'اللغة',
			'settings.account' => 'الحساب',
			'settings.changePasswordSetting' => 'تغيير كلمة المرور',
			'settings.studentCard' => 'بطاقة الطالب',
			'settings.deviceManagement' => 'إدارة الأجهزة',
			'settings.communication' => 'الاتصالات',
			'settings.notificationsSetting' => 'الإشعارات',
			'settings.whatsappGroups' => 'مجموعات الواتساب',
			'settings.whatsappGroupsDesc' => 'انضم إلى مجموعات الواتساب الرسمية لدينا للبقاء على اطلاع بآخر الأخبار والإعلانات.',
			'settings.helpAndInfo' => 'المساعدة والمعلومات',
			'settings.aboutSetting' => 'عن التطبيق',
			'settings.logoutSetting' => 'تسجيل الخروج',
			'settings.membersActive' => ({required Object count}) => '${count} عضو نشط',
			'settings.linkCopied' => 'تم نسخ الرابط إلى الحافظة',
			'settings.copyInviteLink' => 'نسخ رابط الدعوة',
			'settings.preferencesLabel' => 'التفضيلات',
			'settings.logoutConfirmTitle' => 'تسجيل الخروج',
			'settings.logoutConfirmDesc' => 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
			'settings.communityLabel' => 'المجتمع',
			'settings.tEditionPro' => 'مينتور إكس برو',
			'settings.aboutDesc' => 'مينتور إكس هي منصة شاملة مصممة لتبسيط إدارة الطلاب وتتبع الأداء وتعزيز التواصل.',
			'settings.version' => 'الإصدار',
			'settings.lastUpdate' => 'آخر تحديث',
			'settings.buildLabel' => 'البناء',
			'settings.allRightsReserved' => '© 2026 مينتور إكس. جميع الحقوق محفوظة.',
			'settings.appInfoLabel' => 'معلومات التطبيق',
			'settings.unableToLoadDevices' => 'تعذر تحميل الأجهزة',
			'settings.settingsLabel' => 'الإعدادات',
			'settings.noRegisteredDevices' => 'لا توجد أجهزة مسجلة',
			'settings.activeSessionsDesc' => 'يمكنك إدارة جلساتك النشطة هنا.',
			'settings.lastUsedAt' => ({required Object date}) => 'آخر استخدام: ${date}',
			'settings.deactivateDevice' => 'إلغاء التنشيط',
			'settings.deactivatedLabel' => 'تم إلغاء التنشيط',
			'settings.activeLabel' => 'نشط',
			'settings.inactiveLabel' => 'غير نشط',
			'shell.navHome' => 'الرئيسية',
			'shell.navCourses' => 'الدورات',
			'shell.navQuizzes' => 'الاختبارات',
			'shell.navWallet' => 'المحفظة',
			'shell.navAccount' => 'الحساب',
			'studentcard.title' => 'بطاقة الطالب',
			'studentcard.platformName' => 'منصة MentorX',
			'studentcard.codeLabel' => 'كود الطالب',
			'studentcard.scanForAttendance' => 'امسح الكود لتسجيل الحضور',
			'studentcard.secureDigitalId' => 'هوية رقمية آمنة',
			'studentcard.gradeLabel' => 'الصف الدراسي',
			'studentcard.digitalId' => 'الهوية الرقمية',
			'studentcard.errorLoading' => 'خطأ في تحميل البطاقة',
			'studentcard.refreshStatus' => 'تحديث الحالة',
			'studentcard.errorLoadingMessage' => 'لم نتمكن من تحميل بطاقة الطالب الخاصة بك. يرجى المحاولة مرة أخرى.',
			'wallet.addBalance' => 'إضافة رصيد',
			'wallet.redeemCode' => 'شحن كود',
			'wallet.myOrders' => 'طلباتي',
			'wallet.recentTransactions' => 'المعاملات الأخيرة',
			'wallet.seeAll' => 'عرض الكل',
			'wallet.noTransactions' => 'لا توجد معاملات بعد',
			'wallet.walletTitle' => 'محفظتك',
			'wallet.walletBalance' => 'رصيد المحفظة',
			'wallet.egp' => 'ج.م',
			'wallet.points' => 'نقاط',
			'wallet.transactionsTitle' => 'المعاملات',
			'wallet.vodafoneCash' => 'فودافون كاش',
			'wallet.vodafoneDesc' => 'الدفع باستخدام محفظة فودافون كاش',
			'wallet.instaPay' => 'إنستا باي',
			'wallet.instaPayDesc' => 'الدفع باستخدام تطبيق إنستا باي',
			'wallet.fawry' => 'فوري',
			'wallet.fawryDesc' => 'الدفع في أي نقطة بيع فوري',
			'wallet.amount' => 'المبلغ',
			'wallet.choosePaymentMethod' => 'اختر طريقة الدفع',
			'wallet.continueBtn' => 'استمرار',
			'wallet.redeemCodeTitle' => 'شحن الكود الخاص بك',
			'wallet.enterCodeDesc' => 'أدخل الكود الذي استلمته لإضافة رصيد إلى محفظتك.',
			'wallet.activateCode' => 'تفعيل الكود',
			'wallet.redeemPolicy' => 'بتفعيل هذا الكود، فإنك توافق على الشروط والأحكام الخاصة بنا.',
			'wallet.purchaseConfirm' => 'تأكيد الشراء',
			'wallet.failedToLoadPayment' => 'فشل في تحميل الدفع',
			'wallet.paymentMethod' => 'طريقة الدفع',
			'wallet.reference' => 'المرجع',
			'wallet.total' => 'الإجمالي',
			'wallet.confirmPayment' => 'تأكيد الدفع',
			'wallet.paymentSuccess' => 'تم الدفع بنجاح',
			'wallet.balanceAdded' => 'تم إضافة الرصيد: %s',
			'wallet.newBalance' => 'الرصيد الجديد',
			'wallet.backToWallet' => 'العودة إلى المحفظة',
			_ => null,
		};
	}
}
