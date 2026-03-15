import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_session_state.dart';

final class AppSessionCubit extends Cubit<AppSessionState> {
  AppSessionCubit() : super(const AppSessionState());

  void updateBalance(double amount) {
    emit(state.copyWith(walletBalance: state.walletBalance + amount));
  }

  void decrementPendingAssignment() {
    if (state.pendingAssignments > 0) {
      emit(state.copyWith(pendingAssignments: state.pendingAssignments - 1));
    }
  }
}
