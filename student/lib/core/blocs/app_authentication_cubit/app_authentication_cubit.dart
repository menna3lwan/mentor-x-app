import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../../../app/student_app.dart';
import 'app_authentication_events.dart';

export 'app_authentication_events.dart';
export 'app_authentication_listener.dart';

final class AppAuthenticationCubit extends Cubit<StudentEntity?> {
  final EventBus eventBus;
  late final StreamSubscription _appAuthEventsStreamSubscription;

  AppAuthenticationCubit({StudentEntity? initialUser, EventBus? eventBus})
    : eventBus = eventBus ?? appEventBus,
      super(initialUser) {
    _appAuthEventsStreamSubscription = this.eventBus
        .on<AppAuthenticationEvent>()
        .listen((event) {
          if (event is AppAuthenticationUpdateEvent) {
            _updateUser(event.user);
          }
        });
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
