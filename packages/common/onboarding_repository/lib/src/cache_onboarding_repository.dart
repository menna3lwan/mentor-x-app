import 'package:mentorx_core/mentorx_core.dart';

final class CacheOnboardingRepository implements OnboardingRepository {
  final String key;
  final CacheRepository _cacheRepository;

  const CacheOnboardingRepository({
    required String appSlug,
    required CacheRepository cacheRepository,
  }) : key = '${appSlug}_onboarding_completed',
       _cacheRepository = cacheRepository;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _cacheRepository.get(key) == 'true';
  }

  @override
  Future<void> completeOnboarding() async {
    await _cacheRepository.put(key, 'true');
  }
}
