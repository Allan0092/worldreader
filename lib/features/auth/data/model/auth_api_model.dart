import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: "first_name")
  final String fName;
  @JsonKey(name: "last_name")
  final String lName;
  final String email;
  final String password;

  const AuthApiModel({
    this.id,
    // ignore: non_constant_identifier_names
    required this.fName,
    // ignore: non_constant_identifier_names
    required this.lName,
    required this.email,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
        fName: fName, lName: lName, email: email, password: password);
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        fName: entity.fName,
        lName: entity.lName,
        email: entity.email,
        password: entity.password);
  }

  @override
  List<Object?> get props => [id, fName, lName, email, password];
}
