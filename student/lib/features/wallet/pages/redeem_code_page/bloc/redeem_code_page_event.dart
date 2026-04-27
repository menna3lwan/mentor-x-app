part of 'redeem_code_page_bloc.dart';

sealed class RedeemCodePageEvent {
  const RedeemCodePageEvent();
}

final class RedeemCodePageLoadEvent extends RedeemCodePageEvent {
  const RedeemCodePageLoadEvent();
}

final class RedeemCodePageSubmitEvent extends RedeemCodePageEvent {
  final String code;
  const RedeemCodePageSubmitEvent(this.code);
}
