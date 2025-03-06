import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:worldreader/app/constants/hive_table_constant.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String password;
  @HiveField(6)
  final List<String>? library;

  AuthHiveModel({
    String? userId,
    required this.fName,
    required this.lName,
    this.image,
    required this.email,
    required this.password,
    this.library,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  AuthHiveModel.initial()
      : userId = '',
        fName = '',
        lName = '',
        image = '',
        email = '',
        password = '',
        library = List.empty();

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      email: entity.email,
      password: entity.password,
      library: entity.library,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fName: fName,
      lName: lName,
      image: image,
      email: email,
      password: password,
      library: library,
    );
  }

  @override
  List<Object?> get props =>
      [userId, fName, lName, image, email, password, library];
}
