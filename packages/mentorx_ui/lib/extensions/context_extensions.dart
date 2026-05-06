part of '../mentorx_ui.dart';

extension ContextExtensions on BuildContext {
  bool get isArabic => LocaleSettings.currentLocale.languageCode == 'ar';

  String get locale => Localizations.localeOf(this).toString();
  ui.TextDirection get directionality => Directionality.of(this);

  bool get isKeyboardOpened => MediaQuery.viewInsetsOf(this).bottom > 0;

  String get languageCode => LocaleSettings.currentLocale.languageCode;

  List<String> get supportedLocales =>
      LocaleSettings.instance.supportedLocalesRaw;

  String get nextLanguageCode {
    final supportedLocales = LocaleSettings.instance.supportedLocalesRaw;
    final currentLocaleIndex = supportedLocales.indexWhere(
      (languageCode) => languageCode == this.languageCode,
    );
    final nextLanguageCodeIndex =
        (currentLocaleIndex + 1) % supportedLocales.length;
    final nextLanguageCode = supportedLocales[nextLanguageCodeIndex];
    return nextLanguageCode;
  }

  void updateLocale([String? languageCode]) async {
    final newCode = languageCode ?? nextLanguageCode;
    await LocaleSettings.instance.setLocaleRaw(newCode);
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
