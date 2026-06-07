part of 'shell_bloc.dart';

sealed class ShellEvent extends Equatable {
  const ShellEvent();

  @override
  List<Object?> get props => [];
}

final class ShellLoadEvent extends ShellEvent {
  const ShellLoadEvent();
}
