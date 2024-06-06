import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/pages/auth-pages/view/login.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/layout-mo.dart';
import 'package:mobile_version_bloc/pages/test.dart';
import 'package:mobile_version_bloc/pages/user-pages/view/content/history.dart';
import 'package:mobile_version_bloc/pages/user-pages/view/layour-user.dart';

Map<String, Widget Function(BuildContext)> routes = {
  //auth-pages
  '/login': (context) => Login(),
  '/test': (context) => Test(),

  //guest-pages

  //admin-pages

  //user-pages
  '/user': (context) => LayoutUser(),
  '/user/history': (context) => History(),

  //mo-pages
  '/mo': (context) => LayoutMO(),

  //owner-pages
};
