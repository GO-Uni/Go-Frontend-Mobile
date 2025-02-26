//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/sign_up_options.dart';
import '../screens/sign_up_business.dart';
import '../screens/log_in.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/sign-up-options',
      builder: (context, state) => SignUpOptions(),
    ),
    GoRoute(
      path: '/sign-up-business',
      builder: (context, state) => SignUpBusiness(),
    ),
    GoRoute(path: '/', builder: (context, state) => Login()),
  ],
);
