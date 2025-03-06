// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_books_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBooksDTO _$GetAllBooksDTOFromJson(Map<String, dynamic> json) =>
    GetAllBooksDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => StoreApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBooksDTOToJson(GetAllBooksDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
