part of 'support_page_bloc.dart';

sealed class SupportPageEvent extends Equatable {
  const SupportPageEvent();

  @override
  List<Object?> get props => [];
}

final class SupportPageLoadEvent extends SupportPageEvent {
  const SupportPageLoadEvent();
}
