import '../model/session_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthenticatedState extends AuthState {
  final SessionModel model;

  AuthenticatedState({required this.model});
}

class UnauthenticatedState extends AuthState {}
