import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ParentChildrenRepository _childrenRepository;
  final ParentHomeRepository _homeRepository;
  final CacheRepository _cacheRepository;

  HomeBloc({
    required ParentChildrenRepository childrenRepository,
    required ParentHomeRepository homeRepository,
    required CacheRepository cacheRepository,
  })  : _childrenRepository = childrenRepository,
        _homeRepository = homeRepository,
        _cacheRepository = cacheRepository,
        super(const HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeChildSwitched>(_onChildSwitched);
    on<HomeRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final children = await _childrenRepository.getChildren();
      
      if (children.isEmpty) {
        emit(state.copyWith(
          status: HomeStatus.success,
          children: [],
          selectedChild: null,
        ));
        return;
      }

      final cachedChildId = await _cacheRepository.get('selected_child_id');
      final selectedChild = children.any((c) => c.id == cachedChildId)
          ? children.firstWhere((c) => c.id == cachedChildId)
          : children.first;

      emit(state.copyWith(
        children: children,
        selectedChild: selectedChild,
      ));

      await _loadDashboardData(selectedChild.id, emit);
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChildSwitched(
      HomeChildSwitched event, Emitter<HomeState> emit) async {
    if (state.selectedChild?.id == event.child.id) return;

    emit(state.copyWith(
      selectedChild: event.child,
      status: HomeStatus.loading,
    ));

    await _cacheRepository.put('selected_child_id', event.child.id);
    await _loadDashboardData(event.child.id, emit);
  }

  Future<void> _onRefreshRequested(
      HomeRefreshRequested event, Emitter<HomeState> emit) async {
    if (state.selectedChild == null) {
      add(HomeStarted());
      return;
    }
    await _loadDashboardData(state.selectedChild!.id, emit);
  }

  Future<void> _loadDashboardData(
      String childId, Emitter<HomeState> emit) async {
    try {
      final results = await Future.wait([
        _homeRepository.getSummary(childId),
        _homeRepository.getRecentActivity(childId),
        _homeRepository.getAnnouncements(childId),
      ]);

      emit(state.copyWith(
        status: HomeStatus.success,
        summary: results[0] as ParentHomeSummaryEntity,
        recentActivity: results[1] as List<ParentRecentActivityEntity>,
        announcements: results[2] as List<AnnouncementEntity>,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
