import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../screens/auth/sign_up_options.dart';
import '../screens/auth/sign_up_business.dart';
import '../screens/auth/sign_up.dart';
import '../screens/auth/log_in.dart';
import '../screens/auth/subscription_business.dart';
import '../screens/destinations_screen.dart';
import '../screens/saved_screen.dart';
import '../screens/chatbot_screen.dart';
import '../screens/bookings_screen.dart';
import '../screens/maps_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/where_to_next_screen.dart';
import '../screens/detailed_destination_screen.dart';
import '../widgets/app_layout.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: ConfigRoutes.signUpOptions,
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loggedIn = authProvider.isLoggedIn;
    final isSplash = state.fullPath == '/splash';
    final isAuthRoute = [
      ConfigRoutes.login,
      ConfigRoutes.signUp,
      ConfigRoutes.signUpOptions,
      ConfigRoutes.signUpBusiness,
      ConfigRoutes.subscriptionBusiness,
    ].contains(state.fullPath);

    if (!loggedIn && !isAuthRoute && !isSplash) {
      return ConfigRoutes.login;
    }

    if (loggedIn && isAuthRoute) {
      return ConfigRoutes.whereToNext;
    }

    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: ConfigRoutes.login, builder: (_, __) => const Login()),
    GoRoute(path: ConfigRoutes.signUp, builder: (_, __) => const SignUp()),
    GoRoute(
      path: ConfigRoutes.signUpOptions,
      builder: (_, __) => const SignUpOptions(),
    ),
    GoRoute(
      path: ConfigRoutes.signUpBusiness,
      builder: (_, __) => const SignUpBusiness(),
    ),
    GoRoute(
      path: ConfigRoutes.subscriptionBusiness,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        return SubscriptionBusiness(
          email: args['email'] ?? '',
          password: args['password'] ?? '',
          businessCategory: args['category_id'] ?? 0,
          ownerName: args['ownerName'] ?? 'Unknown',
          businessName: args['businessName'] ?? '',
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) => AppLayout(child: child),
      routes: [
        GoRoute(
          path: ConfigRoutes.whereToNext,
          builder: (_, __) => const WhereToNextScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.profile,
          builder: (_, __) => const ProfileScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.destinations,
          builder: (_, __) => const DestinationsScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.saved,
          builder: (_, __) => const SavedScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.chatbot,
          builder: (_, __) => const ChatbotScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.maps,
          builder: (_, __) => const MapsScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.bookings,
          builder: (_, __) => const BookingsScreen(),
        ),
        GoRoute(
          path: ConfigRoutes.detailedDestination,
          builder: (_, __) => const DetailedDestinationScreen(),
        ),
      ],
    ),
  ],
);
