import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'course_catalog_event.dart';
part 'course_catalog_state.dart';

sealed class CourseCatalogPresentationEvent {
  const CourseCatalogPresentationEvent();
}

final class CourseCatalogFailurePresentationEvent
    extends CourseCatalogPresentationEvent {
  final String message;
  const CourseCatalogFailurePresentationEvent({required this.message});
}

final class CourseCatalogBloc
    extends Bloc<CourseCatalogEvent, CourseCatalogState>
    with
        BlocPresentationMixin<
          CourseCatalogState,
          CourseCatalogPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('CourseCatalogBloc');

  final CourseRepository _courseRepository;
  final StudentRegistrationRepository _registrationRepository;
  final AnalyticsService _analyticsService;

  CourseCatalogBloc({
    required CourseRepository courseRepository,
    required StudentRegistrationRepository registrationRepository,
    required AnalyticsService analyticsService,
  }) : _courseRepository = courseRepository,
       _registrationRepository = registrationRepository,
       _analyticsService = analyticsService,
       super(const CourseCatalogState()) {
    on<CourseCatalogInitialized>(_onInitialized);
    on<CourseCatalogSearchChanged>(_onSearchChanged);
    on<CourseCatalogCategoryChanged>(_onCategoryChanged);
    on<CourseCatalogGradeChanged>(_onGradeChanged);
    on<CourseCatalogSortChanged>(_onSortChanged);
    on<CourseCatalogRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    CourseCatalogInitialized event,
    Emitter<CourseCatalogState> emit,
  ) async {
    _logger.info('_onInitialized entered');
    _analyticsService.logEvent(name: AnalyticsEvents.courseCatalogViewed);
    emit(
      state.copyWith(
        gradesStatus: CatalogSectionStatus.loading,
        categoriesStatus: CatalogSectionStatus.loading,
        coursesStatus: CatalogSectionStatus.loading,
      ),
    );
    try {
      final appInfo = await _registrationRepository.getApplicationInfo();
      emit(
        state.copyWith(
          gradesStatus: CatalogSectionStatus.loaded,
          grades: appInfo.grades,
        ),
      );
    } catch (_) {
      emit(state.copyWith(gradesStatus: CatalogSectionStatus.failure));
    }

    await _loadCategories(emit: emit);
    await _loadCourses(emit: emit);
  }

  Future<void> _onGradeChanged(
    CourseCatalogGradeChanged event,
    Emitter<CourseCatalogState> emit,
  ) async {
    _logger.info('_onGradeChanged entered');
    emit(
      state.copyWith(
        selectedGradeId: event.gradeId,
        clearGrade: event.gradeId == null,
        clearCategory: true,
        coursesStatus: CatalogSectionStatus.loading,
      ),
    );
    await _loadCategories(emit: emit);
    await _loadCourses(emit: emit);
  }

  Future<void> _loadCategories({
    required Emitter<CourseCatalogState> emit,
  }) async {
    emit(state.copyWith(categoriesStatus: CatalogSectionStatus.loading));
    try {
      final categories = await _courseRepository.getCategories(
        gradeId: state.selectedGradeId,
      );
      emit(
        state.copyWith(
          categoriesStatus: CatalogSectionStatus.loaded,
          categories: categories,
        ),
      );
    } catch (_) {
      emit(state.copyWith(categoriesStatus: CatalogSectionStatus.failure));
    }
  }

  Future<void> _onSearchChanged(
    CourseCatalogSearchChanged event,
    Emitter<CourseCatalogState> emit,
  ) async {
    _logger.info('_onSearchChanged entered');
    emit(state.copyWith(searchQuery: event.query));
    await _loadCourses(emit: emit);
  }

  Future<void> _onCategoryChanged(
    CourseCatalogCategoryChanged event,
    Emitter<CourseCatalogState> emit,
  ) async {
    _logger.info('_onCategoryChanged entered');
    emit(
      state.copyWith(
        selectedCategoryId: event.categoryId,
        clearCategory: event.categoryId == null,
      ),
    );
    await _loadCourses(emit: emit);
  }

  Future<void> _onSortChanged(
    CourseCatalogSortChanged event,
    Emitter<CourseCatalogState> emit,
  ) async {
    _logger.info('_onSortChanged entered');
    emit(state.copyWith(sortOption: event.sortOption));
    await _loadCourses(emit: emit);
  }

  Future<void> _onRefreshed(
    CourseCatalogRefreshed event,
    Emitter<CourseCatalogState> emit,
  ) async {
    _logger.info('_onRefreshed entered');
    await _loadCourses(emit: emit);
  }

  Future<void> _loadCourses({
    required Emitter<CourseCatalogState> emit,
  }) async {
    emit(state.copyWith(coursesStatus: CatalogSectionStatus.loading));
    try {
      final (sort, order) = switch (state.sortOption) {
        CatalogSortOption.newest => (null, null),
        CatalogSortOption.priceAsc => ('price', 'asc'),
        CatalogSortOption.priceDesc => ('price', 'desc'),
        CatalogSortOption.popular => ('enrolled', null),
      };
      final courses = await _courseRepository.getCourseCatalog(
        gradeId: state.selectedGradeId,
        categoryId: state.selectedCategoryId,
        search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
        sort: sort,
        order: order,
      );
      emit(
        state.copyWith(
          coursesStatus: CatalogSectionStatus.loaded,
          courses: courses,
        ),
      );
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          coursesStatus: CatalogSectionStatus.failure,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        CourseCatalogFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          coursesStatus: CatalogSectionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        CourseCatalogFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
