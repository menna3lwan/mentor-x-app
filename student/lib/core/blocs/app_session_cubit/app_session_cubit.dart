import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../app/student_app.dart';
import '../app_authentication_cubit/app_authentication_events.dart';

part 'app_session_state.dart';

final class AppSessionCubit extends Cubit<AppSessionState> {
  final EventBus eventBus;
  late final StreamSubscription _appAuthEventsStreamSubscription;

  AppSessionCubit({StudentEntity? initialUser, EventBus? eventBus})
    : eventBus = eventBus ?? appEventBus,
      super(const AppSessionState()) {
    if (initialUser != null) {
      updateUser(initialUser);
    }
    _appAuthEventsStreamSubscription = this.eventBus
        .on<AppAuthenticationEvent>()
        .listen((event) {
          if (event is AppAuthenticationUpdateEvent) {
            final user = event.user;
            if (user != null) {
              updateUser(user);
            } else {
              reset();
            }
          } else if (event is AppAuthenticationLogoutEvent) {
            reset();
          }
        });
  }

  @override
  Future<void> close() {
    _appAuthEventsStreamSubscription.cancel();
    return super.close();
  }

  void updateUser(StudentEntity user) {
    emit(
      state.copyWith(
        studentName: user.fullName,
        studentNameAr: user.fullName,
        studentCode: user.studentCode ?? '',
        phone: user.phoneNumber,
        grade: user.gradeName ?? '',
        gradeAr: user.gradeName ?? '',
        center: user.centerName ?? '',
        centerAr: user.centerName ?? '',
        school: user.schoolName ?? '',
        schoolAr: user.schoolName ?? '',
        walletBalance: user.walletBalance,
      ),
    );
  }

  void reset() {
    emit(const AppSessionState());
  }

  void updateBalance(double amount) {
    emit(state.copyWith(walletBalance: state.walletBalance + amount));
  }

  void decrementPendingAssignment() {
    if (state.pendingAssignments > 0) {
      emit(state.copyWith(pendingAssignments: state.pendingAssignments - 1));
    }
  }
}
