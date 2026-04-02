part of '../../../mock_data.dart';

final class BilingualCourseValues extends BilingualValues<CourseSummaryEntity> {
  const BilingualCourseValues({
    required super.ar,
    required super.en,
  });

  CourseSummaryEntity resolve(String languageCode) => get(languageCode);
}

final class LocalizedCourseData {
  const LocalizedCourseData._();

  static const algebraFundamentals = BilingualCourseValues(
    ar: CourseSummaryEntity(
      id: 'ec1',
      title: 'أساسيات الجبر',
      thumbnailUrl: 'https://picsum.photos/500/300?31',
      progressPercent: 100,
      enrolledCount: 1450,
    ),
    en: CourseSummaryEntity(
      id: 'ec1',
      title: 'Algebra Fundamentals',
      thumbnailUrl: 'https://picsum.photos/500/300?31',
      progressPercent: 100,
      enrolledCount: 1450,
    ),
  );

  static const organicChemistry = BilingualCourseValues(
    ar: CourseSummaryEntity(
      id: 'ep4',
      title: 'الكيمياء العضوية',
      thumbnailUrl: 'https://picsum.photos/500/300?54',
      progressPercent: 12,
      enrolledCount: 1100,
    ),
    en: CourseSummaryEntity(
      id: 'ep4',
      title: 'Chemistry Organic Compounds',
      thumbnailUrl: 'https://picsum.photos/500/300?54',
      progressPercent: 12,
      enrolledCount: 1100,
    ),
  );
}
