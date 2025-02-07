import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:worldreader/app/usecase/usecase.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';
import 'package:worldreader/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.image,
  });

  const RegisterUserParams.initial({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.firstName,
      lName: params.lastName,
      email: params.email,
      password: params.password,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
