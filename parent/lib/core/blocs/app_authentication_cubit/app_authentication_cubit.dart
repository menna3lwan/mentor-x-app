import 'package:bloc/bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/events/app_global_events.dart';

part 'app_authentication_state.dart';

final class AppAuthenticationCubit extends Cubit<AppAuthenticationState> {
  AppAuthenticationCubit({ParentEntity? initialUser})
    : super(AppAuthenticationState(user: initialUser));

  static final MentorXLogger _logger = MentorXLogger('AppAuthenticationCubit');

  /// Called after a successful login to persist the authenticated user.
  void login(ParentEntity user) {
    _logger.info('User logged in: ${user.name}');
    emit(AppAuthenticationState(user: user));
    appEventBus.fire(AppRefreshEvent());
  }

  /// Called after logout to clear the user.
  void logout() {
    _logger.info('User logged out');
    emit(const AppAuthenticationState(user: null));
    appEventBus.fire(AppRefreshEvent());
  }

  /// Called to update user data (e.g. after a profile edit).
  void update(ParentEntity user) {
    emit(AppAuthenticationState(user: user));
  }

  bool get isAuthenticated => state.user != null;
}
