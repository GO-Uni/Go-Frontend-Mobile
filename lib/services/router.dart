import 'package:go_router/go_router.dart';
import '../screens/sign_up_options.dart';
import '../screens/sign_up_business.dart';
import '../screens/sign_up.dart';
import '../screens/log_in.dart';
import '../screens/subscription_business.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: ConfigRoutes.subscriptionBusiness,
  routes: [
    GoRoute(
      path: ConfigRoutes.signUpOptions,
      builder: (context, state) => SignUpOptions(),
    ),
    GoRoute(
      path: ConfigRoutes.signUpBusiness,
      builder: (context, state) => SignUpBusiness(),
    ),
    GoRoute(path: ConfigRoutes.signUp, builder: (context, state) => SignUp()),
    GoRoute(path: ConfigRoutes.login, builder: (context, state) => Login()),
    GoRoute(
      path: ConfigRoutes.subscriptionBusiness,
      builder: (context, state) => SubscriptionBusiness(),
    ),
  ],
);
