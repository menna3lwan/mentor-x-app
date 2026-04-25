import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../../../app/student_app.dart';
import 'app_authentication_events.dart';

export 'app_authentication_events.dart';
export 'app_authentication_listener.dart';

final class AppAuthenticationCubit extends Cubit<StudentEntity?> {
  final StudentAuthenticationRepository _authRepository;
  final EventBus eventBus;
  late final StreamSubscription _appAuthEventsStreamSubscription;

  AppAuthenticationCubit({
    required StudentAuthenticationRepository authRepository,
    StudentEntity? initialUser,
    EventBus? eventBus,
  }) : _authRepository = authRepository,
       eventBus = eventBus ?? appEventBus,
       super(initialUser) {
    _appAuthEventsStreamSubscription = this.eventBus
        .on<AppAuthenticationEvent>()
        .listen((event) {
          if (event is AppAuthenticationUpdateEvent) {
            _updateUser(event.user);
          } else if (event is AppAuthenticationLogoutEvent) {
            _updateUser(null);
          }
        });
  }

  Future<void> logout() async {
    await _authRepository.logout();
    eventBus.fire(const AppAuthenticationLogoutEvent());
    _updateUser(null);
  }

  void _updateUser(StudentEntity? user) {
    emit(user);
  }

  @override
  Future<void> close() {
    _appAuthEventsStreamSubscription.cancel();
    return super.close();
  }
}
