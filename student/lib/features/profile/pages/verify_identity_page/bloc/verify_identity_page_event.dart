part of 'verify_identity_page_bloc.dart';

sealed class VerifyIdentityPageEvent {
  const VerifyIdentityPageEvent();
}

final class VerifyIdentityPageStarted extends VerifyIdentityPageEvent {
  const VerifyIdentityPageStarted();
}

final class VerifyIdentityPageSubmit extends VerifyIdentityPageEvent {
  final String imagePath;
  const VerifyIdentityPageSubmit(this.imagePath);
}
