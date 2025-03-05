// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreApiModel _$StoreApiModelFromJson(Map<String, dynamic> json) =>
    StoreApiModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      coverURL: json['coverURL'] as String,
      author: json['author'] as String,
      verifiedStatus: json['verifiedStatus'] as bool,
    );

Map<String, dynamic> _$StoreApiModelToJson(StoreApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'coverURL': instance.coverURL,
      'author': instance.author,
      'verifiedStatus': instance.verifiedStatus,
    };
