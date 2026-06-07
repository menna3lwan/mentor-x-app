import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'children_event.dart';
part 'children_state.dart';

final class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final ParentChildrenRepository _childrenRepository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('ChildrenBloc');

  ChildrenBloc({
    required ParentChildrenRepository childrenRepository,
    required AnalyticsService analyticsService,
  })  : _childrenRepository = childrenRepository,
        _analyticsService = analyticsService,
        super(const ChildrenState()) {
    on<ChildrenStarted>(_onStarted);
    on<ChildrenLookupRequested>(_onLookupRequested);
    on<ChildLinkConfirmed>(_onChildLinkConfirmed);
  }

  Future<void> _onStarted(ChildrenStarted event, Emitter<ChildrenState> emit) async {
    _logger.info('Fetching children list...');
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      final children = await _childrenRepository.getChildren();
      _analyticsService.logEvent(name: AnalyticsEvents.childrenViewed);
      _logger.info('Successfully fetched ${children.length} children');
      emit(state.copyWith(status: ChildrenStatus.success, children: children));
    } catch (e, s) {
      _logger.error('Failed to fetch children list', e, s);
      emit(state.copyWith(status: ChildrenStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onLookupRequested(
      ChildrenLookupRequested event, Emitter<ChildrenState> emit) async {
    _logger.info('Looking up student with query: ${event.query}');
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      final student = await _childrenRepository.findStudentByChildQuery(
        query: event.query,
      );
      _logger.info('Successfully looked up student: ${student.maskedName}');
      emit(state.copyWith(
        status: ChildrenStatus.success,
        lookedUpStudent: student,
      ));
    } catch (e, s) {
      _logger.error('Failed student lookup for query: ${event.query}', e, s);
      emit(state.copyWith(
        status: ChildrenStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChildLinkConfirmed(
      ChildLinkConfirmed event, Emitter<ChildrenState> emit) async {
    _logger.info('Linking child: ${event.studentId} with relationship: ${event.relationship}');
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      await _childrenRepository.linkChild(
        studentId: event.studentId,
        relationship: event.relationship,
      );
      _logger.info('Successfully linked child. Reloading children list...');
      final children = await _childrenRepository.getChildren();
      _logger.info('Reloaded children. Total: ${children.length}');
      emit(state.copyWith(
        status: ChildrenStatus.success,
        children: children,
        lookedUpStudent: null,
      ));
    } catch (e, s) {
      _logger.error('Failed to link child: ${event.studentId}', e, s);
      emit(state.copyWith(
        status: ChildrenStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
