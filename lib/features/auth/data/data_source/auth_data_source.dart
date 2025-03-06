import 'dart:io';

import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<String> getCurrentUserId(String userEmail);

  Future<String> uploadProfilePicture(File file);
}
