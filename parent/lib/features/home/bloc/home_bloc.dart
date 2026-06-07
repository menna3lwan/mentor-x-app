import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'home_event.dart';
part 'home_state.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ParentChildrenRepository _childrenRepository;
  final ParentHomeRepository _homeRepository;
  final CacheRepository _cacheRepository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('HomeBloc');

  HomeBloc({
    required ParentChildrenRepository childrenRepository,
    required ParentHomeRepository homeRepository,
    required CacheRepository cacheRepository,
    required AnalyticsService analyticsService,
  })  : _childrenRepository = childrenRepository,
        _homeRepository = homeRepository,
        _cacheRepository = cacheRepository,
        _analyticsService = analyticsService,
        super(const HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeChildSwitched>(_onChildSwitched);
    on<HomeRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    _logger.info('HomeStarted event received');
    unawaited(_analyticsService.logEvent(name: AnalyticsEvents.homeViewed));
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final children = await _childrenRepository.getChildren();
      
      if (children.isEmpty) {
        _logger.info('No children found for parent');
        emit(state.copyWith(
          status: HomeStatus.success,
          children: [],
          selectedChild: null,
        ));
        return;
      }

      _logger.debug('Found ${children.length} children');
      final cachedChildId = await _cacheRepository.get('selected_child_id');
      final selectedChild = children.any((c) => c.id == cachedChildId)
          ? children.firstWhere((c) => c.id == cachedChildId)
          : children.first;

      _logger.debug('Selected child: ${selectedChild.name} (id: ${selectedChild.id})');
      emit(state.copyWith(
        children: children,
        selectedChild: selectedChild,
      ));

      await _loadDashboardData(selectedChild.id, emit);
    } catch (e, s) {
      _logger.error('Error in HomeStarted handler', e, s);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChildSwitched(
      HomeChildSwitched event, Emitter<HomeState> emit) async {
    if (state.selectedChild?.id == event.child.id) return;
    _logger.info('Switching child to: ${event.child.name} (id: ${event.child.id})');

    unawaited(_analyticsService.logEvent(
      name: 'child_switched',
      parameters: {
        AnalyticsParams.childId: event.child.id,
        AnalyticsParams.childName: event.child.name,
      },
    ));

    emit(state.copyWith(
      selectedChild: event.child,
      status: HomeStatus.loading,
    ));

    try {
      await _cacheRepository.put('selected_child_id', event.child.id);
      await _loadDashboardData(event.child.id, emit);
    } catch (e, s) {
      _logger.error('Error switching child', e, s);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRequested(
      HomeRefreshRequested event, Emitter<HomeState> emit) async {
    _logger.info('Refresh requested');
    if (state.selectedChild == null) {
      add(HomeStarted());
      return;
    }
    await _loadDashboardData(state.selectedChild!.id, emit);
  }

  Future<void> _loadDashboardData(
      String childId, Emitter<HomeState> emit) async {
    _logger.info('Loading dashboard data for childId: $childId');
    try {
      final results = await Future.wait([
        _homeRepository.getSummary(childId),
        _homeRepository.getRecentActivity(childId),
        _homeRepository.getAnnouncements(childId),
      ]);

      _logger.info('Successfully loaded dashboard data for childId: $childId');
      emit(state.copyWith(
        status: HomeStatus.success,
        summary: results[0] as ParentHomeSummaryEntity,
        recentActivity: results[1] as List<ParentRecentActivityEntity>,
        announcements: results[2] as List<AnnouncementEntity>,
      ));
    } catch (e, s) {
      _logger.error('Failed to load dashboard data for childId: $childId', e, s);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
