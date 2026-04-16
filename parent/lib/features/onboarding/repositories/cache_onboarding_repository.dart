import '../../../core/core.dart';
import 'onboarding_repository.dart';

final class CacheOnboardingRepository implements OnboardingRepository {
  static const String key = 'parent_onboarding_completed';

  final CacheRepository _cacheRepository;

  const CacheOnboardingRepository({required CacheRepository cacheRepository})
    : _cacheRepository = cacheRepository;

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _cacheRepository.get(key) == 'true';
  }

  @override
  Future<void> completeOnboarding() async {
    await _cacheRepository.put(key, 'true');
  }
}
