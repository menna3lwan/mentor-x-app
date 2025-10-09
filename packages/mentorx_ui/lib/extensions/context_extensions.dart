part of '../mentorx_ui.dart';

extension ContextExtensions on BuildContext {
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
}
