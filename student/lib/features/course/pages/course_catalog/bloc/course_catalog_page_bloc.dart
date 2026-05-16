import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'course_catalog_page_event.dart';
part 'course_catalog_page_state.dart';

sealed class CourseCatalogPagePresentationEvent {
  const CourseCatalogPagePresentationEvent();
}

final class CourseCatalogPageFailurePresentationEvent
    extends CourseCatalogPagePresentationEvent {
  final String message;
  const CourseCatalogPageFailurePresentationEvent({required this.message});
}

final class CourseCatalogPageBloc
    extends Bloc<CourseCatalogPageEvent, CourseCatalogPageState>
    with
        BlocPresentationMixin<
          CourseCatalogPageState,
          CourseCatalogPagePresentationEvent
        > {
  final CourseRepository _courseRepository;
  final StudentRegistrationRepository _registrationRepository;
  final AnalyticsService _analyticsService;

  CourseCatalogPageBloc({
    required CourseRepository courseRepository,
    required StudentRegistrationRepository registrationRepository,
    required AnalyticsService analyticsService,
  }) : _courseRepository = courseRepository,
       _registrationRepository = registrationRepository,
       _analyticsService = analyticsService,
       super(const CourseCatalogPageState()) {
    on<CourseCatalogPageInitialized>(_onInitialized);
    on<CourseCatalogPageSearchChanged>(_onSearchChanged);
    on<CourseCatalogPageCategoryChanged>(_onCategoryChanged);
    on<CourseCatalogPageGradeChanged>(_onGradeChanged);
    on<CourseCatalogPageSortChanged>(_onSortChanged);
    on<CourseCatalogPageRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    CourseCatalogPageInitialized event,
    Emitter<CourseCatalogPageState> emit,
  ) async {
    _analyticsService.logEvent(name: AnalyticsEvents.courseCatalogViewed);
    emit(
      state.copyWith(
        gradesStatus: CatalogSectionStatus.loading,
        categoriesStatus: CatalogSectionStatus.loading,
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
    CourseCatalogPageGradeChanged event,
    Emitter<CourseCatalogPageState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedGradeId: event.gradeId,
        clearGrade: event.gradeId == null,
        clearCategory: true,
      ),
    );
    await _loadCategories(emit: emit);
    await _loadCourses(emit: emit);
  }

  Future<void> _loadCategories({
    required Emitter<CourseCatalogPageState> emit,
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
    CourseCatalogPageSearchChanged event,
    Emitter<CourseCatalogPageState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
    await _loadCourses(emit: emit);
  }

  Future<void> _onCategoryChanged(
    CourseCatalogPageCategoryChanged event,
    Emitter<CourseCatalogPageState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategoryId: event.categoryId,
        clearCategory: event.categoryId == null,
      ),
    );
    await _loadCourses(emit: emit);
  }

  Future<void> _onSortChanged(
    CourseCatalogPageSortChanged event,
    Emitter<CourseCatalogPageState> emit,
  ) async {
    emit(state.copyWith(sortOption: event.sortOption));
    await _loadCourses(emit: emit);
  }

  Future<void> _onRefreshed(
    CourseCatalogPageRefreshed event,
    Emitter<CourseCatalogPageState> emit,
  ) async {
    await _loadCourses(emit: emit);
  }

  Future<void> _loadCourses({
    required Emitter<CourseCatalogPageState> emit,
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
        CourseCatalogPageFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          coursesStatus: CatalogSectionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        CourseCatalogPageFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
