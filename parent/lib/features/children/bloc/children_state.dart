part of 'children_bloc.dart';

final class ChildrenState extends Equatable {
  final bool isLoading;
  final bool isSaving;
  final List<ParentChild> children;
  final String? activeChildId;
  final String? errorMessage;

  const ChildrenState({
    this.isLoading = false,
    this.isSaving = false,
    this.children = const [],
    this.activeChildId,
    this.errorMessage,
  });

  ChildrenState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<ParentChild>? children,
    String? activeChildId,
    String? errorMessage,
  }) {
    return ChildrenState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      children: children ?? this.children,
      activeChildId: activeChildId ?? this.activeChildId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSaving,
    children,
    activeChildId,
    errorMessage,
  ];
}
