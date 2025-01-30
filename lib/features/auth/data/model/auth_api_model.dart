import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worldreader/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  // ignore: non_constant_identifier_names
  final String first_name;
  // ignore: non_constant_identifier_names
  final String last_name;
  final String email;
  final String password;

  const AuthApiModel({
    this.id,
    // ignore: non_constant_identifier_names
    required this.first_name,
    // ignore: non_constant_identifier_names
    required this.last_name,
    required this.email,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
        fName: first_name, lName: last_name, email: email, password: password);
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        first_name: entity.fName,
        last_name: entity.lName,
        email: entity.email,
        password: entity.password);
  }

  @override
  List<Object?> get props => [id, first_name, last_name, email, password];
}
