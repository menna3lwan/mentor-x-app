part of 'redeem_code_page_bloc.dart';

sealed class RedeemCodePageEvent extends Equatable {
  const RedeemCodePageEvent();

  @override
  List<Object?> get props => [];
}

final class RedeemCodePageLoadEvent extends RedeemCodePageEvent {
  const RedeemCodePageLoadEvent();
}
