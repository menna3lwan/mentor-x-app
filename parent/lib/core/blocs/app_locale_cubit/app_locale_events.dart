import 'package:equatable/equatable.dart';

/// Events fired on the [appEventBus] that relate to locale/language state.
sealed class AppLocaleEvent extends Equatable {
  const AppLocaleEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when the user changes the display language.
final class AppLocaleChangedEvent extends AppLocaleEvent {
  final String languageCode;
  const AppLocaleChangedEvent({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}
