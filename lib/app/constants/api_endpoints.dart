class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);

  // for real device
  // static const String baseUrl = "http://192.168.1.80:5000/api/";

  // for emulator
  static const String baseUrl = "http://10.0.2.2:5000/api/";
// ============================ Auth Routes ==================================

  static const String registerUser = "user/"; // POST
  static const String loginUser = "user/login"; // POST
  static const String updateUser = "user/update"; // POST
  static const String findUserByEmail = "user/findByEmail"; // POST
  static const String uploadImage = "imageUpload"; // post
  static const String addToLibrary = "user/library/add"; // post

  // ========================= Book Routes ==================================
  static const String getAllPublicBooks = "book/public";
}
