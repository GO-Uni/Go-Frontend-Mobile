final class ApiRoutes {
  static const String login = "/login";
  static const String register = "/register";
  static const String categories = "/categories";
  static const String updateProfile = "/profile/edit";
  static const String destinations = "/destinations";
  static const String me = "/me";
  static const String changeSubscription = "/business/subscription/edit";

  static String categoryDestinations(String category) {
    return "/destinations/category/$category";
  }

  static const String rateDestination = "/activity/rate";
  static const String saveDestination = "/activity/save";
  static const String unsaveDestination = "/activity/unsave";
  static const String reviewDestination = "/activity/review";
  static const String bookDestination = "/activity/book";

  static String getBookingsForBusinessUser(int businessUserId) {
    return '/destinations/bookings/$businessUserId';
  }

  static String getBookings(int userId) {
    return '/user/$userId/bookings/';
  }

  static String chatbot(int userId) {
    return "/$userId/chatbot";
  }

  static String getReviewsDestination(int businessUserId) {
    return "/destinations/reviews/$businessUserId";
  }

  static String getSavedDestination(int userId) {
    return "/user/$userId/saved";
  }

  static String getRecommendedDestination(int userId) {
    return "/recommend-destinations/$userId";
  }

  static String checkIfUserRated(int businessUserId) {
    return "/user/check-rated/$businessUserId";
  }

  static String getDestinationsByName(String name) {
    return '/destinations/name/$name';
  }
}
