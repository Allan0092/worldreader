import 'package:flutter_test/flutter_test.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

void main() {
  testWidgets('auth entity creation', (tester) async {
    AuthEntity authEntity = const AuthEntity(
      fName: "user1",
      lName: "last1",
      email: "user1@email.com",
      password: "password1",
    );
    expect(authEntity.fName, "user1");
    expect(authEntity.lName, "last1");
    expect(authEntity.email, "user1@email.com");
    expect(authEntity.password, "password1");
  });
}
