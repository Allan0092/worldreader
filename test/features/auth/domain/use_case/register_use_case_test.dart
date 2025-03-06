import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';
import 'package:worldreader/features/auth/domain/use_case/register_use_case.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUseCase(repository);
    registerFallbackValue(AuthEntity.empty());
  });

  const params = RegisterUserParams.empty();

  test("should call the [RegisterAuthRepo.registerUser]", () async {
    when(() => repository.registerUser(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

    expect(result, const Right(null));

    verify(() => repository.registerUser(any())).called(1);

    verifyNoMoreInteractions(repository);
  });
}
