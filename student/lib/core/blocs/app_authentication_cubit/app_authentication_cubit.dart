import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import '../../../app/student_app.dart';
import 'package:error_tracking_service/error_tracking_service.dart';
import 'package:mentorx_student/core/core.dart';

export 'app_authentication_events.dart';
export 'app_authentication_listener.dart';

final class AppAuthenticationCubit extends Cubit<StudentEntity?> {
  final StudentAuthenticationRepository _authRepository;
  final AnalyticsService _analyticsService;
  final ErrorTrackingService _errorTrackingService;
  final EventBus eventBus;
  late final StreamSubscription _appAuthEventsStreamSubscription;

  AppAuthenticationCubit({
    required StudentAuthenticationRepository authRepository,
    required AnalyticsService analyticsService,
    required ErrorTrackingService errorTrackingService,
    StudentEntity? initialUser,
    EventBus? eventBus,
  }) : _authRepository = authRepository,
       _analyticsService = analyticsService,
       _errorTrackingService = errorTrackingService,
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
    _analyticsService.logEvent(name: 'logout');
    _analyticsService.setUserId(null);
    _errorTrackingService.setUserId(null);
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
