//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/sign_up_options.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => SignUpOptions())],
);
