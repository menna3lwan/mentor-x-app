import 'package:go_router/go_router.dart';
import 'verify_identity_page_wrapper.dart';

final class VerifyIdentityPageRoute extends GoRoute {
  VerifyIdentityPageRoute()
      : super(
          path: '/verify-identity',
          builder: (context, state) => const VerifyIdentityPageWrapper(),
        );
}
