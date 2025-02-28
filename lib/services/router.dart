import 'package:go_router/go_router.dart';
import '../screens/auth/sign_up_options.dart';
import '../screens/auth/sign_up_business.dart';
import '../screens/auth/sign_up.dart';
import '../screens/auth/log_in.dart';
import '../screens/auth/subscription_business.dart';

import '../screens/chatbot_screen.dart';
import '../screens/bookings_screen.dart';
import '../screens/maps_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/where_to_next_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: ConfigRoutes.whereToNext,
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

    ShellRoute(
      builder: (context, state, child) => BottomNavBar(child: child),
      routes: [
        GoRoute(
          path: ConfigRoutes.whereToNext,
          builder: (context, state) => WhereToNextScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.bookings,
          builder: (context, state) => BookingsScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.chatbot,
          builder: (context, state) => ChatbotScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.maps,
          builder: (context, state) => MapsScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.profile,
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],
);
