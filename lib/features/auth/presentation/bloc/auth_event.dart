part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final SignUpHeaders headers;
  AuthSignUp({required this.headers});
}

final class AuthSignIn extends AuthEvent {
  final SignInHeaders headers;

  AuthSignIn({required this.headers});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
