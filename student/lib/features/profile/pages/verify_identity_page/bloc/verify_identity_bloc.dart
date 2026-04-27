import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

// ─── Events ──────────────────────────────────────────────────────────────────

abstract class VerifyIdentityEvent extends Equatable {
  const VerifyIdentityEvent();
  @override
  List<Object?> get props => [];
}

class VerifyIdentityStarted extends VerifyIdentityEvent {}

class VerifyIdentitySubmit extends VerifyIdentityEvent {
  final String imagePath;
  const VerifyIdentitySubmit(this.imagePath);
  @override
  List<Object?> get props => [imagePath];
}

// ─── State ───────────────────────────────────────────────────────────────────

enum VerifyIdentityStatus { initial, loading, success, error }

class VerifyIdentityState extends Equatable {
  final VerifyIdentityStatus status;
  final NationalIdVerificationEntity? verification;
  final String? errorMessage;

  const VerifyIdentityState({
    this.status = VerifyIdentityStatus.initial,
    this.verification,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, verification, errorMessage];

  VerifyIdentityState copyWith({
    VerifyIdentityStatus? status,
    NationalIdVerificationEntity? verification,
    String? errorMessage,
  }) {
    return VerifyIdentityState(
      status: status ?? this.status,
      verification: verification ?? this.verification,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ─── BLoC ────────────────────────────────────────────────────────────────────

class VerifyIdentityBloc extends Bloc<VerifyIdentityEvent, VerifyIdentityState> {
  final StudentProfileRepository _repository;

  VerifyIdentityBloc({required StudentProfileRepository repository})
      : _repository = repository,
        super(const VerifyIdentityState()) {
    on<VerifyIdentityStarted>(_onStarted);
    on<VerifyIdentitySubmit>(_onSubmit);
  }

  Future<void> _onStarted(
    VerifyIdentityStarted event,
    Emitter<VerifyIdentityState> emit,
  ) async {
    emit(state.copyWith(status: VerifyIdentityStatus.loading));
    try {
      final verification = await _repository.getVerificationStatus();
      emit(state.copyWith(
        status: VerifyIdentityStatus.initial,
        verification: verification,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VerifyIdentityStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSubmit(
    VerifyIdentitySubmit event,
    Emitter<VerifyIdentityState> emit,
  ) async {
    emit(state.copyWith(status: VerifyIdentityStatus.loading));
    try {
      final verification = await _repository.verifyIdentity(event.imagePath);
      emit(state.copyWith(
        status: VerifyIdentityStatus.success,
        verification: verification,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VerifyIdentityStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
