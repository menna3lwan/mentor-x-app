part of 'app_locale_cubit.dart';

@immutable
final class AppLocaleState {
  final String languageCode;

  const AppLocaleState({required this.languageCode});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLocaleState &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;
}
