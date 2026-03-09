import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

final class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final StudentAuthenticationRepository _authRepository;

  LoginPageBloc({
    required StudentAuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginPageState()) {
    on<LoginPagePhoneChanged>(_onPhoneChanged);
    on<LoginPageSubmitted>(_onSubmitted);
  }

  void _onPhoneChanged(
    LoginPagePhoneChanged event,
    Emitter<LoginPageState> emit,
  ) {
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      status: LoginPageStatus.initial,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmitted(
    LoginPageSubmitted event,
    Emitter<LoginPageState> emit,
  ) async {
    if (state.phoneNumber.trim().isEmpty) return;

    emit(state.copyWith(status: LoginPageStatus.loading));

    try {
      final result = await _authRepository.sendOtp(state.phoneNumber.trim());
      emit(state.copyWith(
        status: LoginPageStatus.success,
        otpLength: result?.otpLength,
        otpDuration: result?.otpDuration,
      ));
    } on AuthenticationRepositoryException catch (e) {
      emit(state.copyWith(
        status: LoginPageStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginPageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
