part of 'children_bloc.dart';

enum ChildrenStatus { initial, loading, success, failure }

class ChildrenState extends Equatable {
  final ChildrenStatus status;
  final List<ParentChildEntity> children;
  final ParentStudentLookupEntity? lookedUpStudent;
  final String? errorMessage;

  const ChildrenState({
    this.status = ChildrenStatus.initial,
    this.children = const [],
    this.lookedUpStudent,
    this.errorMessage,
  });

  ChildrenState copyWith({
    ChildrenStatus? status,
    List<ParentChildEntity>? children,
    ParentStudentLookupEntity? lookedUpStudent,
    String? errorMessage,
  }) {
    return ChildrenState(
      status: status ?? this.status,
      children: children ?? this.children,
      lookedUpStudent: lookedUpStudent ?? this.lookedUpStudent,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, children, lookedUpStudent, errorMessage];
}
