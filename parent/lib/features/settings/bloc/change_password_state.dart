part of 'change_password_bloc.dart';

enum ChangePasswordStatus { idle, submitting, success, failure }

final class ChangePasswordState extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final ChangePasswordStatus status;

  const ChangePasswordState({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.status,
  });

  factory ChangePasswordState.initial() => const ChangePasswordState(
    currentPassword: '',
    newPassword: '',
    confirmPassword: '',
    status: ChangePasswordStatus.idle,
  );

  bool get isSubmitting => status == ChangePasswordStatus.submitting;

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    ChangePasswordStatus? status,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmPassword,
    status,
  ];
}
