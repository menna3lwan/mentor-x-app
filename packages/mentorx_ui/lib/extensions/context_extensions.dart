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

  // Screen size
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
  bool get isTablet => width >= 600;
  bool get isDarkMode => Theme.brightnessOf(this) == Brightness.dark;

  // Platform-adaptive bottom sheet
  Future<T?> showBottomSheet<T>({
    required WidgetBuilder builder,
    bool enableDrag = true,
    bool useRootNavigator = true,
    bool isScrollControlled = true,
  }) {
    if (MentorXPlatformChecker.isIOS) {
      return showModalBottomSheet<T>(
        context: this,
        enableDrag: enableDrag,
        useRootNavigator: useRootNavigator,
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        builder: (context) => CupertinoPopupSurface(
          isSurfacePainted: true,
          child: builder(context),
        ),
      );
    } else {
      return showModalBottomSheet<T>(
        context: this,
        enableDrag: enableDrag,
        useRootNavigator: useRootNavigator,
        isScrollControlled: isScrollControlled,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: builder,
      );
    }
  }

  // Platform-adaptive alert dialog
  Future<T?> showAlertDialog<T>({
    String? title,
    String? content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    if (MentorXPlatformChecker.isIOS) {
      return showCupertinoDialog<T>(
        context: this,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: [
            if (cancelText != null)
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                },
                child: Text(cancelText),
              ),
            if (confirmText != null)
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm?.call();
                },
                child: Text(confirmText),
              ),
          ],
        ),
      );
    } else {
      return showDialog<T>(
        context: this,
        builder: (context) => AlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            if (cancelText != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                },
                child: Text(cancelText),
              ),
            if (confirmText != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm?.call();
                },
                child: Text(confirmText),
              ),
          ],
        ),
      );
    }
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: statusSuccessColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
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

  void showInfoSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
