import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/auth/domain/use_case/login_use_case.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late LoginUseCase usecase;
  late MockTokenSharedPrefs tokenSharedPrefs;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUseCase(repository, tokenSharedPrefs);
  });

  const email = "example@email.com";
  const password = "password@123";
  const token = "token";
  const loginParams = LoginParams(email: email, password: password);

  test("login and check credentials", () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      if (email == 'example@email.com' && password == "password@123") {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid email or password"));
    });
    final result = await usecase(loginParams);

    expect(result, const Right("Login Success"));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, password)).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
