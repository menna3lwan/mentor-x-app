enum LoadingState {
  initial,
  loading,
  loaded,
  actionInProgress,
  success,
  error
  ;

  bool get isLoading => this == LoadingState.loading;
  bool get isLoaded => this == LoadingState.loaded;
  bool get isActionInProgress => this == LoadingState.actionInProgress;
  bool get isSuccess => this == LoadingState.success;
  bool get isError => this == LoadingState.error;
}
