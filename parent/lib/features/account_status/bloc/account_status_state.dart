part of 'account_status_cubit.dart';

enum AccountStatusViewStatus { initial, loading, loaded, failure }

extension AccountStatusViewStatusX on AccountStatusViewStatus {
  bool get isInitial => this == AccountStatusViewStatus.initial;
  bool get isLoading => this == AccountStatusViewStatus.loading;
  bool get isLoaded => this == AccountStatusViewStatus.loaded;
  bool get isFailure => this == AccountStatusViewStatus.failure;
}

final class AccountStatusState extends Equatable {
  final AccountStatusViewStatus status;
  final ParentAccountStatusEntity entity;
  final String? errorMessage;
  final bool isRefreshing;

  const AccountStatusState({
    required this.status,
    required this.entity,
    this.errorMessage,
    this.isRefreshing = false,
  });

  factory AccountStatusState.initial() => const AccountStatusState(
        status: AccountStatusViewStatus.initial,
        entity: ParentAccountStatusEntity.placeholder,
      );

  bool get isPending => entity.isPending;
  bool get isActive => entity.isActive;
  bool get isRejectedOrSuspended => entity.isRejectedOrSuspended;

  AccountStatusState copyWith({
    AccountStatusViewStatus? status,
    ParentAccountStatusEntity? entity,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return AccountStatusState(
      status: status ?? this.status,
      entity: entity ?? this.entity,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [status, entity, errorMessage, isRefreshing];
}
