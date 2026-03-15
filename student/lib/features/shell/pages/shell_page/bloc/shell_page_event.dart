part of 'shell_page_bloc.dart';

sealed class ShellPageEvent extends Equatable {
  const ShellPageEvent();

  @override
  List<Object?> get props => [];
}

final class ShellPageLoadEvent extends ShellPageEvent {
  const ShellPageLoadEvent();
}
