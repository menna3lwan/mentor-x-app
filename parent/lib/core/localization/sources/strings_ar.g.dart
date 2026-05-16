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
	@override late final _TranslationsCoreAr core = _TranslationsCoreAr._(_root);
	@override late final _TranslationsParentAr parent = _TranslationsParentAr._(_root);
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

// Path: parent
class _TranslationsParentAr extends TranslationsParentEn {
	_TranslationsParentAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get app_name => 'مينتور إكس ولي الأمر';
	@override String get welcome => 'أهلاً بك مجدداً';
}

// Path: core.initialLanguage
class _TranslationsCoreInitialLanguageAr extends TranslationsCoreInitialLanguageEn {
	_TranslationsCoreInitialLanguageAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get header => 'يرجى تحديد اللغة المفضلة';
	@override String get kContinue => 'موافق';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
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
			'parent.app_name' => 'مينتور إكس ولي الأمر',
			'parent.welcome' => 'أهلاً بك مجدداً',
			_ => null,
		};
	}
}
