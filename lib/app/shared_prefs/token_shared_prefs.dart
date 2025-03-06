import 'dart:developer' as console;

import 'package:dartz/dartz.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldreader/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  String? extractEmailFromToken(String token) {
    try {
      final payload = Jwt.parseJwt(token); // Decodes the token into a Map
      return payload['email'] as String?; // Access the 'email' claim
    } catch (e) {
      console.log('Error decoding JWT: $e');
      return null;
    }
  }

  // Future<Either<Failure, void>> getAndSaveUserIdWithOutToken() async {
  //   try {
  //     String token = _sharedPreferences.getString('token') ?? "";

  //   } catch (e) {
  //     return Left(SharedPrefsFailure(message: e.toString()));
  //   }
  // }

  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      return Right(userId ?? '000isThisUserId');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
