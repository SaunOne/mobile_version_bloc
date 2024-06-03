part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class UserLogin extends LoginEvent {

  UserLogin({required this.email, required this.password});
  String email;
  String password;
  
}
