import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:worldreader/app/shared_prefs/token_shared_prefs.dart';
import 'package:worldreader/app/usecase/usecase.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/auth/domain/repository/auth_repository.dart';

class LoginUserParams extends Equatable {
  final String email;
  // final String userId;

  const LoginUserParams({required this.email});

  const LoginUserParams.initial() : email = '';

  @override
  List<Object?> get props => [email];
}

String? extractEmailFromToken(String token) {
  try {
    final payload = Jwt.parseJwt(token); // Decodes the token into a Map
    return payload['email'] as String?; // Access the 'email' claim
  } catch (e) {
    // print('Error decoding JWT: $e');
    return null;
  }
}

class GetUserIdByEmail implements UsecaseWithoutParams<String> {
  final TokenSharedPrefs tokenSharedPrefs;
  final IAuthRepository repository;

  GetUserIdByEmail({required this.tokenSharedPrefs, required this.repository});

  @override
  Future<Either<Failure, String>> call() async {
    return await tokenSharedPrefs.getToken().then((value) async {
      return await value.fold((failure) async => Left(failure), (token) async {
        String email = extractEmailFromToken(token) ?? "";
        return await repository.getCurrentUserId(email).then((value) async {
          return value.fold((failure) {
            return Left(failure);
          }, (userId) {
            tokenSharedPrefs.saveUserId(userId);
            return Right(userId);
          });
        });
      });
    });
  }
}
