class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
// ============================ Auth Routes ==================================

  static const String registerUser = "/api/user/"; // POST
  static const String loginUser = "/api/user/login"; // POST
  static const String updateUser = "/api/user/update"; // POST
  static const String findUserByEmail = "/api/user/findByEmail"; // POST
  static const String uploadImage = "/auth/uploadImage"; //
}
