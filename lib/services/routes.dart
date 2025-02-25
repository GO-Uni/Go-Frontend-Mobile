//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/sign_up_options.dart';
import '../screens/sign_up_business.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/1', builder: (context, state) => SignUpOptions()),
    GoRoute(path: '/', builder: (context, state) => SignUpBusiness()),
  ],
);
