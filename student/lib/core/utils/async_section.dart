import 'package:equatable/equatable.dart';

enum AsyncSectionStatus { initial, loading, success, failure }

final class AsyncSection<T> extends Equatable {
  final AsyncSectionStatus status;
  final T? data;
  final String? errorMessage;

  const AsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const AsyncSection.initial() : this._(status: AsyncSectionStatus.initial);

  const AsyncSection.loading({T? data})
      : this._(status: AsyncSectionStatus.loading, data: data);

  const AsyncSection.success(T data)
      : this._(status: AsyncSectionStatus.success, data: data);

  const AsyncSection.failure({String? message, T? data})
      : this._(
          status: AsyncSectionStatus.failure,
          data: data,
          errorMessage: message,
        );

  bool get isInitial => status == AsyncSectionStatus.initial;
  bool get isLoading => status == AsyncSectionStatus.loading;
  bool get isSuccess => status == AsyncSectionStatus.success;
  bool get isFailure => status == AsyncSectionStatus.failure;

  @override
  List<Object?> get props => [status, data, errorMessage];
}
