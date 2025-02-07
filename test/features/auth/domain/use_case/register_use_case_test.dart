import 'package:mockito/mockito.dart';
import 'package:worldreader/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // late RegisterUseCase registerUseCase;
  // late MockAuthRepository mockAuthRepository;
  // setUp(() {
  //   mockAuthRepository = MockAuthRepository();
  //   registerUseCase = RegisterUseCase(mockAuthRepository);
  // });

  // testWidgets(
  //   'register use case ...',
  //   (tester) async {
  //     test(
  //       "Register User",
  //       () async {
  //         RegisterUserParams registerUserParams = const RegisterUserParams(
  //           firstName: "user1",
  //           lastName: "last1",
  //           email: "user1@email.com",
  //           password: "password1",
  //         );

  //         AuthEntity user = const AuthEntity(
  //           fName: 'user1',
  //           lName: 'last1',
  //           email: 'user1@email.com',
  //           password: "password1",
  //         );

  //         when(mockAuthRepository.registerUser(user))
  //             .thenAnswer((_) async => Right(user));
  //       },
  //     );
  //   },
  // );
}
