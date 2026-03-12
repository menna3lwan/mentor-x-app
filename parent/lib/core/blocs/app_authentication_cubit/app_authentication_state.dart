part of 'app_authentication_cubit.dart';

final class AppAuthenticationState extends Equatable {
  final ParentEntity? user;

  const AppAuthenticationState({this.user});

  bool get isAuthenticated => user != null;

  @override
  List<Object?> get props => [user];
}
