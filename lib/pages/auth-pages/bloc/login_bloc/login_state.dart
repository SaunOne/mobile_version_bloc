part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final String token;
  final int role;
  final User user;
  LoginSuccess(this.token,this.role,this.user);
}

final class LoginLoading extends LoginState {
  
}

final class LoginFailed extends LoginState {

}
