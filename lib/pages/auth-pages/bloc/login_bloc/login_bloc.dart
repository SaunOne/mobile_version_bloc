import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/repository/auth/apiAuth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLogin>(_onLogin);
  }

  Future<void> _onLogin(UserLogin event, Emitter<LoginState> emit) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User? user;
  
    emit(LoginLoading());

    try {
      print("Masuk sini");
      var value = await Authentication().loginApi(event.email, event.password);

      if (emit.isDone) return; // Check if the emitter is already completed

      if (value.status == 200) {
        await localStorage.setInt('id', value.data!.id);
        await localStorage.setString('token', value.access_token);
        await localStorage.setInt('role', value.data!.id);
        print("masuk");
        print('role : ${value.data!.role!.id_role}');
        print('local : ${value.access_token}');
        if (!emit.isDone)
          emit(LoginSuccess(
              value.access_token,
              value.data!.role!
                  .id_role,value.data!)); // Check if the emitter is already completed before emitting
      } else {
        if (!emit.isDone)
          emit(
              LoginFailed());
              print("login field"); // Check if the emitter is already completed before emitting;
      }
    } catch (error) {
      print('error : $error');
      if (!emit.isDone)
        emit(
            LoginFailed()); // Check if the emitter is already completed before emitting
    }
  }
}
