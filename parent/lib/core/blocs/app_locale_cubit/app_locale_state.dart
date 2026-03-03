part of 'app_locale_cubit.dart';

final class AppLocaleState extends Equatable {
  final String languageCode;

  const AppLocaleState({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}
