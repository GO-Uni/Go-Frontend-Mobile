//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/sign_up_options.dart';
import '../screens/sign_up_business.dart';
import '../screens/sign_up.dart';
import '../screens/log_in.dart';
import '../screens/subscription_business.dart';

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
    GoRoute(path: '/signup', builder: (context, state) => SignUp()),
    GoRoute(path: '/login', builder: (context, state) => Login()),
    GoRoute(path: '/', builder: (context, state) => SubscriptionBusiness()),
  ],
);
