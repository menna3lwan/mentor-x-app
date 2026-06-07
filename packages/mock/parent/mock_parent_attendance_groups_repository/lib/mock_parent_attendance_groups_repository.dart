import 'package:mentorx_core/mentorx_core.dart';

/// In-memory mock of [ParentAttendanceGroupsRepository] for `mock` builds.
///
/// Returns deterministic fixtures so the UI can be developed and demoed
/// without a backend.
final class MockParentAttendanceGroupsRepository
    implements ParentAttendanceGroupsRepository {
  final Duration delay;

  MockParentAttendanceGroupsRepository({
    this.delay = const Duration(milliseconds: 600),
  });

  @override
  Future<void> initialize() async {}

  @override
  Future<List<ParentAttendanceGroupEntity>> getGroups(String childId) async {
    await Future<void>.delayed(delay);
    return [
      const ParentAttendanceGroupEntity(
        id: 'grp_math_1',
        name: 'مجموعة الرياضيات — مسائي',
        courseName: 'الرياضيات',
        teacherName: 'أ. أحمد محمد',
        enrolledCount: 24,
        schedule: [
          ParentGroupScheduleEntry(
            dayOfWeek: 1,
            startTime: '17:00',
            endTime: '19:00',
            room: 'قاعة 12',
          ),
          ParentGroupScheduleEntry(
            dayOfWeek: 3,
            startTime: '17:00',
            endTime: '19:00',
            room: 'قاعة 12',
          ),
        ],
      ),
      const ParentAttendanceGroupEntity(
        id: 'grp_physics_1',
        name: 'مجموعة الفيزياء — صباحي',
        courseName: 'الفيزياء',
        teacherName: 'أ. مريم علي',
        enrolledCount: 18,
        schedule: [
          ParentGroupScheduleEntry(
            dayOfWeek: 6,
            startTime: '09:00',
            endTime: '11:00',
            room: 'قاعة 4',
          ),
        ],
      ),
      const ParentAttendanceGroupEntity(
        id: 'grp_chem_1',
        name: 'مجموعة الكيمياء — مكثف',
        courseName: 'الكيمياء',
        teacherName: 'أ. خالد فؤاد',
        enrolledCount: 16,
        isActive: false,
        schedule: [
          ParentGroupScheduleEntry(
            dayOfWeek: 5,
            startTime: '15:00',
            endTime: '17:30',
            room: 'مختبر 3',
          ),
        ],
      ),
    ];
  }

  @override
  Future<ParentAttendanceGroupDetailEntity> getGroup({
    required String childId,
    required String groupId,
  }) async {
    await Future<void>.delayed(delay);
    final groups = await getGroups(childId);
    final group = groups.firstWhere(
      (g) => g.id == groupId,
      orElse: () => ParentAttendanceGroupEntity.placeholder,
    );
    if (group.id.isEmpty) {
      throw const ParentAttendanceGroupsRepositoryException(
        code: ParentAttendanceGroupsRepositoryExceptionCode.notFound,
        message: 'Group not found.',
      );
    }

    final now = DateTime.now();
    return ParentAttendanceGroupDetailEntity(
      group: group,
      description:
          'حصة منتظمة تركّز على حل المسائل وتجهيز الطالب للامتحان النهائي.',
      location: 'فرع الجيزة — الدور الثاني',
      startDate: now.subtract(const Duration(days: 60)),
      endDate: now.add(const Duration(days: 90)),
      totalSessions: 12,
      attendedSessions: 9,
      missedSessions: 2,
      lateSessions: 1,
      recentSessions: [
        ParentGroupSessionEntity(
          id: 's_1',
          date: now.subtract(const Duration(days: 2)),
          status: AttendanceStatus.present,
          topic: 'مراجعة شاملة على الفصل الثالث',
        ),
        ParentGroupSessionEntity(
          id: 's_2',
          date: now.subtract(const Duration(days: 5)),
          status: AttendanceStatus.late,
          topic: 'تطبيقات على قانون نيوتن الثاني',
          note: 'تأخّر 15 دقيقة',
        ),
        ParentGroupSessionEntity(
          id: 's_3',
          date: now.subtract(const Duration(days: 9)),
          status: AttendanceStatus.absent,
          topic: 'مقدمة الديناميكا',
          note: 'إجازة مرضية',
        ),
        ParentGroupSessionEntity(
          id: 's_4',
          date: now.subtract(const Duration(days: 12)),
          status: AttendanceStatus.present,
          topic: 'حل أمثلة على المعادلات',
        ),
      ],
    );
  }
}
