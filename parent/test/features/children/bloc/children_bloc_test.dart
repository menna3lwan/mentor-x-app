import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/children/bloc/children_bloc.dart';

class _MockChildrenRepository extends Mock
    implements ParentChildrenRepository {}

void main() {
  late _MockChildrenRepository repo;

  const childA = ParentChildEntity(id: 'a', name: 'Ahmed Kamal');
  const childB = ParentChildEntity(id: 'b', name: 'Layla Hassan');

  const lookupHit = ParentStudentLookupEntity(
    studentId: 'a',
    maskedName: 'A***d K****l',
    gradeName: 'Primary 5',
    centerName: 'Cairo Center',
    canAutoVerify: true,
  );

  ChildrenBloc buildBloc() =>
      ChildrenBloc(childrenRepository: repo);

  setUp(() {
    repo = _MockChildrenRepository();
  });

  group('ChildrenBloc.ChildrenStarted', () {
    blocTest<ChildrenBloc, ChildrenState>(
      'loads the linked-children list',
      setUp: () {
        when(() => repo.getChildren())
            .thenAnswer((_) async => [childA, childB]);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const ChildrenStarted()),
      verify: (bloc) {
        expect(bloc.state.children, [childA, childB]);
        expect(bloc.state.childrenSection.isLoaded, isTrue);
      },
    );

    blocTest<ChildrenBloc, ChildrenState>(
      'fetch failure surfaces in section state and fires failure event',
      setUp: () {
        when(() => repo.getChildren()).thenThrow(Exception('boom'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const ChildrenStarted()),
      verify: (bloc) {
        expect(bloc.state.childrenSection.isFailure, isTrue);
      },
    );
  });

  group('ChildrenBloc.ChildrenLookupRequested', () {
    blocTest<ChildrenBloc, ChildrenState>(
      'empty trimmed query is a no-op',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const ChildrenLookupRequested('   '));
      },
      wait: const Duration(milliseconds: 20),
      verify: (bloc) {
        expect(bloc.state.lookupSection.isInitial, isTrue);
        verifyNever(() => repo.findStudentByChildQuery(query: any(named: 'query')));
      },
    );

    blocTest<ChildrenBloc, ChildrenState>(
      'successful lookup populates lookupSection',
      setUp: () {
        when(() => repo.findStudentByChildQuery(query: '0100'))
            .thenAnswer((_) async => lookupHit);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const ChildrenLookupRequested('0100')),
      verify: (bloc) {
        expect(bloc.state.lookupSection.isLoaded, isTrue);
        expect(bloc.state.lookedUpStudent, equals(lookupHit));
      },
    );

    blocTest<ChildrenBloc, ChildrenState>(
      'lookup failure is classified',
      setUp: () {
        when(() => repo.findStudentByChildQuery(query: any(named: 'query')))
            .thenThrow(
          const AuthenticationException(
            code: AuthenticationExceptionCode.studentNotFound,
          ),
        );
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const ChildrenLookupRequested('00000')),
      verify: (bloc) {
        expect(bloc.state.lookupSection.isFailure, isTrue);
      },
    );
  });

  group('ChildrenBloc.ChildLinkConfirmed', () {
    blocTest<ChildrenBloc, ChildrenState>(
      'refuses to link an already-present child',
      setUp: () {
        // Seed the list with the child we want to "re-link".
        when(() => repo.getChildren())
            .thenAnswer((_) async => [childA, childB]);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const ChildrenStarted());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const ChildLinkConfirmed(
          studentId: 'a',
          relationship: 'father',
        ));
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        // No API call should have been made.
        verifyNever(
          () => repo.linkChild(studentId: 'a', relationship: 'father'),
        );
        expect(bloc.state.linkSection.isFailure, isTrue);
      },
    );

    blocTest<ChildrenBloc, ChildrenState>(
      'successful link refreshes the list',
      setUp: () {
        when(() => repo.linkChild(studentId: 'b', relationship: 'father'))
            .thenAnswer((_) async => childB);
        when(() => repo.getChildren())
            .thenAnswer((_) async => [childA, childB]);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const ChildLinkConfirmed(
          studentId: 'b',
          relationship: 'father',
        ));
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        expect(bloc.state.linkSection.isLoaded, isTrue);
        verify(() => repo.getChildren()).called(1);
      },
    );
  });

  group('ChildrenBloc.ChildUnlinkRequested', () {
    blocTest<ChildrenBloc, ChildrenState>(
      'optimistically removes the child, keeps remove on success',
      setUp: () {
        when(() => repo.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        when(() => repo.unlinkChild('a')).thenAnswer((_) async {});
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const ChildrenStarted());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const ChildUnlinkRequested('a'));
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        expect(bloc.state.children.map((c) => c.id), ['b']);
        expect(bloc.state.unlinkingChildId, isNull);
      },
    );

    blocTest<ChildrenBloc, ChildrenState>(
      'rolls back the optimistic remove on API failure',
      setUp: () {
        when(() => repo.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        when(() => repo.unlinkChild('a')).thenThrow(Exception('500'));
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const ChildrenStarted());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const ChildUnlinkRequested('a'));
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        // Both children should still be present after rollback.
        expect(bloc.state.children, [childA, childB]);
        expect(bloc.state.unlinkSection.isFailure, isTrue);
      },
    );
  });
}
