final class ApiRoutes {
  static const String login = "/login";
  static const String register = "/register";
  static const String categories = "/categories";
  static const String updateProfile = "/profile/edit";
  static const String destinations = "/destinations";

  static String categoryDestinations(String category) {
    return "/destinations/category/$category";
  }

  static const String rateDestination = "/activity/rate";
  static const String saveDestination = "/activity/save";
  static const String unsaveDestination = "/activity/unsave";
  static const String reviewDestination = "/activity/review";

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
    return '/api/destinations/name/$name';
  }
}
