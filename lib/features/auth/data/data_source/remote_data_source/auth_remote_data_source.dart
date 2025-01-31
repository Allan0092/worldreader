import 'dart:io';

import "package:dio/dio.dart";
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/features/auth/data/data_source/auth_data_source.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.loginUser,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error ${e.toString()}");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.registerUser,
        data: {
          "first_name": user.fName,
          "last_name": user.lName,
          "email": user.email,
          "password": user.password,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.toString()}");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
