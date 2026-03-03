part of 'app_authentication_cubit.dart';

final class AppAuthenticationState extends Equatable {
  final dynamic user;

  const AppAuthenticationState({this.user});

  @override
  List<Object?> get props => [user];
}
