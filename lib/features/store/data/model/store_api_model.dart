import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

part 'store_api_model.g.dart';

@JsonSerializable()
class StoreApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  final String title;
  final String coverURL;
  final String author;
  final bool verifiedStatus;

  const StoreApiModel({
    required this.id,
    required this.title,
    required this.coverURL,
    required this.author,
    required this.verifiedStatus,
  });

  factory StoreApiModel.formJson(Map<String, dynamic> json) =>
      _$StoreApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreApiModelToJson(this);

  BookEntity toEntity() {
    return BookEntity(
      bookId: id,
      title: title,
      author: author,
      coverURL: coverURL,
      verifiedStatus: verifiedStatus,
    );
  }

  factory StoreApiModel.fromEntity(BookEntity entity) {
    return StoreApiModel(
        id: entity.bookId,
        title: entity.title,
        coverURL: entity.coverURL,
        author: entity.author,
        verifiedStatus: entity.verifiedStatus);
  }

  @override
  List<Object?> get props => [id, title, coverURL, author, verifiedStatus];
}
