class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";
// ============================ Auth Routes ==================================

  static const String registerUser = "user/"; // POST
  static const String loginUser = "user/login"; // POST
  static const String updateUser = "user/update"; // POST
  static const String findUserByEmail = "user/findByEmail"; // POST
  static const String uploadImage = "imageUpload"; //
}
