import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../../core/core.dart';
import 'walkthrough_page_page.dart';

final class WalkthroughPageWrapper extends StatelessWidget {
  final CacheRepository cacheRepository;

  const WalkthroughPageWrapper({
    super.key,
    required this.cacheRepository,
  });

  @override
  Widget build(BuildContext context) {
    return WalkthroughPagePage(
      onComplete: () async {
        await cacheRepository.put('has_seen_onboarding', 'true');
        if (context.mounted) {
          const LoginPageRoute().go(context);
        }
      },
      onSkip: () async {
        await cacheRepository.put('has_seen_onboarding', 'true');
        if (context.mounted) {
          const LoginPageRoute().go(context);
        }
      },
    );
  }
}
