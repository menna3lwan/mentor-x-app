part of '../../mock_data.dart';

final class MockCourseGenerator {
  MockCourseGenerator._();

  static List<CourseSummaryEntity> enrolledCourses({
    required String languageCode,
    String? status,
  }) {
    switch (status) {
      case 'completed':
        return [
          LocalizedCourseData.algebraFundamentals.resolve(languageCode),
          const CourseSummaryEntity(
            id: 'ec2',
            title: 'Introduction to Chemistry',
            thumbnailUrl: 'https://picsum.photos/500/300?32',
            progressPercent: 100,
            enrolledCount: 980,
          ),
          const CourseSummaryEntity(
            id: 'ec3',
            title: 'English Grammar Basics',
            thumbnailUrl: 'https://picsum.photos/500/300?33',
            progressPercent: 100,
            enrolledCount: 1120,
          ),
        ];
      case 'expired':
        return const [
          CourseSummaryEntity(
            id: 'ee1',
            title: 'Physics Mechanics — Term 1',
            thumbnailUrl: 'https://picsum.photos/500/300?41',
            progressPercent: 45,
            enrolledCount: 870,
          ),
          CourseSummaryEntity(
            id: 'ee2',
            title: 'Biology Cell Structure',
            thumbnailUrl: 'https://picsum.photos/500/300?42',
            progressPercent: 20,
            enrolledCount: 650,
          ),
        ];
      default: // in_progress
        return const [
          CourseSummaryEntity(
            id: 'ep1',
            title: 'Advanced Algebra for Grade 10',
            thumbnailUrl: 'https://picsum.photos/500/300?51',
            progressPercent: 64,
            enrolledCount: 1270,
          ),
          CourseSummaryEntity(
            id: 'ep2',
            title: 'Physics Mechanics — Midterm Revision',
            thumbnailUrl: 'https://picsum.photos/500/300?52',
            progressPercent: 38,
            enrolledCount: 950,
          ),
          CourseSummaryEntity(
            id: 'ep3',
            title: 'English Grammar Essentials',
            thumbnailUrl: 'https://picsum.photos/500/300?53',
            progressPercent: 81,
            enrolledCount: 780,
          ),
          CourseSummaryEntity(
            id: 'ep4',
            title: 'Chemistry Organic Compounds',
            thumbnailUrl: 'https://picsum.photos/500/300?54',
            progressPercent: 12,
            enrolledCount: 1100,
          ),
          CourseSummaryEntity(
            id: 'ep5',
            title: 'Arabic Literature — Poetry Analysis',
            thumbnailUrl: 'https://picsum.photos/500/300?55',
            progressPercent: 55,
            enrolledCount: 620,
          ),
        ];
    }
  }

  static List<CourseSummaryEntity> catalogCourses() {
    return const [
      CourseSummaryEntity(
        id: 'cat1',
        title: 'Chemistry Crash Course',
        thumbnailUrl: 'https://picsum.photos/400/400?61',
        price: 300,
        enrolledCount: 2190,
      ),
      CourseSummaryEntity(
        id: 'cat2',
        title: 'Biology Question Bank',
        thumbnailUrl: 'https://picsum.photos/400/400?62',
        price: 0,
        enrolledCount: 1320,
      ),
      CourseSummaryEntity(
        id: 'cat3',
        title: 'Math Final Exam Prep',
        thumbnailUrl: 'https://picsum.photos/400/400?63',
        price: 260,
        enrolledCount: 1705,
      ),
      CourseSummaryEntity(
        id: 'cat4',
        title: 'Arabic Writing Masterclass',
        thumbnailUrl: 'https://picsum.photos/400/400?64',
        price: 0,
        enrolledCount: 905,
      ),
      CourseSummaryEntity(
        id: 'cat5',
        title: 'Physics — Electricity & Magnetism',
        thumbnailUrl: 'https://picsum.photos/400/400?65',
        price: 350,
        enrolledCount: 1560,
      ),
      CourseSummaryEntity(
        id: 'cat6',
        title: 'English Conversation Skills',
        thumbnailUrl: 'https://picsum.photos/400/400?66',
        price: 180,
        enrolledCount: 740,
      ),
      CourseSummaryEntity(
        id: 'cat7',
        title: 'Geometry & Trigonometry',
        thumbnailUrl: 'https://picsum.photos/400/400?67',
        price: 220,
        enrolledCount: 1100,
      ),
      CourseSummaryEntity(
        id: 'cat8',
        title: 'Organic Chemistry Deep Dive',
        thumbnailUrl: 'https://picsum.photos/400/400?68',
        price: 0,
        enrolledCount: 890,
      ),
      CourseSummaryEntity(
        id: 'cat9',
        title: 'French Language Basics',
        thumbnailUrl: 'https://picsum.photos/400/400?69',
        price: 150,
        enrolledCount: 430,
      ),
      CourseSummaryEntity(
        id: 'cat10',
        title: 'History of Modern Egypt',
        thumbnailUrl: 'https://picsum.photos/400/400?70',
        price: 0,
        enrolledCount: 560,
      ),
    ];
  }

  static List<CategoryEntity> categories() {
    return const [
      CategoryEntity(id: 'cat_phy', name: 'Physics', gradeId: 'g1'),
      CategoryEntity(id: 'cat_math', name: 'Mathematics', gradeId: 'g1'),
      CategoryEntity(id: 'cat_chem', name: 'Chemistry', gradeId: 'g1'),
      CategoryEntity(id: 'cat_bio', name: 'Biology', gradeId: 'g1'),
      CategoryEntity(id: 'cat_eng', name: 'English', gradeId: 'g1'),
      CategoryEntity(id: 'cat_arb', name: 'Arabic', gradeId: 'g1'),
    ];
  }

  static CourseEntity courseDetail(String courseId) {
    return CourseEntity(
      id: courseId,
      title: 'Advanced Algebra for Grade 10',
      subtitle: 'Complete algebra course covering all midterm topics',
      imageUrl: 'https://picsum.photos/800/450?80',
      price: 300,
      oldPrice: 450,
      isFree: false,
      type: CourseType.both,
      orderingMode: OrderingMode.free,
      durationDays: 90,
      pointsReward: 150,
      gradeId: 'g1',
      categoryId: 'cat_math',
      totalSessions: 5,
      totalVideos: 12,
      totalDurationMinutes: 480,
      enrolledCount: 1270,
      featured: true,
    );
  }

  static List<SessionEntity> courseSessions(String courseId) {
    return const [
      SessionEntity(
        id: 's1',
        courseId: 'ep1',
        title: 'Introduction to Algebraic Expressions',
        orderNumber: 0,
        isFree: true,
        itemCount: 4,
      ),
      SessionEntity(
        id: 's2',
        courseId: 'ep1',
        title: 'Linear Equations',
        orderNumber: 1,
        itemCount: 3,
      ),
      SessionEntity(
        id: 's3',
        courseId: 'ep1',
        title: 'Quadratic Equations',
        orderNumber: 2,
        itemCount: 5,
      ),
      SessionEntity(
        id: 's4',
        courseId: 'ep1',
        title: 'Polynomials & Factoring',
        orderNumber: 3,
        itemCount: 3,
      ),
      SessionEntity(
        id: 's5',
        courseId: 'ep1',
        title: 'Final Review & Practice',
        orderNumber: 4,
        itemCount: 4,
      ),
    ];
  }

  static List<SessionItemEntity> sessionItems(String sessionId) {
    switch (sessionId) {
      case 's1':
        return const [
          SessionItemEntity(
            id: 'i1',
            sessionId: 's1',
            title: 'Welcome & Course Overview',
            itemType: SessionItemType.video,
            isFree: true,
            isPreview: true,
            orderIndex: 0,
            durationSeconds: 420,
          ),
          SessionItemEntity(
            id: 'i2',
            sessionId: 's1',
            title: 'What are Algebraic Expressions?',
            itemType: SessionItemType.video,
            orderIndex: 1,
            durationSeconds: 1200,
          ),
          SessionItemEntity(
            id: 'i3',
            sessionId: 's1',
            title: 'Expressions Cheat Sheet',
            itemType: SessionItemType.document,
            orderIndex: 2,
            downloadable: true,
            pageCount: 8,
            fileSize: 2400,
          ),
          SessionItemEntity(
            id: 'i4',
            sessionId: 's1',
            title: 'Practice Quiz: Expressions',
            itemType: SessionItemType.quiz,
            orderIndex: 3,
          ),
        ];
      case 's2':
        return const [
          SessionItemEntity(
            id: 'i5',
            sessionId: 's2',
            title: 'Solving Linear Equations',
            itemType: SessionItemType.video,
            orderIndex: 0,
            durationSeconds: 1500,
          ),
          SessionItemEntity(
            id: 'i6',
            sessionId: 's2',
            title: 'Linear Equations Notes',
            itemType: SessionItemType.document,
            orderIndex: 1,
          ),
          SessionItemEntity(
            id: 'i7',
            sessionId: 's2',
            title: 'Linear Equations Assignment',
            itemType: SessionItemType.assignment,
            orderIndex: 2,
          ),
        ];
      case 's3':
        return const [
          SessionItemEntity(
            id: 'i8',
            sessionId: 's3',
            title: 'What are Quadratic Equations?',
            itemType: SessionItemType.video,
            orderIndex: 0,
            durationSeconds: 1800,
          ),
          SessionItemEntity(
            id: 'i9',
            sessionId: 's3',
            title: 'Solving by Factoring',
            itemType: SessionItemType.video,
            orderIndex: 1,
            durationSeconds: 1200,
          ),
          SessionItemEntity(
            id: 'i10',
            sessionId: 's3',
            title: 'The Quadratic Formula',
            itemType: SessionItemType.document,
            orderIndex: 2,
            pageCount: 5,
            fileSize: 1800,
          ),
          SessionItemEntity(
            id: 'i11',
            sessionId: 's3',
            title: 'Practice Problems',
            itemType: SessionItemType.quiz,
            orderIndex: 3,
          ),
          SessionItemEntity(
            id: 'i12',
            sessionId: 's3',
            title: 'Extra Resources',
            itemType: SessionItemType.link,
            orderIndex: 4,
            contentUrl: 'https://example.com/quadratic-resources',
          ),
        ];
      default:
        return const [
          SessionItemEntity(
            id: 'i_default_1',
            sessionId: 'default',
            title: 'Lesson Video',
            itemType: SessionItemType.video,
            orderIndex: 0,
            durationSeconds: 1500,
          ),
          SessionItemEntity(
            id: 'i_default_2',
            sessionId: 'default',
            title: 'Lesson Notes',
            itemType: SessionItemType.document,
            orderIndex: 1,
            pageCount: 6,
            fileSize: 1500,
          ),
          SessionItemEntity(
            id: 'i_default_3',
            sessionId: 'default',
            title: 'Practice Quiz',
            itemType: SessionItemType.quiz,
            orderIndex: 2,
          ),
        ];
    }
  }

  static EnrollmentEntity courseProgress(String courseId) {
    return EnrollmentEntity(
      id: 'enr_1',
      courseId: courseId,
      progressPercent: 64,
      completedSessions: 3,
      enrolledAt: DateTime.now().subtract(const Duration(days: 30)),
      expiresAt: DateTime.now().add(const Duration(days: 60)),
      lastAccessedAt: DateTime.now().subtract(const Duration(hours: 2)),
      lastItemId: 'i5',
    );
  }

  static EnrollmentEntity enrollResult(String courseId) {
    return EnrollmentEntity(
      id: 'enr_new',
      courseId: courseId,
      progressPercent: 0,
      completedSessions: 0,
      enrolledAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 90)),
    );
  }

  static List<WeekEntity> sessionWeeks(String sessionId) {
    return [
      WeekEntity(
        id: 'w1',
        sessionId: sessionId,
        title: 'Week 1',
      ),
      WeekEntity(
        id: 'w2',
        sessionId: sessionId,
        title: 'Week 2',
      ),
    ];
  }
}
