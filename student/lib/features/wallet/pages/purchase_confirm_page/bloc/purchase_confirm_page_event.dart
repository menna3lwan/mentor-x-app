part of 'purchase_confirm_page_bloc.dart';

sealed class PurchaseConfirmPageEvent extends Equatable {
  const PurchaseConfirmPageEvent();

  @override
  List<Object?> get props => [];
}

final class PurchaseConfirmPageLoadEvent extends PurchaseConfirmPageEvent {
  const PurchaseConfirmPageLoadEvent();
}
