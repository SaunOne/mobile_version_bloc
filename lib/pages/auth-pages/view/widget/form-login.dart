import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/pages/auth-pages/bloc/login_bloc/login_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        
        if (state is LoginSuccess) {
          if (state.role == 1) {
            AnimatedSnackBar.rectangle(
                    'Selamat', 'Anda Berhasil Login Sebagai Owner',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.light,
                    duration: Duration(seconds: 2))
                .show(
              context,
            );
            Navigator.pushNamed(context, '/mo');
            // Navigator.pushNamed(context, '/home-owner');
          } else if (state.role == 2) {
            AnimatedSnackBar.rectangle(
                    'Selamat', 'Anda Berhasil Login Sebagai MO',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.light,
                    duration: Duration(seconds: 2))
                .show(
              context,
            );
            Navigator.pushNamed(context, '/mo');
            // Navigator.pushNamed(context, '/home-mo');
          } else if (state.role == 3) {
            AnimatedSnackBar.rectangle(
                    'Selamat', 'Anda Berhasil Login Sebagai Admin',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.light,
                    duration: Duration(seconds: 2))
                .show(
              context,
            );
            
            // Navigator.pushNamed(context, '/home-admin');
          } else if (state.role == 4) {
            AnimatedSnackBar.rectangle(
                    'Selamat', 'Anda Berhasil Login Sebagai Customer',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.light,
                    duration: Duration(seconds: 2))
                .show(
              context,
            );
            print('state : ${state.user.id}');
            OneSignal.login(state.user.id.toString());
            Navigator.pushNamed(context, '/user');
          }
        } else if(state is LoginFailed){
          AnimatedSnackBar.rectangle(
                  'Mohon Maaf', 'Username dan password masih salah',
                  type: AnimatedSnackBarType.error,
                  brightness: Brightness.light,
                  duration: Duration(seconds: 2))
              .show(
            context,
          );
        }
      },
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              TextFormField(
                scrollPadding: const EdgeInsets.only(bottom: 20),
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == '' || value!.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                scrollPadding: const EdgeInsets.only(bottom: 20),
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == '' || value!.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 1,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text(
                  "Lupa Password",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  loginBloc.add(
                    UserLogin(
                        email: emailController.text,
                        password: passwordController.text),
                  );
                },
                child: state is LoginLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.brown, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
