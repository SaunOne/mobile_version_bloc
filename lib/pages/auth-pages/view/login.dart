import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/pages/auth-pages/bloc/login_bloc/login_bloc.dart';
import 'package:mobile_version_bloc/pages/auth-pages/view/widget/form-login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  // color: ColorPallate.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Logo
                      Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo1.png'),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            const Text("Login To Your Account"),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 50),
                                child: FormLogin(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
