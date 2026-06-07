part of 'redeem_code_bloc.dart';

sealed class RedeemCodeEvent {
  const RedeemCodeEvent();
}

final class RedeemCodeLoadEvent extends RedeemCodeEvent {
  const RedeemCodeLoadEvent();
}

final class RedeemCodeSubmitEvent extends RedeemCodeEvent {
  final String code;
  const RedeemCodeSubmitEvent(this.code);
}
