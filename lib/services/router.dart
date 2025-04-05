import 'package:go_router/go_router.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
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
import '../screens/loading_screen.dart';
import '../widgets/app_layout.dart';
import 'routes.dart';

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    refreshListenable: authProvider,
    initialLocation:
        (authProvider.isLoggedIn || authProvider.isGuest)
            ? ConfigRoutes.whereToNext
            : ConfigRoutes.signUpOptions,

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
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) => AppLayout(child: child),
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
            builder: (context, state) => (ProfileScreen()),
          ),
          GoRoute(
            path: ConfigRoutes.destinations,
            builder: (context, state) => DestinationsScreen(),
          ),
          GoRoute(
            path: ConfigRoutes.saved,
            builder: (context, state) => SavedScreen(),
          ),

          GoRoute(
            path: ConfigRoutes.detailedDestination,
            builder: (context, state) => DetailedDestinationScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoading = authProvider.isLoading;
      final isLoggedIn = authProvider.isLoggedIn;
      final isGuest = authProvider.isGuest;
      final currentLocation = state.uri.path;

      if (isLoading) {
        if (currentLocation != '/loading') return '/loading';
        return null;
      }

      if (!isLoading && currentLocation == '/loading') {
        return (isLoggedIn || isGuest)
            ? ConfigRoutes.whereToNext
            : ConfigRoutes.signUpOptions;
      }

      final isAuthRoute =
          currentLocation == ConfigRoutes.login ||
          currentLocation == ConfigRoutes.signUpOptions;

      if (!isLoggedIn && !isGuest && !isAuthRoute) {
        return ConfigRoutes.signUpOptions;
      }

      if (isLoggedIn && isAuthRoute) {
        return ConfigRoutes.whereToNext;
      }

      return null;
    },
  );
}
