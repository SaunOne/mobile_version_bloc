


import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/pages/auth-pages/view/login.dart';
import 'package:mobile_version_bloc/pages/test.dart';
import 'package:mobile_version_bloc/pages/user-pages/view/layour-user.dart';

Map<String, Widget Function(BuildContext)> routes = {
  
  //auth-pages
  '/login' : (context) => Login(),
  '/test' : (context) => Test(),

  //user-pages
  '/user' : (context) => LayoutUser() 
};