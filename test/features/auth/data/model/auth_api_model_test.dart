import 'package:flutter_test/flutter_test.dart';
import 'package:worldreader/features/auth/data/model/auth_api_model.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthApiModel Tests', () {
    final json = {
      '_id': '123',
      'first_name': 'user1',
      'last_name': 'last1',
      'email': 'user1@email.com',
      'password': 'password1',
      'image': 'profile.jpg',
    };

    test('should convert from JSON correctly', () {
      final model = AuthApiModel.fromJson(json);

      expect(model.id, '123');
      expect(model.fName, 'user1');
      expect(model.lName, 'last1');
      expect(model.email, 'user1@email.com');
      expect(model.password, 'password1');
      expect(model.image, 'profile.jpg');
    });

    test('should convert to JSON correctly', () {
      final model = AuthApiModel.fromJson(json);
      final convertedJson = model.toJson();

      expect(convertedJson['_id'], '123');
      expect(convertedJson['first_name'], 'user1');
      expect(convertedJson['last_name'], 'last1');
      expect(convertedJson['email'], 'user1@email.com');
      expect(convertedJson['password'], 'password1');
    });

    test('should convert between Entity and Model correctly', () {
      const entity = AuthEntity(
        fName: 'user1',
        lName: "last1",
        email: 'user1@email.com',
        password: 'password1',
        image: 'profile.jpg',
      );

      final model = AuthApiModel.fromEntity(entity);
      final convertedEntity = model.toEntity();

      expect(convertedEntity, entity);
    });
  });
}
