import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parent/core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import 'package:mentorx_core/mentorx_core.dart';

void main() {
  const tUser = ParentEntity(
    id: 'user-1',
    name: 'Test Parent',
    phoneNumber: '01000000000',
  );
  const tUpdatedUser = ParentEntity(
    id: 'user-1',
    name: 'Updated Name',
    phoneNumber: '01000000000',
  );

  group('AppAuthenticationCubit', () {
    test('initial state has null user when no initialUser provided', () {
      final cubit = AppAuthenticationCubit();
      expect(cubit.state.user, isNull);
      expect(cubit.isAuthenticated, isFalse);
      cubit.close();
    });

    test('initial state has user when initialUser provided', () {
      final cubit = AppAuthenticationCubit(initialUser: tUser);
      expect(cubit.state.user, tUser);
      expect(cubit.isAuthenticated, isTrue);
      cubit.close();
    });

    blocTest<AppAuthenticationCubit, AppAuthenticationState>(
      'emits state with user on login',
      build: () => AppAuthenticationCubit(),
      act: (cubit) => cubit.login(tUser),
      expect: () => [AppAuthenticationState(user: tUser)],
    );

    blocTest<AppAuthenticationCubit, AppAuthenticationState>(
      'emits state with null user on logout',
      build: () => AppAuthenticationCubit(initialUser: tUser),
      act: (cubit) => cubit.logout(),
      expect: () => [const AppAuthenticationState(user: null)],
    );

    blocTest<AppAuthenticationCubit, AppAuthenticationState>(
      'emits state with updated user on update',
      build: () => AppAuthenticationCubit(initialUser: tUser),
      act: (cubit) => cubit.update(tUpdatedUser),
      expect: () => [AppAuthenticationState(user: tUpdatedUser)],
    );

    test('isAuthenticated returns true after login', () {
      final cubit = AppAuthenticationCubit();
      cubit.login(tUser);
      expect(cubit.isAuthenticated, isTrue);
      cubit.close();
    });

    test('isAuthenticated returns false after logout', () {
      final cubit = AppAuthenticationCubit(initialUser: tUser);
      cubit.logout();
      expect(cubit.isAuthenticated, isFalse);
      cubit.close();
    });
  });
}
