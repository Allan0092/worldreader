import 'package:json_annotation/json_annotation.dart';
import 'package:worldreader/features/store/data/model/store_api_model.dart';

part 'get_all_books_dto.g.dart';

@JsonSerializable()
class GetAllBooksDTO {
  final bool success;
  final int count;
  final List<StoreApiModel> data;

  GetAllBooksDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllBooksDTOToJson(this);

  factory GetAllBooksDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllBooksDTOFromJson(json);
}
