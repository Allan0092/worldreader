// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fName: json['first_name'] as String,
      lName: json['last_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String?,
      library:
          (json['library'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.fName,
      'last_name': instance.lName,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'library': instance.library,
    };
