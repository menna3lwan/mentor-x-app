import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ParentPortalRepository _repository;

  ProfileBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const ProfileState()) {
    on<ProfileStarted>(_onStarted);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsThemeChanged>(_onThemeChanged);
    on<SettingsPushToggleChanged>(_onPushChanged);
    on<SettingsSaved>(_onSaved);
  }

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final profile = await _repository.getProfile();
      final settings = await _repository.getSettings();
      emit(
        state.copyWith(
          isLoading: false,
          profile: profile,
          settings: settings,
        ),
      );
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  void _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<ProfileState> emit,
  ) {
    final current = state.settings;
    if (current == null) {
      return;
    }
    emit(
      state.copyWith(
        settings: current.copyWith(languageCode: event.languageCode),
      ),
    );
  }

  void _onThemeChanged(
    SettingsThemeChanged event,
    Emitter<ProfileState> emit,
  ) {
    final current = state.settings;
    if (current == null) {
      return;
    }
    emit(
      state.copyWith(settings: current.copyWith(themeMode: event.themeMode)),
    );
  }

  void _onPushChanged(
    SettingsPushToggleChanged event,
    Emitter<ProfileState> emit,
  ) {
    final current = state.settings;
    if (current == null) {
      return;
    }
    emit(
      state.copyWith(
        settings: current.copyWith(
          pushNotificationsEnabled: event.enabled,
        ),
      ),
    );
  }

  Future<void> _onSaved(SettingsSaved event, Emitter<ProfileState> emit) async {
    final settings = state.settings;
    if (settings == null) {
      return;
    }
    emit(state.copyWith(isSaving: true));
    await _repository.updateSettings(settings);
    emit(
      state.copyWith(
        isSaving: false,
        saveSuccessTick: state.saveSuccessTick + 1,
      ),
    );
  }
}
