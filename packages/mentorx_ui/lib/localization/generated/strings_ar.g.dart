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
		'unknown': 'خطأ غير معروف',
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
			'forms.required' => 'هذا الحقل مطلوب',
			'forms.minLength' => ({required int length}) => 'يجب أن يحتوي على ${length} أحرف على الأقل',
			'forms.maxLength' => ({required int length}) => 'الحد الأقصى هو ${length} أحرف',
			'forms.minDigitsLength' => ({required int length}) => 'يجب أن يحتوي على ${length} أرقام على الأقل',
			'forms.maxDigitsLength' => ({required int length}) => 'الحد الأقصى هو ${length} أرقام',
			'forms.youMustEnterAValidEmail' => 'يجب إدخال بريد إلكتروني صحيح',
			'exceptions.unknown' => 'خطأ غير معروف',
			'exceptions.AuthenticationRepositoryExceptionCode.unknown' => 'خطأ غير معروف',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidPhoneNumber' => 'رقم الجوال غير صحيح',
			'exceptions.AuthenticationRepositoryExceptionCode.invalidOTP' => 'رمز OTP غير صحيح',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToInitialize' => 'فشل التحميل',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToSendOtp' => 'فشل ارسال رمز ال OTP',
			'exceptions.AuthenticationRepositoryExceptionCode.failedToVerifyOtp' => 'فشل التحقق من رمز ال OTP',
			_ => null,
		};
	}
}
