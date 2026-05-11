import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'verify_identity_page_event.dart';
part 'verify_identity_page_state.dart';

class VerifyIdentityPageBloc
    extends Bloc<VerifyIdentityPageEvent, VerifyIdentityPageState> {
  final StudentProfileRepository _repository;

  VerifyIdentityPageBloc({required StudentProfileRepository repository})
    : _repository = repository,
      super(const VerifyIdentityPageState()) {
    on<VerifyIdentityPageStarted>(_onStarted);
    on<VerifyIdentityPageSubmit>(_onSubmit);
  }

  Future<void> _onStarted(
    VerifyIdentityPageStarted event,
    Emitter<VerifyIdentityPageState> emit,
  ) async {
    emit(state.copyWith(status: VerifyIdentityStatus.loading));
    try {
      final verification = await _repository.getVerificationStatus();
      emit(
        state.copyWith(
          status: VerifyIdentityStatus.initial,
          verification: verification,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VerifyIdentityStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSubmit(
    VerifyIdentityPageSubmit event,
    Emitter<VerifyIdentityPageState> emit,
  ) async {
    emit(state.copyWith(status: VerifyIdentityStatus.loading));
    try {
      final verification = await _repository.verifyIdentity(event.imagePath);
      emit(
        state.copyWith(
          status: VerifyIdentityStatus.success,
          verification: verification,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VerifyIdentityStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
