part of 'children_bloc.dart';

enum ChildrenSectionStatus { initial, loading, loaded, failure }

/// Generic async slot — same shape as `HomeAsyncSection` so both features
/// feel identical in code.
final class ChildrenAsyncSection<T> extends Equatable {
  final ChildrenSectionStatus status;
  final T? data;
  final String? errorMessage;

  const ChildrenAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const ChildrenAsyncSection.initial()
    : this._(status: ChildrenSectionStatus.initial);

  const ChildrenAsyncSection.loading({T? data})
    : this._(status: ChildrenSectionStatus.loading, data: data);

  const ChildrenAsyncSection.loaded(T data)
    : this._(status: ChildrenSectionStatus.loaded, data: data);

  const ChildrenAsyncSection.failure(String message, {T? data})
    : this._(
        status: ChildrenSectionStatus.failure,
        data: data,
        errorMessage: message,
      );

  bool get isInitial => status == ChildrenSectionStatus.initial;
  bool get isLoading => status == ChildrenSectionStatus.loading;
  bool get isLoaded => status == ChildrenSectionStatus.loaded;
  bool get isFailure => status == ChildrenSectionStatus.failure;

  ChildrenAsyncSection<T> toLoading() =>
      ChildrenAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class ChildrenState extends Equatable {
  /// Linked-children list slot.
  final ChildrenAsyncSection<List<ParentChildEntity>> childrenSection;

  /// Result of the "find student" lookup before linking.
  final ChildrenAsyncSection<ParentStudentLookupEntity?> lookupSection;

  /// State of the "link child" mutation. `data` is the just-linked child.
  final ChildrenAsyncSection<ParentChildEntity?> linkSection;

  /// State of the "unlink child" mutation. `data` is unused (null).
  final ChildrenAsyncSection<void> unlinkSection;

  /// The id of the child currently being unlinked, for per-row spinners.
  final String? unlinkingChildId;

  const ChildrenState({
    required this.childrenSection,
    required this.lookupSection,
    required this.linkSection,
    required this.unlinkSection,
    required this.unlinkingChildId,
  });

  factory ChildrenState.initial() {
    return const ChildrenState(
      childrenSection: ChildrenAsyncSection.initial(),
      lookupSection: ChildrenAsyncSection.initial(),
      linkSection: ChildrenAsyncSection.initial(),
      unlinkSection: ChildrenAsyncSection.initial(),
      unlinkingChildId: null,
    );
  }

  List<ParentChildEntity> get children =>
      childrenSection.data ?? const <ParentChildEntity>[];

  ParentStudentLookupEntity? get lookedUpStudent => lookupSection.data;

  bool get isLookupLoading => lookupSection.isLoading;
  bool get isLinking => linkSection.isLoading;

  ChildrenState copyWith({
    ChildrenAsyncSection<List<ParentChildEntity>>? childrenSection,
    ChildrenAsyncSection<ParentStudentLookupEntity?>? lookupSection,
    ChildrenAsyncSection<ParentChildEntity?>? linkSection,
    ChildrenAsyncSection<void>? unlinkSection,
    String? unlinkingChildId,
  }) {
    return ChildrenState(
      childrenSection: childrenSection ?? this.childrenSection,
      lookupSection: lookupSection ?? this.lookupSection,
      linkSection: linkSection ?? this.linkSection,
      unlinkSection: unlinkSection ?? this.unlinkSection,
      // Pass null explicitly to clear — the ?? would otherwise preserve the
      // previous id.
      unlinkingChildId: unlinkingChildId,
    );
  }

  @override
  List<Object?> get props => [
    childrenSection,
    lookupSection,
    linkSection,
    unlinkSection,
    unlinkingChildId,
  ];
}
