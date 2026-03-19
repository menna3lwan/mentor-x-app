import 'package:parent_core/parent_core.dart';

/// Events fired on the [appEventBus] that relate to authentication state.
sealed class AppAuthenticationEvent extends Equatable {
  const AppAuthenticationEvent();

  @override
  List<Object?> get props => [];
}

/// Fired after a successful login.
final class AppUserLoggedInEvent extends AppAuthenticationEvent {
  final ParentEntity user;
  const AppUserLoggedInEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Fired after a logout.
final class AppUserLoggedOutEvent extends AppAuthenticationEvent {
  const AppUserLoggedOutEvent();
}
