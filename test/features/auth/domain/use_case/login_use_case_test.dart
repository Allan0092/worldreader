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

  // Existing Test
  test("login and check credentials with correct email and password", () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

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
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  // Additional Tests
  test("login with different valid email and password", () async {
    const diffEmail = "newuser@email.com";
    const diffPassword = "newpass@456";
    const diffParams = LoginParams(email: diffEmail, password: diffPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      if (email == diffEmail && password == diffPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(diffParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(diffEmail, diffPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with email containing special characters", () async {
    const specialEmail = "user+test@email.com";
    const specialParams = LoginParams(email: specialEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == specialEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(specialParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(specialEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with password containing special characters", () async {
    const specialPassword = "pass@#%789";
    const specialParams = LoginParams(email: email, password: specialPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final password = invocation.positionalArguments[1] as String;
      if (password == specialPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(specialParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, specialPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with long email and password", () async {
    const longEmail = "verylongemailaddressforuser@exampledomain.com";
    const longPassword = "longpasswordwithmanycharacters123!";
    const longParams = LoginParams(email: longEmail, password: longPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      if (email == longEmail && password == longPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(longParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(longEmail, longPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with different token value", () async {
    const newToken = "new_token_123";
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(newToken));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      if (email == email && password == password) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(loginParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with uppercase email", () async {
    const upperEmail = "EXAMPLE@EMAIL.COM";
    const upperParams = LoginParams(email: upperEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == upperEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(upperParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(upperEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with mixed case password", () async {
    const mixedPassword = "PassWord@123";
    const mixedParams = LoginParams(email: email, password: mixedPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final password = invocation.positionalArguments[1] as String;
      if (password == mixedPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(mixedParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, mixedPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with short password", () async {
    const shortPassword = "pass1";
    const shortParams = LoginParams(email: email, password: shortPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final password = invocation.positionalArguments[1] as String;
      if (password == shortPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(shortParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, shortPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with email having numbers", () async {
    const numEmail = "user123@email.com";
    const numParams = LoginParams(email: numEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == numEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(numParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(numEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with different domain email", () async {
    const diffDomainEmail = "user@differentdomain.org";
    const diffDomainParams =
        LoginParams(email: diffDomainEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == diffDomainEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(diffDomainParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(diffDomainEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with token containing special characters", () async {
    const specialToken = "token@#%123";
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(specialToken));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      if (email == email && password == password) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(loginParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with numeric password", () async {
    const numPassword = "12345678";
    const numParams = LoginParams(email: email, password: numPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final password = invocation.positionalArguments[1] as String;
      if (password == numPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(numParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, numPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with email having underscore", () async {
    const underscoreEmail = "user_name@email.com";
    const underscoreParams =
        LoginParams(email: underscoreEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == underscoreEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(underscoreParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(underscoreEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with long token", () async {
    const longToken = "very_long_token_abcdefghijklmnopqrstuvwxyz1234567890";
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(longToken));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      if (email == email && password == password) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(loginParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with email having hyphen", () async {
    const hyphenEmail = "user-name@email.com";
    const hyphenParams = LoginParams(email: hyphenEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == hyphenEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(hyphenParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(hyphenEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with password containing spaces", () async {
    const spacePassword = "pass word@123";
    const spaceParams = LoginParams(email: email, password: spacePassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final password = invocation.positionalArguments[1] as String;
      if (password == spacePassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(spaceParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, spacePassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with email from different provider", () async {
    const providerEmail = "user@yahoo.com";
    const providerParams =
        LoginParams(email: providerEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == providerEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(providerParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(providerEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with minimal length password", () async {
    const minPassword = "pass";
    const minParams = LoginParams(email: email, password: minPassword);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final password = invocation.positionalArguments[1] as String;
      if (password == minPassword) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(minParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, minPassword)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with email having multiple dots", () async {
    const dotEmail = "user.name.dot@email.com";
    const dotParams = LoginParams(email: dotEmail, password: password);

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      if (email == dotEmail) {
        return const Right("Login Success");
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(dotParams);

    expect(result, const Right("Login Success"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(dotEmail, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });

  test("login with different success message", () async {
    const successMessage = "User Authenticated Successfully";
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      if (email == email && password == password) {
        return const Right(successMessage);
      }
      return const Left(ApiFailure(message: "Invalid credentials"));
    });

    final result = await usecase(loginParams);

    expect(result, const Right(successMessage));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
  });
}
