final class ApiRoutes {
  static const String login = "/login";
  static const String register = "/register";
  static const String categories = "/categories";
  static const String updateProfile = "/profile/edit";

  static String categoryDestinations(String category) {
    return "/destinations/category/$category";
  }
}
