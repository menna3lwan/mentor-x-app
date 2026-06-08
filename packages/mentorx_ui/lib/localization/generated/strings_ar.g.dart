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
	@override late final _TranslationsCommonAr common = _TranslationsCommonAr._(_root);
	@override late final _TranslationsWidgetsAr widgets = _TranslationsWidgetsAr._(_root);
	@override late final _TranslationsCoreAr core = _TranslationsCoreAr._(_root);
	@override late final _TranslationsParentAr parent = _TranslationsParentAr._(_root);
	@override late final _TranslationsFormsAr forms = _TranslationsFormsAr._(_root);
	@override Map<String, dynamic> get exceptions => {
		'unknown': 'خطأ غير معروف',
		'AuthenticationRepositoryExceptionCode': _TranslationsExceptionsAuthenticationRepositoryExceptionCodeAr._(_root),
	};
}

// Path: common
class _TranslationsCommonAr implements TranslationsCommonEn {
	_TranslationsCommonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'إلغاء';
	@override String get ok => 'حسناً';
	@override String get viewAll => 'عرض الكل';
	@override String get required => 'مطلوب';
	@override String get optional => 'اختياري';
	@override String get customization => 'تخصيص';
	@override String get skip => 'تخطي';
	@override String get next => 'التالي';
	@override String get getStarted => 'ابدأ الآن';
	@override String get backToLogin => 'العودة لتسجيل الدخول';
	@override String get noResults => 'لم يتم العثور على نتائج';
	@override String opening({required Object url}) => 'جاري فتح: ${url}';
	@override String get comingSoon => 'قريباً';
	@override String get somethingWentWrong => 'حدث خطأ ما';
	@override String get retry => 'إعادة المحاولة';
	@override String get readMore => 'اقرأ المزيد';
	@override String get readLess => 'عرض أقل';
}

// Path: widgets
class _TranslationsWidgetsAr implements TranslationsWidgetsEn {
	_TranslationsWidgetsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWidgetsAnnouncementAr announcement = _TranslationsWidgetsAnnouncementAr._(_root);
	@override late final _TranslationsWidgetsAttendanceAr attendance = _TranslationsWidgetsAttendanceAr._(_root);
	@override late final _TranslationsWidgetsErrorAr error = _TranslationsWidgetsErrorAr._(_root);
}

// Path: core
class _TranslationsCoreAr implements TranslationsCoreEn {
	_TranslationsCoreAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get currency => 'ج.م';
}

// Path: parent
class _TranslationsParentAr implements TranslationsParentEn {
	_TranslationsParentAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get unableToLoad => 'تعذر التحميل';
	@override String get childWalletBalance => 'رصيد محفظة الطفل';
	@override String get transactionHistory => 'سجل المعاملات';
	@override String get financialMonitor => 'المراقب المالي';
	@override String get announcements => 'الإعلانات';
	@override String get overallAverage => 'المعدل العام';
	@override String get noData => 'لا توجد بيانات';
	@override String get enrolledCourses => 'الدورات المسجلة';
	@override String get academicMonitor => 'المراقب الأكاديمي';
	@override String get services => 'الخدمات';
	@override String get recentActivity => 'النشاط الأخير';
	@override String get welcomeBack => 'مرحباً بك مجدداً';
	@override String get accountInfo => 'معلومات الحساب';
	@override String get appSettings => 'إعدادات التطبيق';
	@override String get notifications => 'الإشعارات';
	@override String get security => 'الأمان';
	@override String get signOut => 'تسجيل الخروج';
	@override String get myProfile => 'ملفي الشخصي';
	@override String get viewAll => 'عرض الكل';
	@override late final _TranslationsParentAuthAr auth = _TranslationsParentAuthAr._(_root);
	@override late final _TranslationsParentChildrenAr children = _TranslationsParentChildrenAr._(_root);
	@override late final _TranslationsParentNotificationCenterAr notificationCenter = _TranslationsParentNotificationCenterAr._(_root);
	@override late final _TranslationsParentOnboardingAr onboarding = _TranslationsParentOnboardingAr._(_root);
	@override late final _TranslationsParentPushNotificationsAr pushNotifications = _TranslationsParentPushNotificationsAr._(_root);
	@override late final _TranslationsParentSplashAr splash = _TranslationsParentSplashAr._(_root);
	@override late final _TranslationsParentHomeAr home = _TranslationsParentHomeAr._(_root);
	@override late final _TranslationsParentAcademicAr academic = _TranslationsParentAcademicAr._(_root);
	@override late final _TranslationsParentAssessmentsAr assessments = _TranslationsParentAssessmentsAr._(_root);
	@override late final _TranslationsParentGradeDetailAr gradeDetail = _TranslationsParentGradeDetailAr._(_root);
	@override late final _TranslationsParentAttendanceTrackingAr attendanceTracking = _TranslationsParentAttendanceTrackingAr._(_root);
	@override late final _TranslationsParentFinancialAr financial = _TranslationsParentFinancialAr._(_root);
	@override late final _TranslationsParentCourseDetailAr courseDetail = _TranslationsParentCourseDetailAr._(_root);
	@override late final _TranslationsParentCommunicationAr communication = _TranslationsParentCommunicationAr._(_root);
	@override late final _TranslationsParentAnalyticsAr analytics = _TranslationsParentAnalyticsAr._(_root);
	@override late final _TranslationsParentQuickActionsAr quickActions = _TranslationsParentQuickActionsAr._(_root);
	@override late final _TranslationsParentProfileAr profile = _TranslationsParentProfileAr._(_root);
	@override late final _TranslationsParentDevicesAr devices = _TranslationsParentDevicesAr._(_root);
	@override late final _TranslationsParentDeleteAccountAr deleteAccount = _TranslationsParentDeleteAccountAr._(_root);
	@override late final _TranslationsParentPendingAccountAr pendingAccount = _TranslationsParentPendingAccountAr._(_root);
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
	@override String get unknown => 'خطأ غير معروف';
	@override String get invalidPhoneNumber => 'رقم الجوال غير صحيح';
	@override String get invalidOTP => 'رمز OTP غير صحيح';
	@override String get failedToInitialize => 'فشل التحميل';
	@override String get failedToSendOtp => 'فشل ارسال رمز ال OTP';
	@override String get failedToVerifyOtp => 'فشل التحقق من رمز ال OTP';
}

// Path: widgets.announcement
class _TranslationsWidgetsAnnouncementAr implements TranslationsWidgetsAnnouncementEn {
	_TranslationsWidgetsAnnouncementAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pinned => 'مثبت';
	@override String get update => 'تحديث';
}

// Path: widgets.attendance
class _TranslationsWidgetsAttendanceAr implements TranslationsWidgetsAttendanceEn {
	_TranslationsWidgetsAttendanceAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get rate => 'نسبة الحضور';
}

// Path: widgets.error
class _TranslationsWidgetsErrorAr implements TranslationsWidgetsErrorEn {
	_TranslationsWidgetsErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حدث خطأ ما';
	@override String get retry => 'إعادة المحاولة';
}

// Path: parent.auth
class _TranslationsParentAuthAr implements TranslationsParentAuthEn {
	_TranslationsParentAuthAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'منتور إكس';
	@override String get loginTagline => 'ابقَ على تواصل مع تعليم طفلك';
	@override String get signInToDashboard => 'سجّل الدخول إلى لوحة التحكم';
	@override String get phoneNumberLabel => 'رقم الجوال';
	@override String get phoneNumberHint => 'أدخل رقم جوالك';
	@override String get phoneRequired => 'رقم الجوال مطلوب';
	@override String get passwordLabel => 'كلمة المرور';
	@override String get passwordPlaceholder => 'أدخل كلمة المرور';
	@override String get passwordRequired => 'كلمة المرور مطلوبة';
	@override String get confirmPasswordLabel => 'تأكيد كلمة المرور';
	@override String get newPasswordLabel => 'كلمة المرور الجديدة';
	@override String get loginFailed => 'فشل تسجيل الدخول، يرجى المحاولة مرة أخرى';
	@override String get forgotPassword => 'نسيت كلمة المرور؟';
	@override String get forgotPasswordTitle => 'نسيت كلمة المرور';
	@override String get forgotPasswordSubtitle => 'أدخل رقم جوالك لإعادة تعيين كلمة المرور';
	@override String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';
	@override String get resetPasswordSubtitle => 'أنشئ كلمة مرور جديدة لحسابك';
	@override String get passwordResetSuccess => 'تم إعادة تعيين كلمة المرور بنجاح';
	@override String get newToMentorX => 'جديد على منتور إكس؟';
	@override String get createAccount => 'إنشاء حساب';
	@override String get backToLogin => 'العودة لتسجيل الدخول';
	@override String get otpTitle => 'تحقق من رقمك';
	@override String get otpSubtitle => 'أدخل الرمز المرسل إلى جوالك';
	@override String get otpFieldLabel => 'رمز التحقق';
	@override String get otpFieldHint => 'أدخل رمز التحقق';
	@override String get otpCodeLabel => 'رمز OTP';
	@override String get verifyAndContinue => 'تحقق وتابع';
	@override String get verificationFailed => 'فشل التحقق، يرجى المحاولة مرة أخرى';
	@override String get sendVerificationCode => 'إرسال رمز التحقق';
	@override String get sendCodeFailed => 'فشل إرسال رمز التحقق';
	@override String get resendCode => 'إعادة إرسال الرمز';
	@override String resendInSeconds({required int seconds}) => 'إعادة الإرسال خلال ${seconds} ثانية';
	@override String get resending => 'جاري إعادة الإرسال...';
	@override String get updatePasswordNow => 'تحديث كلمة المرور الآن';
	@override String get passwordRecoveryHeading => 'استرداد كلمة المرور';
	@override String get validationCheckInputs => 'يرجى مراجعة البيانات المُدخلة';
	@override String get regDefaultTitle => 'تسجيل ولي الأمر';
	@override String get regLookupPhoneTab => 'بالجوال';
	@override String get regLookupCodeTab => 'بالرمز';
	@override String get regStudentCodeLabel => 'رمز الطالب';
	@override String get regStudentCodeHint => 'أدخل رمز الطالب';
	@override String get regChildPhoneLabel => 'رقم جوال الطفل';
	@override String get regChildPhoneHint => 'أدخل رقم جوال الطفل';
	@override String get regFindStudent => 'البحث عن الطالب';
	@override String get regStep1Title => 'البحث عن الطالب';
	@override String get regStep2Title => 'تأكيد الطالب';
	@override String get regStep3Title => 'إنشاء الحساب';
	@override String get regConfirmIsYourChild => 'هل هذا طفلك؟';
	@override String get regChildConfirmed => 'نعم، هذا طفلي';
	@override String get regConfirmChild => 'تأكيد';
	@override String get regFirstNameLabel => 'الاسم الأول';
	@override String get regFirstNameHint => 'أدخل اسمك الأول';
	@override String get regLastNameLabel => 'اسم العائلة';
	@override String get regLastNameHint => 'أدخل اسم عائلتك';
	@override String get regEmailLabel => 'البريد الإلكتروني';
	@override String get regEmailHint => 'أدخل بريدك الإلكتروني';
	@override String get regRelationshipLabel => 'صلة القرابة';
	@override String get regYourPhoneHint => 'أدخل رقم جوالك';
	@override String get regSecurityHint => 'معلوماتك محفوظة وخاصة وآمنة';
	@override String get regCreateAccount => 'إنشاء حساب';
	@override String get regContinue => 'متابعة';
	@override String get regPleaseWait => 'يرجى الانتظار...';
	@override String get regAlreadyHaveAccount => 'لديك حساب بالفعل؟';
	@override String get regErrorLookupEmpty => 'لم يتم العثور على طالب بهذه المعلومات';
	@override String get regErrorStudentNotFound => 'الطالب غير موجود';
	@override String get regErrorFindFailed => 'فشل البحث عن الطالب';
	@override String get regErrorFindChildFirst => 'يرجى البحث عن الطالب أولاً';
	@override String get regErrorConfirmChild => 'يرجى تأكيد الطالب';
	@override String get regErrorFirstNameShort => 'الاسم الأول قصير جداً';
	@override String get regErrorLastNameShort => 'اسم العائلة قصير جداً';
	@override String get regErrorInvalidPhone => 'رقم الجوال غير صحيح';
	@override String get regErrorInvalidEmail => 'البريد الإلكتروني غير صحيح';
	@override String get regErrorRelationshipRequired => 'صلة القرابة مطلوبة';
	@override String get regErrorPasswordWeak => 'كلمة المرور ضعيفة جداً';
	@override String get regErrorPasswordMismatch => 'كلمتا المرور غير متطابقتين';
	@override String get regErrorPhoneAlreadyExists => 'رقم الجوال مسجل مسبقاً';
	@override String get regErrorRegistrationFailed => 'فشل التسجيل، يرجى المحاولة مرة أخرى';
}

// Path: parent.children
class _TranslationsParentChildrenAr implements TranslationsParentChildrenEn {
	_TranslationsParentChildrenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get lookupEmpty => 'لا يوجد أطفال مسجلون';
}

// Path: parent.notificationCenter
class _TranslationsParentNotificationCenterAr implements TranslationsParentNotificationCenterEn {
	_TranslationsParentNotificationCenterAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإشعارات';
	@override String get read => 'مقروء';
	@override String get unread => 'غير مقروء';
	@override String get markAllRead => 'تعليم الكل كمقروء';
	@override String get markAllReadSuccess => 'تم تعليم جميع الإشعارات كمقروءة';
	@override String get markRead => 'تعليم كمقروء';
	@override String get markReadSuccess => 'تم تعليم الإشعار كمقروء';
	@override String get loadFailed => 'فشل تحميل الإشعارات';
	@override String get noNotificationsTitle => 'لا توجد إشعارات';
	@override String get noNotificationsHint => 'أنت على اطلاع بكل شيء! تحقق لاحقاً.';
	@override String get openLink => 'فتح الرابط';
	@override String get detailsTitle => 'تفاصيل الإشعار';
	@override String get receivedAt => 'وقت الاستلام';
	@override String get student => 'الطالب';
}

// Path: parent.onboarding
class _TranslationsParentOnboardingAr implements TranslationsParentOnboardingEn {
	_TranslationsParentOnboardingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get slide1Title => 'تابع تقدم طفلك';
	@override String get slide1Description => 'احصل على تحديثات فورية حول الأداء الأكاديمي لطفلك وحضوره وأنشطته';
	@override String get slide2Title => 'ابقَ على تواصل';
	@override String get slide2Description => 'تواصل مع المعلمين واستقبل الإعلانات المهمة مباشرةً';
	@override String get slide3Title => 'أدر شؤونك المالية بسهولة';
	@override String get slide3Description => 'راقب رصيد المحفظة والمعاملات والنشاط المالي من مكان واحد';
	@override String get getStarted => 'ابدأ الآن';
	@override String get skip => 'تخطي';
}

// Path: parent.pushNotifications
class _TranslationsParentPushNotificationsAr implements TranslationsParentPushNotificationsEn {
	_TranslationsParentPushNotificationsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get bannerOpen => 'فتح';
	@override String get bannerDismiss => 'تجاهل';
}

// Path: parent.splash
class _TranslationsParentSplashAr implements TranslationsParentSplashEn {
	_TranslationsParentSplashAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get appName => 'منتور إكس';
	@override String get tagline => 'نمكّن كل متعلم';
}

// Path: parent.home
class _TranslationsParentHomeAr implements TranslationsParentHomeEn {
	_TranslationsParentHomeAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get academicStanding => 'الوضع الأكاديمي';
	@override String get addChild => 'إضافة طفل';
	@override String get attendance => 'الحضور';
	@override String get avgGrade => 'متوسط الدرجات';
	@override String get linkChild => 'ربط طفل';
	@override String get noChildrenHint => 'قم بربط حساب طالب للبدء';
	@override String get noChildrenTitle => 'لا يوجد أطفال بعد';
	@override String get noRecentActivity => 'لا يوجد نشاط حديث';
	@override String get noRecentActivityHint => 'ستظهر هنا أنشطة طفلك التعليمية';
	@override String get noRecentGrades => 'لا توجد درجات حديثة';
	@override String get noUpcomingSessions => 'لا توجد جلسات قادمة';
	@override String get parentAccount => 'حساب ولي الأمر';
	@override String get recentGrades => 'الدرجات الأخيرة';
	@override String get unpaidFees => 'رسوم غير مدفوعة';
	@override String get upcomingSessions => 'الجلسات القادمة';
	@override String updatedAt({required Object time}) => 'تم التحديث في ${time}';
}

// Path: parent.academic
class _TranslationsParentAcademicAr implements TranslationsParentAcademicEn {
	_TranslationsParentAcademicAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get averageLabel => 'المتوسط';
	@override String get gradedLabel => 'تم التقييم';
	@override String get noCoursesHint => 'لم يتم العثور على مواد مسجلة لهذا الطفل';
	@override String get noCoursesTitle => 'لا توجد مواد';
	@override String get overallAverageHeading => 'المعدل العام';
	@override String get pageTitle => 'المراقب الأكاديمي';
	@override String get pendingLabel => 'قيد الانتظار';
	@override String sessionsCount({required int count}) => '${count} جلسات';
}

// Path: parent.assessments
class _TranslationsParentAssessmentsAr implements TranslationsParentAssessmentsEn {
	_TranslationsParentAssessmentsAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get assessmentHistory => 'سجل التقييمات';
	@override String get average => 'المتوسط';
	@override String get graded => 'تم التقييم';
	@override String get noAssessmentsHint => 'لم يتم إكمال أي تقييمات بعد';
	@override String get noAssessmentsTitle => 'لا توجد تقييمات';
	@override String get overallPerformance => 'الأداء العام';
	@override String get pageTitle => 'مراقب الدرجات';
	@override String get pending => 'قيد الانتظار';
	@override String get quizPrefix => 'اختبار:';
	@override String scoreLabel({required Object score, required Object total}) => '${score}/${total}';
}

// Path: parent.gradeDetail
class _TranslationsParentGradeDetailAr implements TranslationsParentGradeDetailEn {
	_TranslationsParentGradeDetailAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get additionalDetails => 'تفاصيل إضافية';
	@override String get assessmentInfo => 'معلومات التقييم';
	@override String get correctAnswer => 'الإجابة الصحيحة';
	@override String get fail => 'راسب';
	@override String get incorrectAnswer => 'إجابة خاطئة';
	@override String get notFound => 'التقييم غير موجود';
	@override String get pageTitle => 'تفاصيل الدرجة';
	@override String get pass => 'ناجح';
	@override String get passCriteria => 'معيار النجاح';
	@override String get percentage => 'النسبة المئوية';
	@override String get questionBreakdown => 'تفصيل الأسئلة';
	@override String questionLabel({required Object number}) => 'السؤال ${number}';
	@override String get quizDetail => 'تفاصيل الاختبار';
	@override String get quizId => 'رقم الاختبار';
	@override String get quizScore => 'درجة الاختبار';
	@override String get result => 'النتيجة';
	@override String get score => 'الدرجة';
	@override String get submittedAt => 'وقت التسليم';
}

// Path: parent.attendanceTracking
class _TranslationsParentAttendanceTrackingAr implements TranslationsParentAttendanceTrackingEn {
	_TranslationsParentAttendanceTrackingAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get absent => 'غائب';
	@override String get attendanceLog => 'سجل الحضور';
	@override String checkInTimeLabel({required Object time}) => 'وقت الحضور: ${time}';
	@override String get dayFriday => 'الجمعة';
	@override String get dayMonday => 'الاثنين';
	@override String get daySaturday => 'السبت';
	@override String get daySunday => 'الأحد';
	@override String get dayThursday => 'الخميس';
	@override String get dayTuesday => 'الثلاثاء';
	@override String get dayWednesday => 'الأربعاء';
	@override String get excused => 'إذن';
	@override String get generalAcademic => 'أكاديمي عام';
	@override String get groupActiveBadge => 'نشط';
	@override String get groupAttendanceRatioLabel => 'نسبة الحضور';
	@override String get groupAttendanceTitle => 'ملخص الحضور';
	@override String groupAttendedSessions({required int count}) => '${count} حضر';
	@override String get groupCourseLabel => 'المادة';
	@override String get groupDescriptionLabel => 'الوصف';
	@override String get groupDetailTitle => 'تفاصيل المجموعة';
	@override String groupEndDateLabel({required Object date}) => 'الانتهاء: ${date}';
	@override String groupEnrolledLabel({required int count}) => '${count} مسجل';
	@override String get groupFailureTitle => 'فشل تحميل المجموعة';
	@override String get groupInactiveBadge => 'غير نشط';
	@override String groupLateSessions({required int count}) => '${count} تأخر';
	@override String get groupLocationLabel => 'الموقع';
	@override String groupMissedSessions({required int count}) => '${count} غياب';
	@override String get groupNoSchedule => 'لا يوجد جدول';
	@override String get groupNotFoundHint => 'تعذر العثور على مجموعة الحضور';
	@override String get groupNotFoundTitle => 'المجموعة غير موجودة';
	@override String get groupRecentSessionsTitle => 'الجلسات الأخيرة';
	@override String get groupScheduleTitle => 'الجدول';
	@override String groupSessionRoomLabel({required Object room}) => 'القاعة: ${room}';
	@override String groupStartDateLabel({required Object date}) => 'البداية: ${date}';
	@override String get groupTeacherLabel => 'المعلم';
	@override String groupTotalSessions({required int count}) => '${count} جلسات إجمالاً';
	@override String get groupsAction => 'المجموعات';
	@override String get groupsEmptyHint => 'لا توجد مجموعات حضور';
	@override String get groupsEmptyTitle => 'لا توجد مجموعات';
	@override String get groupsHint => 'استعرض مجموعات حضور طفلك';
	@override String get groupsTitle => 'مجموعات الحضور';
	@override String get late => 'متأخر';
	@override String get noRecordsHint => 'لا توجد سجلات حضور لهذه الفترة';
	@override String get noRecordsTitle => 'لا توجد سجلات';
	@override String get onlineSession => 'أونلاين';
	@override String get pageTitle => 'مراقب الحضور';
	@override String get present => 'حاضر';
	@override String get regularSession => 'جلسة عادية';
}

// Path: parent.financial
class _TranslationsParentFinancialAr implements TranslationsParentFinancialEn {
	_TranslationsParentFinancialAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get balance => 'الرصيد';
	@override String get creditsThisMonth => 'الإيداعات هذا الشهر';
	@override String get currencySymbol => 'ج.م';
	@override String get myWalletBalanceLabel => 'رصيد المحفظة';
	@override String get myWalletTitle => 'محفظتي';
	@override String get noTransactionsHint => 'لم تتم أي معاملات بعد';
	@override String get noTransactionsTitle => 'لا توجد معاملات';
	@override String get points => 'النقاط';
	@override String get spent => 'المصروف';
	@override String get topUpAction => 'شحن الرصيد';
	@override String get topUpAmountHint => 'أدخل المبلغ';
	@override String get topUpAmountLabel => 'المبلغ';
	@override String get topUpBelowMinimum => 'المبلغ أقل من الحد الأدنى';
	@override String get topUpFailed => 'فشل شحن الرصيد، يرجى المحاولة مرة أخرى';
	@override String get topUpHint => 'أضف أموالاً لمحفظة طفلك';
	@override String get topUpInsufficientFunds => 'رصيد غير كافٍ';
	@override String get topUpInvalidAmount => 'مبلغ غير صحيح';
	@override String get topUpSuccess => 'تم شحن المحفظة بنجاح';
	@override String get topUpTitle => 'شحن المحفظة';
	@override String get transactionsTitle => 'سجل المعاملات';
}

// Path: parent.courseDetail
class _TranslationsParentCourseDetailAr implements TranslationsParentCourseDetailEn {
	_TranslationsParentCourseDetailAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get courseBreakdown => 'تفصيل المادة';
	@override String get courseId => 'رقم المادة';
	@override String get descriptionLabel => 'الوصف';
	@override String get emptyHint => 'لا تتوفر بيانات للمادة';
	@override String get emptyTitle => 'لا توجد مواد';
	@override String enrolledCount({required int count}) => '${count} مسجل';
	@override String get failureTitle => 'فشل تحميل المادة';
	@override String get fullTitle => 'المادة الكاملة';
	@override String get pageTitle => 'تفاصيل المادة';
	@override String get progress => 'التقدم';
	@override String get status => 'الحالة';
	@override String get statusActive => 'نشطة';
	@override String get statusCompleted => 'مكتملة';
	@override String get statusInProgress => 'قيد التقدم';
	@override String get statusLabel => 'حالة المادة';
}

// Path: parent.communication
class _TranslationsParentCommunicationAr implements TranslationsParentCommunicationEn {
	_TranslationsParentCommunicationAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get announcementsTitle => 'الإعلانات';
	@override String get groupSubtitle => 'انضم لمجموعة واتساب طفلك';
	@override String get joinGroup => 'انضم للمجموعة';
	@override String get noAnnouncementsHint => 'لا توجد إعلانات في الوقت الحالي';
	@override String get noAnnouncementsTitle => 'لا توجد إعلانات';
	@override String get noGroupsHint => 'لا توجد مجموعات واتساب متاحة';
	@override String get noGroupsTitle => 'لا توجد مجموعات';
	@override String get readMore => 'اقرأ المزيد';
	@override String get whatsAppTitle => 'مجموعات واتساب';
}

// Path: parent.analytics
class _TranslationsParentAnalyticsAr implements TranslationsParentAnalyticsEn {
	_TranslationsParentAnalyticsAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String averagePerDay({required Object minutes}) => '${minutes} دقيقة/يوم';
	@override String averageQuizSpeed({required Object seconds}) => '${seconds} ث متوسط';
	@override String get childAverageLabel => 'متوسط الطفل';
	@override String get classAverageLabel => 'متوسط الفصل';
	@override String completedSessionsLabel({required int completed, required int total}) => '${completed}/${total} جلسات';
	@override String get currentStreak => 'السلسلة الحالية';
	@override String get emptySectionHint => 'لا تتوفر بيانات لهذا القسم';
	@override String get emptySectionTitle => 'لا توجد بيانات';
	@override String get errorRetry => 'إعادة المحاولة';
	@override String lastActive({required Object time}) => 'آخر نشاط: ${time}';
	@override String get loadFailed => 'فشل تحميل التحليلات';
	@override String get longestStreak => 'أطول سلسلة';
	@override String get pageTitle => 'التحليلات';
	@override String quizCountLabel({required int count}) => '${count} اختبارات';
	@override String rankLabel({required int rank, required int total}) => '#${rank} من ${total}';
	@override String get sectionAchievements => 'الإنجازات';
	@override String get sectionActiveHours => 'ساعات النشاط';
	@override String get sectionCourseProgress => 'تقدم المواد';
	@override String get sectionGradeComparison => 'مقارنة الدرجات';
	@override String get sectionQuizSpeed => 'سرعة الاختبارات';
	@override String get sectionStreak => 'السلسلة';
	@override String streakDays({required int days}) => '${days} أيام';
	@override String totalMinutes({required int minutes}) => '${minutes} دقيقة إجمالاً';
	@override String get unauthorized => 'غير مصرح لك بعرض هذا';
	@override String unlockedCount({required int unlocked}) => '${unlocked} مفتوح';
}

// Path: parent.quickActions
class _TranslationsParentQuickActionsAr implements TranslationsParentQuickActionsEn {
	_TranslationsParentQuickActionsAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get announcements => 'الإعلانات';
	@override String get attendance => 'الحضور';
	@override String get courses => 'المواد';
	@override String get fees => 'الرسوم';
	@override String get grades => 'الدرجات';
	@override String get messages => 'الرسائل';
}

// Path: parent.profile
class _TranslationsParentProfileAr implements TranslationsParentProfileEn {
	_TranslationsParentProfileAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get aboutTitle => 'حول';
	@override String aboutVersion({required Object version}) => 'v${version}';
	@override String get appConfigurationSection => 'إعدادات التطبيق';
	@override String get appLanguage => 'اللغة';
	@override String get avatarChangeAction => 'تغيير الصورة';
	@override String get avatarInvalidImage => 'صيغة الصورة غير صحيحة';
	@override String get avatarPickFromGallery => 'اختر من المعرض';
	@override String get avatarTakePhoto => 'التقط صورة';
	@override String get avatarUploadFailed => 'فشل رفع الصورة';
	@override String get avatarUploading => 'جاري الرفع...';
	@override String get changePasswordAction => 'تغيير كلمة المرور';
	@override String get changePasswordConfirmLabel => 'تأكيد كلمة المرور الجديدة';
	@override String get changePasswordCurrentLabel => 'كلمة المرور الحالية';
	@override String get changePasswordCurrentRequired => 'كلمة المرور الحالية مطلوبة';
	@override String get changePasswordFailed => 'فشل تغيير كلمة المرور';
	@override String get changePasswordHint => 'اختر كلمة مرور قوية للحفاظ على أمان حسابك';
	@override String get changePasswordMismatch => 'كلمتا المرور الجديدتان غير متطابقتين';
	@override String get changePasswordNewLabel => 'كلمة المرور الجديدة';
	@override String get changePasswordSuccess => 'تم تغيير كلمة المرور بنجاح';
	@override String get changePasswordTitle => 'تغيير كلمة المرور';
	@override String get changePasswordTooWeak => 'كلمة المرور ضعيفة جداً';
	@override String get changePasswordWrongCurrent => 'كلمة المرور الحالية غير صحيحة';
	@override String get editFullNameHint => 'أدخل اسمك الكامل';
	@override String get editFullNameLabel => 'الاسم الكامل';
	@override String get editFullNameTooShort => 'الاسم قصير جداً';
	@override String get editLoadFailed => 'فشل تحميل الملف الشخصي';
	@override String get editNetworkError => 'خطأ في الشبكة، يرجى المحاولة مرة أخرى';
	@override String get editSaveAction => 'حفظ';
	@override String get editSaveFailed => 'فشل حفظ التغييرات';
	@override String get editSaveSuccess => 'تم تحديث الملف الشخصي بنجاح';
	@override String get editTitle => 'تعديل الملف الشخصي';
	@override String get editUnauthorized => 'غير مصرح لك بتعديل هذا الملف الشخصي';
	@override String get emailLabel => 'البريد الإلكتروني';
	@override String get fallbackName => 'ولي الأمر';
	@override String get fullNameLabel => 'الاسم الكامل';
	@override String get helpCenter => 'مركز المساعدة';
	@override String get helpCenterValue => 'زيارة صفحة الدعم';
	@override String get languageArabic => 'العربية';
	@override String get languageEnglish => 'الإنجليزية';
	@override String get notificationsEnabled => 'الإشعارات الفورية';
	@override String get phoneNumberLabel => 'رقم الجوال';
	@override String get preferencesSection => 'التفضيلات';
	@override String get pushNotifications => 'الإشعارات الفورية';
	@override String get securityChangePassword => 'تغيير كلمة المرور';
	@override String get securityValue => 'كلمة المرور والأمان';
	@override String settingsAboutBody({required Object version}) => 'تطبيق منتور إكس لولي الأمر v${version}\n\nراقب رحلة طفلك الأكاديمية في الوقت الفعلي.';
	@override String get settingsAboutTitle => 'حول منتور إكس';
	@override String get settingsHelpUrl => 'https://mentorx.app/support';
	@override String get settingsTitle => 'الإعدادات';
	@override String get signOutAction => 'تسجيل الخروج';
	@override String get signOutCancel => 'إلغاء';
	@override String get signOutConfirmMessage => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';
	@override String get signOutConfirmTitle => 'تسجيل الخروج';
	@override String get supportSection => 'الدعم';
	@override String get themeDark => 'داكن';
	@override String get themeLight => 'فاتح';
	@override String get themeMode => 'المظهر';
	@override String get themeSystem => 'النظام';
	@override String get verifiedAccount => 'حساب موثق';
}

// Path: parent.devices
class _TranslationsParentDevicesAr implements TranslationsParentDevicesEn {
	_TranslationsParentDevicesAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get activeBadge => 'نشط';
	@override String get cancel => 'إلغاء';
	@override String get currentBadge => 'هذا الجهاز';
	@override String get emptyHint => 'لا توجد أجهزة مرتبطة بحسابك';
	@override String get emptyTitle => 'لا توجد أجهزة';
	@override String get forceLogoutAction => 'تسجيل خروج إجباري للكل';
	@override String get forceLogoutConfirmMessage => 'سيتم تسجيل خروج جميع الأجهزة الأخرى. هل تريد المتابعة؟';
	@override String get forceLogoutConfirmTitle => 'تسجيل خروج إجباري';
	@override String get forceLogoutHint => 'تسجيل خروج جميع الأجهزة الأخرى النشطة';
	@override String get forceLogoutSuccess => 'تم تسجيل خروج جميع الأجهزة الأخرى';
	@override String get forceLogoutTitle => 'تسجيل خروج إجباري';
	@override String get inactiveBadge => 'غير نشط';
	@override String lastUsedLabel({required Object time}) => 'آخر استخدام: ${time}';
	@override String get pageSubtitle => 'إدارة الأجهزة التي يمكنها الوصول لحسابك';
	@override String get pageTitle => 'الأجهزة الموثوقة';
	@override String get revokeAction => 'إلغاء الصلاحية';
	@override String get revokeConfirmMessage => 'إزالة صلاحية الوصول لهذا الجهاز؟';
	@override String get revokeConfirmTitle => 'إلغاء صلاحية الجهاز';
	@override String get revokeSuccess => 'تم إلغاء صلاحية الجهاز';
	@override String get settingsSubtitle => 'إدارة الأجهزة الموثوقة';
}

// Path: parent.deleteAccount
class _TranslationsParentDeleteAccountAr implements TranslationsParentDeleteAccountEn {
	_TranslationsParentDeleteAccountAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get acknowledgementLabel => 'أفهم أن هذا الإجراء دائم';
	@override String get cancel => 'إلغاء';
	@override String get confirmAction => 'حذف حسابي';
	@override String get confirmationPhrase => 'حذف';
	@override String confirmationPrompt({required Object phrase}) => 'اكتب "${phrase}" للتأكيد';
	@override String get consequence => 'سيتم حذف جميع بياناتك بما فيها الملف الشخصي والسجل والحسابات المرتبطة بشكل دائم';
	@override String get consequencesTitle => 'ما سيتم حذفه';
	@override String get dataExportHint => 'يمكنك طلب نسخة من بياناتك قبل الحذف';
	@override String get dataExportLabel => 'تصدير بياناتي';
	@override String get finalConfirmMessage => 'سيتم حذف حسابك نهائياً خلال 24 ساعة. لا يمكن التراجع عن هذا الإجراء.';
	@override String get finalConfirmTitle => 'التأكيد النهائي';
	@override String get networkError => 'خطأ في الشبكة، يرجى المحاولة مرة أخرى';
	@override String get pageTitle => 'حذف الحساب';
	@override String get reasonHint => 'أخبرنا لماذا تغادر (اختياري)';
	@override String get reasonLabel => 'سبب الحذف';
	@override String get settingsTileLabel => 'حذف الحساب';
	@override String get settingsTileSubtitle => 'إزالة حسابك بشكل دائم';
	@override String get submitting => 'جاري معالجة طلبك...';
	@override String get successMessage => 'تم تقديم طلب حذف حسابك';
	@override String get unauthorizedError => 'غير مصرح لك بتنفيذ هذا الإجراء';
	@override String get unknownError => 'حدث خطأ غير معروف';
	@override String get validationError => 'يرجى إكمال جميع الحقول المطلوبة';
	@override String get warningSubtitle => 'هذا الإجراء دائم ولا يمكن التراجع عنه';
	@override String get warningTitle => 'تحذير';
}

// Path: parent.pendingAccount
class _TranslationsParentPendingAccountAr implements TranslationsParentPendingAccountEn {
	_TranslationsParentPendingAccountAr._(this._root);
	final TranslationsAr _root; // ignore: unused_field
	@override String get approvedToastMessage => 'تمت الموافقة على حسابك!';
	@override String get cancel => 'إلغاء';
	@override String get checkAgain => 'التحقق من الحالة';
	@override String get checking => 'جاري التحقق...';
	@override String get contactSupport => 'التواصل مع الدعم';
	@override String get contactSupportHint => 'إذا كان لديك أسئلة، تواصل مع فريق الدعم';
	@override String estimatedReviewBy({required Object date}) => 'المراجعة المتوقعة بحلول: ${date}';
	@override String get headlinePending => 'الحساب قيد المراجعة';
	@override String get headlineRejected => 'لم يتم الموافقة على الحساب';
	@override String get loadErrorMessage => 'فشل تحميل حالة الحساب';
	@override String get loadErrorTitle => 'خطأ';
	@override String get pageTitle => 'حالة الحساب';
	@override String get rejectionReasonTitle => 'السبب';
	@override String get signOut => 'تسجيل الخروج';
	@override String get signOutConfirmMessage => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';
	@override String get signOutConfirmTitle => 'تسجيل الخروج';
	@override String get statusBadgePending => 'قيد الانتظار';
	@override String get statusBadgeRejected => 'مرفوض';
	@override String get stepApproved => 'تمت الموافقة';
	@override String get stepApprovedHint => 'حسابك نشط';
	@override String get stepReceived => 'تم استلام الطلب';
	@override String get stepReceivedHint => 'لقد استلمنا طلب تسجيلك';
	@override String get stepUnderReview => 'قيد المراجعة';
	@override String get stepUnderReviewHint => 'فريقنا يراجع طلبك';
	@override String submittedOn({required Object date}) => 'تم التقديم في: ${date}';
	@override String get subtitlePending => 'فريقنا يراجع تسجيلك. ستتلقى إشعاراً عند الموافقة.';
	@override String get subtitleRejected => 'لم تتم الموافقة على تسجيلك. يرجى التواصل مع الدعم للمساعدة.';
	@override String get supportLabel => 'الدعم';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.cancel' => 'إلغاء',
			'common.ok' => 'حسناً',
			'common.viewAll' => 'عرض الكل',
			'common.required' => 'مطلوب',
			'common.optional' => 'اختياري',
			'common.customization' => 'تخصيص',
			'common.skip' => 'تخطي',
			'common.next' => 'التالي',
			'common.getStarted' => 'ابدأ الآن',
			'common.backToLogin' => 'العودة لتسجيل الدخول',
			'common.noResults' => 'لم يتم العثور على نتائج',
			'common.opening' => ({required Object url}) => 'جاري فتح: ${url}',
			'common.comingSoon' => 'قريباً',
			'common.somethingWentWrong' => 'حدث خطأ ما',
			'common.retry' => 'إعادة المحاولة',
			'common.readMore' => 'اقرأ المزيد',
			'common.readLess' => 'عرض أقل',
			'widgets.announcement.pinned' => 'مثبت',
			'widgets.announcement.update' => 'تحديث',
			'widgets.attendance.rate' => 'نسبة الحضور',
			'widgets.error.title' => 'حدث خطأ ما',
			'widgets.error.retry' => 'إعادة المحاولة',
			'core.currency' => 'ج.م',
			'parent.unableToLoad' => 'تعذر التحميل',
			'parent.childWalletBalance' => 'رصيد محفظة الطفل',
			'parent.transactionHistory' => 'سجل المعاملات',
			'parent.financialMonitor' => 'المراقب المالي',
			'parent.announcements' => 'الإعلانات',
			'parent.overallAverage' => 'المعدل العام',
			'parent.noData' => 'لا توجد بيانات',
			'parent.enrolledCourses' => 'الدورات المسجلة',
			'parent.academicMonitor' => 'المراقب الأكاديمي',
			'parent.services' => 'الخدمات',
			'parent.recentActivity' => 'النشاط الأخير',
			'parent.welcomeBack' => 'مرحباً بك مجدداً',
			'parent.accountInfo' => 'معلومات الحساب',
			'parent.appSettings' => 'إعدادات التطبيق',
			'parent.notifications' => 'الإشعارات',
			'parent.security' => 'الأمان',
			'parent.signOut' => 'تسجيل الخروج',
			'parent.myProfile' => 'ملفي الشخصي',
			'parent.viewAll' => 'عرض الكل',
			'parent.auth.appName' => 'منتور إكس',
			'parent.auth.loginTagline' => 'ابقَ على تواصل مع تعليم طفلك',
			'parent.auth.signInToDashboard' => 'سجّل الدخول إلى لوحة التحكم',
			'parent.auth.phoneNumberLabel' => 'رقم الجوال',
			'parent.auth.phoneNumberHint' => 'أدخل رقم جوالك',
			'parent.auth.phoneRequired' => 'رقم الجوال مطلوب',
			'parent.auth.passwordLabel' => 'كلمة المرور',
			'parent.auth.passwordPlaceholder' => 'أدخل كلمة المرور',
			'parent.auth.passwordRequired' => 'كلمة المرور مطلوبة',
			'parent.auth.confirmPasswordLabel' => 'تأكيد كلمة المرور',
			'parent.auth.newPasswordLabel' => 'كلمة المرور الجديدة',
			'parent.auth.loginFailed' => 'فشل تسجيل الدخول، يرجى المحاولة مرة أخرى',
			'parent.auth.forgotPassword' => 'نسيت كلمة المرور؟',
			'parent.auth.forgotPasswordTitle' => 'نسيت كلمة المرور',
			'parent.auth.forgotPasswordSubtitle' => 'أدخل رقم جوالك لإعادة تعيين كلمة المرور',
			'parent.auth.resetPasswordTitle' => 'إعادة تعيين كلمة المرور',
			'parent.auth.resetPasswordSubtitle' => 'أنشئ كلمة مرور جديدة لحسابك',
			'parent.auth.passwordResetSuccess' => 'تم إعادة تعيين كلمة المرور بنجاح',
			'parent.auth.newToMentorX' => 'جديد على منتور إكس؟',
			'parent.auth.createAccount' => 'إنشاء حساب',
			'parent.auth.backToLogin' => 'العودة لتسجيل الدخول',
			'parent.auth.otpTitle' => 'تحقق من رقمك',
			'parent.auth.otpSubtitle' => 'أدخل الرمز المرسل إلى جوالك',
			'parent.auth.otpFieldLabel' => 'رمز التحقق',
			'parent.auth.otpFieldHint' => 'أدخل رمز التحقق',
			'parent.auth.otpCodeLabel' => 'رمز OTP',
			'parent.auth.verifyAndContinue' => 'تحقق وتابع',
			'parent.auth.verificationFailed' => 'فشل التحقق، يرجى المحاولة مرة أخرى',
			'parent.auth.sendVerificationCode' => 'إرسال رمز التحقق',
			'parent.auth.sendCodeFailed' => 'فشل إرسال رمز التحقق',
			'parent.auth.resendCode' => 'إعادة إرسال الرمز',
			'parent.auth.resendInSeconds' => ({required int seconds}) => 'إعادة الإرسال خلال ${seconds} ثانية',
			'parent.auth.resending' => 'جاري إعادة الإرسال...',
			'parent.auth.updatePasswordNow' => 'تحديث كلمة المرور الآن',
			'parent.auth.passwordRecoveryHeading' => 'استرداد كلمة المرور',
			'parent.auth.validationCheckInputs' => 'يرجى مراجعة البيانات المُدخلة',
			'parent.auth.regDefaultTitle' => 'تسجيل ولي الأمر',
			'parent.auth.regLookupPhoneTab' => 'بالجوال',
			'parent.auth.regLookupCodeTab' => 'بالرمز',
			'parent.auth.regStudentCodeLabel' => 'رمز الطالب',
			'parent.auth.regStudentCodeHint' => 'أدخل رمز الطالب',
			'parent.auth.regChildPhoneLabel' => 'رقم جوال الطفل',
			'parent.auth.regChildPhoneHint' => 'أدخل رقم جوال الطفل',
			'parent.auth.regFindStudent' => 'البحث عن الطالب',
			'parent.auth.regStep1Title' => 'البحث عن الطالب',
			'parent.auth.regStep2Title' => 'تأكيد الطالب',
			'parent.auth.regStep3Title' => 'إنشاء الحساب',
			'parent.auth.regConfirmIsYourChild' => 'هل هذا طفلك؟',
			'parent.auth.regChildConfirmed' => 'نعم، هذا طفلي',
			'parent.auth.regConfirmChild' => 'تأكيد',
			'parent.auth.regFirstNameLabel' => 'الاسم الأول',
			'parent.auth.regFirstNameHint' => 'أدخل اسمك الأول',
			'parent.auth.regLastNameLabel' => 'اسم العائلة',
			'parent.auth.regLastNameHint' => 'أدخل اسم عائلتك',
			'parent.auth.regEmailLabel' => 'البريد الإلكتروني',
			'parent.auth.regEmailHint' => 'أدخل بريدك الإلكتروني',
			'parent.auth.regRelationshipLabel' => 'صلة القرابة',
			'parent.auth.regYourPhoneHint' => 'أدخل رقم جوالك',
			'parent.auth.regSecurityHint' => 'معلوماتك محفوظة وخاصة وآمنة',
			'parent.auth.regCreateAccount' => 'إنشاء حساب',
			'parent.auth.regContinue' => 'متابعة',
			'parent.auth.regPleaseWait' => 'يرجى الانتظار...',
			'parent.auth.regAlreadyHaveAccount' => 'لديك حساب بالفعل؟',
			'parent.auth.regErrorLookupEmpty' => 'لم يتم العثور على طالب بهذه المعلومات',
			'parent.auth.regErrorStudentNotFound' => 'الطالب غير موجود',
			'parent.auth.regErrorFindFailed' => 'فشل البحث عن الطالب',
			'parent.auth.regErrorFindChildFirst' => 'يرجى البحث عن الطالب أولاً',
			'parent.auth.regErrorConfirmChild' => 'يرجى تأكيد الطالب',
			'parent.auth.regErrorFirstNameShort' => 'الاسم الأول قصير جداً',
			'parent.auth.regErrorLastNameShort' => 'اسم العائلة قصير جداً',
			'parent.auth.regErrorInvalidPhone' => 'رقم الجوال غير صحيح',
			'parent.auth.regErrorInvalidEmail' => 'البريد الإلكتروني غير صحيح',
			'parent.auth.regErrorRelationshipRequired' => 'صلة القرابة مطلوبة',
			'parent.auth.regErrorPasswordWeak' => 'كلمة المرور ضعيفة جداً',
			'parent.auth.regErrorPasswordMismatch' => 'كلمتا المرور غير متطابقتين',
			'parent.auth.regErrorPhoneAlreadyExists' => 'رقم الجوال مسجل مسبقاً',
			'parent.auth.regErrorRegistrationFailed' => 'فشل التسجيل، يرجى المحاولة مرة أخرى',
			'parent.children.lookupEmpty' => 'لا يوجد أطفال مسجلون',
			'parent.notificationCenter.title' => 'الإشعارات',
			'parent.notificationCenter.read' => 'مقروء',
			'parent.notificationCenter.unread' => 'غير مقروء',
			'parent.notificationCenter.markAllRead' => 'تعليم الكل كمقروء',
			'parent.notificationCenter.markAllReadSuccess' => 'تم تعليم جميع الإشعارات كمقروءة',
			'parent.notificationCenter.markRead' => 'تعليم كمقروء',
			'parent.notificationCenter.markReadSuccess' => 'تم تعليم الإشعار كمقروء',
			'parent.notificationCenter.loadFailed' => 'فشل تحميل الإشعارات',
			'parent.notificationCenter.noNotificationsTitle' => 'لا توجد إشعارات',
			'parent.notificationCenter.noNotificationsHint' => 'أنت على اطلاع بكل شيء! تحقق لاحقاً.',
			'parent.notificationCenter.openLink' => 'فتح الرابط',
			'parent.notificationCenter.detailsTitle' => 'تفاصيل الإشعار',
			'parent.notificationCenter.receivedAt' => 'وقت الاستلام',
			'parent.notificationCenter.student' => 'الطالب',
			'parent.onboarding.slide1Title' => 'تابع تقدم طفلك',
			'parent.onboarding.slide1Description' => 'احصل على تحديثات فورية حول الأداء الأكاديمي لطفلك وحضوره وأنشطته',
			'parent.onboarding.slide2Title' => 'ابقَ على تواصل',
			'parent.onboarding.slide2Description' => 'تواصل مع المعلمين واستقبل الإعلانات المهمة مباشرةً',
			'parent.onboarding.slide3Title' => 'أدر شؤونك المالية بسهولة',
			'parent.onboarding.slide3Description' => 'راقب رصيد المحفظة والمعاملات والنشاط المالي من مكان واحد',
			'parent.onboarding.getStarted' => 'ابدأ الآن',
			'parent.onboarding.skip' => 'تخطي',
			'parent.pushNotifications.bannerOpen' => 'فتح',
			'parent.pushNotifications.bannerDismiss' => 'تجاهل',
			'forms.required' => 'هذا الحقل مطلوب',
			'forms.minLength' => ({required int length}) => 'يجب أن يحتوي على ${length} أحرف على الأقل',
			'forms.maxLength' => ({required int length}) => 'الحد الأقصى هو ${length} أحرف',
			'forms.minDigitsLength' => ({required int length}) => 'يجب أن يحتوي على ${length} أرقام على الأقل',
			'forms.maxDigitsLength' => ({required int length}) => 'الحد الأقصى هو ${length} أرقام',
			'forms.youMustEnterAValidEmail' => 'يجب إدخال بريد إلكتروني صحيح',
			'exceptions.unknown' => 'خطأ غير معروف',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'خطأ غير معروف',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'رقم الجوال غير صحيح',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'رمز OTP غير صحيح',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'فشل التحميل',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'فشل ارسال رمز ال OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'فشل التحقق من رمز ال OTP',
			'parent.splash.appName' => 'منتور إكس',
			'parent.splash.tagline' => 'نمكّن كل متعلم',
			'parent.home.academicStanding' => 'الوضع الأكاديمي',
			'parent.home.addChild' => 'إضافة طفل',
			'parent.home.attendance' => 'الحضور',
			'parent.home.avgGrade' => 'متوسط الدرجات',
			'parent.home.linkChild' => 'ربط طفل',
			'parent.home.noChildrenHint' => 'قم بربط حساب طالب للبدء',
			'parent.home.noChildrenTitle' => 'لا يوجد أطفال بعد',
			'parent.home.noRecentActivity' => 'لا يوجد نشاط حديث',
			'parent.home.noRecentActivityHint' => 'ستظهر هنا أنشطة طفلك التعليمية',
			'parent.home.noRecentGrades' => 'لا توجد درجات حديثة',
			'parent.home.noUpcomingSessions' => 'لا توجد جلسات قادمة',
			'parent.home.parentAccount' => 'حساب ولي الأمر',
			'parent.home.recentGrades' => 'الدرجات الأخيرة',
			'parent.home.unpaidFees' => 'رسوم غير مدفوعة',
			'parent.home.upcomingSessions' => 'الجلسات القادمة',
			'parent.home.updatedAt' => ({required Object time}) => 'تم التحديث في ${time}',
			'parent.academic.averageLabel' => 'المتوسط',
			'parent.academic.gradedLabel' => 'تم التقييم',
			'parent.academic.noCoursesHint' => 'لم يتم العثور على مواد مسجلة لهذا الطفل',
			'parent.academic.noCoursesTitle' => 'لا توجد مواد',
			'parent.academic.overallAverageHeading' => 'المعدل العام',
			'parent.academic.pageTitle' => 'المراقب الأكاديمي',
			'parent.academic.pendingLabel' => 'قيد الانتظار',
			'parent.academic.sessionsCount' => ({required int count}) => '${count} جلسات',
			'parent.assessments.assessmentHistory' => 'سجل التقييمات',
			'parent.assessments.average' => 'المتوسط',
			'parent.assessments.graded' => 'تم التقييم',
			'parent.assessments.noAssessmentsHint' => 'لم يتم إكمال أي تقييمات بعد',
			'parent.assessments.noAssessmentsTitle' => 'لا توجد تقييمات',
			'parent.assessments.overallPerformance' => 'الأداء العام',
			'parent.assessments.pageTitle' => 'مراقب الدرجات',
			'parent.assessments.pending' => 'قيد الانتظار',
			'parent.assessments.quizPrefix' => 'اختبار:',
			'parent.assessments.scoreLabel' => ({required Object score, required Object total}) => '${score}/${total}',
			'parent.gradeDetail.additionalDetails' => 'تفاصيل إضافية',
			'parent.gradeDetail.assessmentInfo' => 'معلومات التقييم',
			'parent.gradeDetail.correctAnswer' => 'الإجابة الصحيحة',
			'parent.gradeDetail.fail' => 'راسب',
			'parent.gradeDetail.incorrectAnswer' => 'إجابة خاطئة',
			'parent.gradeDetail.notFound' => 'التقييم غير موجود',
			'parent.gradeDetail.pageTitle' => 'تفاصيل الدرجة',
			'parent.gradeDetail.pass' => 'ناجح',
			'parent.gradeDetail.passCriteria' => 'معيار النجاح',
			'parent.gradeDetail.percentage' => 'النسبة المئوية',
			'parent.gradeDetail.questionBreakdown' => 'تفصيل الأسئلة',
			'parent.gradeDetail.questionLabel' => ({required Object number}) => 'السؤال ${number}',
			'parent.gradeDetail.quizDetail' => 'تفاصيل الاختبار',
			'parent.gradeDetail.quizId' => 'رقم الاختبار',
			'parent.gradeDetail.quizScore' => 'درجة الاختبار',
			'parent.gradeDetail.result' => 'النتيجة',
			'parent.gradeDetail.score' => 'الدرجة',
			'parent.gradeDetail.submittedAt' => 'وقت التسليم',
			'parent.attendanceTracking.absent' => 'غائب',
			'parent.attendanceTracking.attendanceLog' => 'سجل الحضور',
			'parent.attendanceTracking.checkInTimeLabel' => ({required Object time}) => 'وقت الحضور: ${time}',
			'parent.attendanceTracking.dayFriday' => 'الجمعة',
			'parent.attendanceTracking.dayMonday' => 'الاثنين',
			'parent.attendanceTracking.daySaturday' => 'السبت',
			'parent.attendanceTracking.daySunday' => 'الأحد',
			'parent.attendanceTracking.dayThursday' => 'الخميس',
			'parent.attendanceTracking.dayTuesday' => 'الثلاثاء',
			'parent.attendanceTracking.dayWednesday' => 'الأربعاء',
			'parent.attendanceTracking.excused' => 'إذن',
			'parent.attendanceTracking.generalAcademic' => 'أكاديمي عام',
			'parent.attendanceTracking.groupActiveBadge' => 'نشط',
			'parent.attendanceTracking.groupAttendanceRatioLabel' => 'نسبة الحضور',
			'parent.attendanceTracking.groupAttendanceTitle' => 'ملخص الحضور',
			'parent.attendanceTracking.groupAttendedSessions' => ({required int count}) => '${count} حضر',
			'parent.attendanceTracking.groupCourseLabel' => 'المادة',
			'parent.attendanceTracking.groupDescriptionLabel' => 'الوصف',
			'parent.attendanceTracking.groupDetailTitle' => 'تفاصيل المجموعة',
			'parent.attendanceTracking.groupEndDateLabel' => ({required Object date}) => 'الانتهاء: ${date}',
			'parent.attendanceTracking.groupEnrolledLabel' => ({required int count}) => '${count} مسجل',
			'parent.attendanceTracking.groupFailureTitle' => 'فشل تحميل المجموعة',
			'parent.attendanceTracking.groupInactiveBadge' => 'غير نشط',
			'parent.attendanceTracking.groupLateSessions' => ({required int count}) => '${count} تأخر',
			'parent.attendanceTracking.groupLocationLabel' => 'الموقع',
			'parent.attendanceTracking.groupMissedSessions' => ({required int count}) => '${count} غياب',
			'parent.attendanceTracking.groupNoSchedule' => 'لا يوجد جدول',
			'parent.attendanceTracking.groupNotFoundHint' => 'تعذر العثور على مجموعة الحضور',
			'parent.attendanceTracking.groupNotFoundTitle' => 'المجموعة غير موجودة',
			'parent.attendanceTracking.groupRecentSessionsTitle' => 'الجلسات الأخيرة',
			'parent.attendanceTracking.groupScheduleTitle' => 'الجدول',
			'parent.attendanceTracking.groupSessionRoomLabel' => ({required Object room}) => 'القاعة: ${room}',
			'parent.attendanceTracking.groupStartDateLabel' => ({required Object date}) => 'البداية: ${date}',
			'parent.attendanceTracking.groupTeacherLabel' => 'المعلم',
			'parent.attendanceTracking.groupTotalSessions' => ({required int count}) => '${count} جلسات إجمالاً',
			'parent.attendanceTracking.groupsAction' => 'المجموعات',
			'parent.attendanceTracking.groupsEmptyHint' => 'لا توجد مجموعات حضور',
			'parent.attendanceTracking.groupsEmptyTitle' => 'لا توجد مجموعات',
			'parent.attendanceTracking.groupsHint' => 'استعرض مجموعات حضور طفلك',
			'parent.attendanceTracking.groupsTitle' => 'مجموعات الحضور',
			'parent.attendanceTracking.late' => 'متأخر',
			'parent.attendanceTracking.noRecordsHint' => 'لا توجد سجلات حضور لهذه الفترة',
			'parent.attendanceTracking.noRecordsTitle' => 'لا توجد سجلات',
			'parent.attendanceTracking.onlineSession' => 'أونلاين',
			'parent.attendanceTracking.pageTitle' => 'مراقب الحضور',
			'parent.attendanceTracking.present' => 'حاضر',
			'parent.attendanceTracking.regularSession' => 'جلسة عادية',
			'parent.financial.balance' => 'الرصيد',
			'parent.financial.creditsThisMonth' => 'الإيداعات هذا الشهر',
			'parent.financial.currencySymbol' => 'ج.م',
			'parent.financial.myWalletBalanceLabel' => 'رصيد المحفظة',
			'parent.financial.myWalletTitle' => 'محفظتي',
			'parent.financial.noTransactionsHint' => 'لم تتم أي معاملات بعد',
			'parent.financial.noTransactionsTitle' => 'لا توجد معاملات',
			'parent.financial.points' => 'النقاط',
			'parent.financial.spent' => 'المصروف',
			'parent.financial.topUpAction' => 'شحن الرصيد',
			'parent.financial.topUpAmountHint' => 'أدخل المبلغ',
			'parent.financial.topUpAmountLabel' => 'المبلغ',
			'parent.financial.topUpBelowMinimum' => 'المبلغ أقل من الحد الأدنى',
			'parent.financial.topUpFailed' => 'فشل شحن الرصيد، يرجى المحاولة مرة أخرى',
			'parent.financial.topUpHint' => 'أضف أموالاً لمحفظة طفلك',
			'parent.financial.topUpInsufficientFunds' => 'رصيد غير كافٍ',
			'parent.financial.topUpInvalidAmount' => 'مبلغ غير صحيح',
			'parent.financial.topUpSuccess' => 'تم شحن المحفظة بنجاح',
			'parent.financial.topUpTitle' => 'شحن المحفظة',
			'parent.financial.transactionsTitle' => 'سجل المعاملات',
			'parent.courseDetail.courseBreakdown' => 'تفصيل المادة',
			'parent.courseDetail.courseId' => 'رقم المادة',
			'parent.courseDetail.descriptionLabel' => 'الوصف',
			'parent.courseDetail.emptyHint' => 'لا تتوفر بيانات للمادة',
			'parent.courseDetail.emptyTitle' => 'لا توجد مواد',
			'parent.courseDetail.enrolledCount' => ({required int count}) => '${count} مسجل',
			'parent.courseDetail.failureTitle' => 'فشل تحميل المادة',
			'parent.courseDetail.fullTitle' => 'المادة الكاملة',
			'parent.courseDetail.pageTitle' => 'تفاصيل المادة',
			'parent.courseDetail.progress' => 'التقدم',
			'parent.courseDetail.status' => 'الحالة',
			'parent.courseDetail.statusActive' => 'نشطة',
			'parent.courseDetail.statusCompleted' => 'مكتملة',
			'parent.courseDetail.statusInProgress' => 'قيد التقدم',
			'parent.courseDetail.statusLabel' => 'حالة المادة',
			'parent.communication.announcementsTitle' => 'الإعلانات',
			'parent.communication.groupSubtitle' => 'انضم لمجموعة واتساب طفلك',
			'parent.communication.joinGroup' => 'انضم للمجموعة',
			'parent.communication.noAnnouncementsHint' => 'لا توجد إعلانات في الوقت الحالي',
			'parent.communication.noAnnouncementsTitle' => 'لا توجد إعلانات',
			'parent.communication.noGroupsHint' => 'لا توجد مجموعات واتساب متاحة',
			'parent.communication.noGroupsTitle' => 'لا توجد مجموعات',
			'parent.communication.readMore' => 'اقرأ المزيد',
			'parent.communication.whatsAppTitle' => 'مجموعات واتساب',
			'parent.analytics.averagePerDay' => ({required Object minutes}) => '${minutes} دقيقة/يوم',
			'parent.analytics.averageQuizSpeed' => ({required Object seconds}) => '${seconds} ث متوسط',
			'parent.analytics.childAverageLabel' => 'متوسط الطفل',
			'parent.analytics.classAverageLabel' => 'متوسط الفصل',
			'parent.analytics.completedSessionsLabel' => ({required int completed, required int total}) => '${completed}/${total} جلسات',
			'parent.analytics.currentStreak' => 'السلسلة الحالية',
			'parent.analytics.emptySectionHint' => 'لا تتوفر بيانات لهذا القسم',
			'parent.analytics.emptySectionTitle' => 'لا توجد بيانات',
			'parent.analytics.errorRetry' => 'إعادة المحاولة',
			'parent.analytics.lastActive' => ({required Object time}) => 'آخر نشاط: ${time}',
			'parent.analytics.loadFailed' => 'فشل تحميل التحليلات',
			'parent.analytics.longestStreak' => 'أطول سلسلة',
			'parent.analytics.pageTitle' => 'التحليلات',
			'parent.analytics.quizCountLabel' => ({required int count}) => '${count} اختبارات',
			'parent.analytics.rankLabel' => ({required int rank, required int total}) => '#${rank} من ${total}',
			'parent.analytics.sectionAchievements' => 'الإنجازات',
			'parent.analytics.sectionActiveHours' => 'ساعات النشاط',
			'parent.analytics.sectionCourseProgress' => 'تقدم المواد',
			'parent.analytics.sectionGradeComparison' => 'مقارنة الدرجات',
			'parent.analytics.sectionQuizSpeed' => 'سرعة الاختبارات',
			'parent.analytics.sectionStreak' => 'السلسلة',
			'parent.analytics.streakDays' => ({required int days}) => '${days} أيام',
			'parent.analytics.totalMinutes' => ({required int minutes}) => '${minutes} دقيقة إجمالاً',
			'parent.analytics.unauthorized' => 'غير مصرح لك بعرض هذا',
			'parent.analytics.unlockedCount' => ({required int unlocked}) => '${unlocked} مفتوح',
			'parent.quickActions.announcements' => 'الإعلانات',
			'parent.quickActions.attendance' => 'الحضور',
			'parent.quickActions.courses' => 'المواد',
			'parent.quickActions.fees' => 'الرسوم',
			'parent.quickActions.grades' => 'الدرجات',
			'parent.quickActions.messages' => 'الرسائل',
			'parent.profile.aboutTitle' => 'حول',
			'parent.profile.aboutVersion' => ({required Object version}) => 'v${version}',
			'parent.profile.appConfigurationSection' => 'إعدادات التطبيق',
			'parent.profile.appLanguage' => 'اللغة',
			'parent.profile.avatarChangeAction' => 'تغيير الصورة',
			'parent.profile.avatarInvalidImage' => 'صيغة الصورة غير صحيحة',
			'parent.profile.avatarPickFromGallery' => 'اختر من المعرض',
			'parent.profile.avatarTakePhoto' => 'التقط صورة',
			'parent.profile.avatarUploadFailed' => 'فشل رفع الصورة',
			'parent.profile.avatarUploading' => 'جاري الرفع...',
			'parent.profile.changePasswordAction' => 'تغيير كلمة المرور',
			'parent.profile.changePasswordConfirmLabel' => 'تأكيد كلمة المرور الجديدة',
			'parent.profile.changePasswordCurrentLabel' => 'كلمة المرور الحالية',
			'parent.profile.changePasswordCurrentRequired' => 'كلمة المرور الحالية مطلوبة',
			'parent.profile.changePasswordFailed' => 'فشل تغيير كلمة المرور',
			'parent.profile.changePasswordHint' => 'اختر كلمة مرور قوية للحفاظ على أمان حسابك',
			'parent.profile.changePasswordMismatch' => 'كلمتا المرور الجديدتان غير متطابقتين',
			'parent.profile.changePasswordNewLabel' => 'كلمة المرور الجديدة',
			'parent.profile.changePasswordSuccess' => 'تم تغيير كلمة المرور بنجاح',
			'parent.profile.changePasswordTitle' => 'تغيير كلمة المرور',
			'parent.profile.changePasswordTooWeak' => 'كلمة المرور ضعيفة جداً',
			'parent.profile.changePasswordWrongCurrent' => 'كلمة المرور الحالية غير صحيحة',
			'parent.profile.editFullNameHint' => 'أدخل اسمك الكامل',
			'parent.profile.editFullNameLabel' => 'الاسم الكامل',
			'parent.profile.editFullNameTooShort' => 'الاسم قصير جداً',
			'parent.profile.editLoadFailed' => 'فشل تحميل الملف الشخصي',
			'parent.profile.editNetworkError' => 'خطأ في الشبكة، يرجى المحاولة مرة أخرى',
			'parent.profile.editSaveAction' => 'حفظ',
			'parent.profile.editSaveFailed' => 'فشل حفظ التغييرات',
			'parent.profile.editSaveSuccess' => 'تم تحديث الملف الشخصي بنجاح',
			'parent.profile.editTitle' => 'تعديل الملف الشخصي',
			'parent.profile.editUnauthorized' => 'غير مصرح لك بتعديل هذا الملف الشخصي',
			'parent.profile.emailLabel' => 'البريد الإلكتروني',
			'parent.profile.fallbackName' => 'ولي الأمر',
			'parent.profile.fullNameLabel' => 'الاسم الكامل',
			'parent.profile.helpCenter' => 'مركز المساعدة',
			'parent.profile.helpCenterValue' => 'زيارة صفحة الدعم',
			'parent.profile.languageArabic' => 'العربية',
			'parent.profile.languageEnglish' => 'الإنجليزية',
			'parent.profile.notificationsEnabled' => 'الإشعارات الفورية',
			'parent.profile.phoneNumberLabel' => 'رقم الجوال',
			'parent.profile.preferencesSection' => 'التفضيلات',
			'parent.profile.pushNotifications' => 'الإشعارات الفورية',
			'parent.profile.securityChangePassword' => 'تغيير كلمة المرور',
			'parent.profile.securityValue' => 'كلمة المرور والأمان',
			'parent.profile.settingsAboutBody' => ({required Object version}) => 'تطبيق منتور إكس لولي الأمر v${version}\n\nراقب رحلة طفلك الأكاديمية في الوقت الفعلي.',
			'parent.profile.settingsAboutTitle' => 'حول منتور إكس',
			'parent.profile.settingsHelpUrl' => 'https://mentorx.app/support',
			'parent.profile.settingsTitle' => 'الإعدادات',
			'parent.profile.signOutAction' => 'تسجيل الخروج',
			'parent.profile.signOutCancel' => 'إلغاء',
			'parent.profile.signOutConfirmMessage' => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
			'parent.profile.signOutConfirmTitle' => 'تسجيل الخروج',
			'parent.profile.supportSection' => 'الدعم',
			'parent.profile.themeDark' => 'داكن',
			'parent.profile.themeLight' => 'فاتح',
			'parent.profile.themeMode' => 'المظهر',
			'parent.profile.themeSystem' => 'النظام',
			'parent.profile.verifiedAccount' => 'حساب موثق',
			'parent.devices.activeBadge' => 'نشط',
			'parent.devices.cancel' => 'إلغاء',
			'parent.devices.currentBadge' => 'هذا الجهاز',
			'parent.devices.emptyHint' => 'لا توجد أجهزة مرتبطة بحسابك',
			'parent.devices.emptyTitle' => 'لا توجد أجهزة',
			'parent.devices.forceLogoutAction' => 'تسجيل خروج إجباري للكل',
			'parent.devices.forceLogoutConfirmMessage' => 'سيتم تسجيل خروج جميع الأجهزة الأخرى. هل تريد المتابعة؟',
			'parent.devices.forceLogoutConfirmTitle' => 'تسجيل خروج إجباري',
			'parent.devices.forceLogoutHint' => 'تسجيل خروج جميع الأجهزة الأخرى النشطة',
			'parent.devices.forceLogoutSuccess' => 'تم تسجيل خروج جميع الأجهزة الأخرى',
			'parent.devices.forceLogoutTitle' => 'تسجيل خروج إجباري',
			'parent.devices.inactiveBadge' => 'غير نشط',
			'parent.devices.lastUsedLabel' => ({required Object time}) => 'آخر استخدام: ${time}',
			'parent.devices.pageSubtitle' => 'إدارة الأجهزة التي يمكنها الوصول لحسابك',
			'parent.devices.pageTitle' => 'الأجهزة الموثوقة',
			'parent.devices.revokeAction' => 'إلغاء الصلاحية',
			'parent.devices.revokeConfirmMessage' => 'إزالة صلاحية الوصول لهذا الجهاز؟',
			'parent.devices.revokeConfirmTitle' => 'إلغاء صلاحية الجهاز',
			'parent.devices.revokeSuccess' => 'تم إلغاء صلاحية الجهاز',
			'parent.devices.settingsSubtitle' => 'إدارة الأجهزة الموثوقة',
			'parent.deleteAccount.acknowledgementLabel' => 'أفهم أن هذا الإجراء دائم',
			'parent.deleteAccount.cancel' => 'إلغاء',
			'parent.deleteAccount.confirmAction' => 'حذف حسابي',
			'parent.deleteAccount.confirmationPhrase' => 'حذف',
			'parent.deleteAccount.confirmationPrompt' => ({required Object phrase}) => 'اكتب "${phrase}" للتأكيد',
			'parent.deleteAccount.consequence' => 'سيتم حذف جميع بياناتك بما فيها الملف الشخصي والسجل والحسابات المرتبطة بشكل دائم',
			'parent.deleteAccount.consequencesTitle' => 'ما سيتم حذفه',
			'parent.deleteAccount.dataExportHint' => 'يمكنك طلب نسخة من بياناتك قبل الحذف',
			'parent.deleteAccount.dataExportLabel' => 'تصدير بياناتي',
			'parent.deleteAccount.finalConfirmMessage' => 'سيتم حذف حسابك نهائياً خلال 24 ساعة. لا يمكن التراجع عن هذا الإجراء.',
			'parent.deleteAccount.finalConfirmTitle' => 'التأكيد النهائي',
			'parent.deleteAccount.networkError' => 'خطأ في الشبكة، يرجى المحاولة مرة أخرى',
			'parent.deleteAccount.pageTitle' => 'حذف الحساب',
			'parent.deleteAccount.reasonHint' => 'أخبرنا لماذا تغادر (اختياري)',
			'parent.deleteAccount.reasonLabel' => 'سبب الحذف',
			'parent.deleteAccount.settingsTileLabel' => 'حذف الحساب',
			'parent.deleteAccount.settingsTileSubtitle' => 'إزالة حسابك بشكل دائم',
			'parent.deleteAccount.submitting' => 'جاري معالجة طلبك...',
			'parent.deleteAccount.successMessage' => 'تم تقديم طلب حذف حسابك',
			'parent.deleteAccount.unauthorizedError' => 'غير مصرح لك بتنفيذ هذا الإجراء',
			'parent.deleteAccount.unknownError' => 'حدث خطأ غير معروف',
			'parent.deleteAccount.validationError' => 'يرجى إكمال جميع الحقول المطلوبة',
			'parent.deleteAccount.warningSubtitle' => 'هذا الإجراء دائم ولا يمكن التراجع عنه',
			'parent.deleteAccount.warningTitle' => 'تحذير',
			'parent.pendingAccount.approvedToastMessage' => 'تمت الموافقة على حسابك!',
			'parent.pendingAccount.cancel' => 'إلغاء',
			'parent.pendingAccount.checkAgain' => 'التحقق من الحالة',
			'parent.pendingAccount.checking' => 'جاري التحقق...',
			'parent.pendingAccount.contactSupport' => 'التواصل مع الدعم',
			'parent.pendingAccount.contactSupportHint' => 'إذا كان لديك أسئلة، تواصل مع فريق الدعم',
			'parent.pendingAccount.estimatedReviewBy' => ({required Object date}) => 'المراجعة المتوقعة بحلول: ${date}',
			'parent.pendingAccount.headlinePending' => 'الحساب قيد المراجعة',
			'parent.pendingAccount.headlineRejected' => 'لم يتم الموافقة على الحساب',
			'parent.pendingAccount.loadErrorMessage' => 'فشل تحميل حالة الحساب',
			'parent.pendingAccount.loadErrorTitle' => 'خطأ',
			'parent.pendingAccount.pageTitle' => 'حالة الحساب',
			'parent.pendingAccount.rejectionReasonTitle' => 'السبب',
			'parent.pendingAccount.signOut' => 'تسجيل الخروج',
			'parent.pendingAccount.signOutConfirmMessage' => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
			'parent.pendingAccount.signOutConfirmTitle' => 'تسجيل الخروج',
			'parent.pendingAccount.statusBadgePending' => 'قيد الانتظار',
			'parent.pendingAccount.statusBadgeRejected' => 'مرفوض',
			'parent.pendingAccount.stepApproved' => 'تمت الموافقة',
			'parent.pendingAccount.stepApprovedHint' => 'حسابك نشط',
			'parent.pendingAccount.stepReceived' => 'تم استلام الطلب',
			'parent.pendingAccount.stepReceivedHint' => 'لقد استلمنا طلب تسجيلك',
			'parent.pendingAccount.stepUnderReview' => 'قيد المراجعة',
			'parent.pendingAccount.stepUnderReviewHint' => 'فريقنا يراجع طلبك',
			'parent.pendingAccount.submittedOn' => ({required Object date}) => 'تم التقديم في: ${date}',
			'parent.pendingAccount.subtitlePending' => 'فريقنا يراجع تسجيلك. ستتلقى إشعاراً عند الموافقة.',
			'parent.pendingAccount.subtitleRejected' => 'لم تتم الموافقة على تسجيلك. يرجى التواصل مع الدعم للمساعدة.',
			'parent.pendingAccount.supportLabel' => 'الدعم',
			_ => null,
		};
	}
}
