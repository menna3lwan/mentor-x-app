import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_authentication_state.dart';

final class AppAuthenticationCubit extends Cubit<AppAuthenticationState> {
  AppAuthenticationCubit({dynamic initialUser})
      : super(AppAuthenticationState(user: initialUser));

  void update(dynamic user) {
    emit(AppAuthenticationState(user: user));
  }

  void logout() {
    emit(const AppAuthenticationState(user: null));
  }
}
