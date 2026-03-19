part of 'order_history_page_bloc.dart';

sealed class OrderHistoryPageEvent extends Equatable {
  const OrderHistoryPageEvent();

  @override
  List<Object?> get props => [];
}

final class OrderHistoryPageInitialized extends OrderHistoryPageEvent {
  const OrderHistoryPageInitialized();
}

final class OrderHistoryPageRefreshed extends OrderHistoryPageEvent {
  const OrderHistoryPageRefreshed();
}
