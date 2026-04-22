part of 'package:mentorx_core/mentorx_core.dart';

abstract interface class OnboardingRepository {
  Future<void> initialize();
  Future<bool> isOnboardingCompleted();
  Future<void> completeOnboarding();
}
