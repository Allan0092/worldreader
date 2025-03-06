import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

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

  factory StoreApiModel.fromJson(Map<String, dynamic> json) {
    return StoreApiModel(
        id: json['_id'],
        title: json['title'],
        coverURL: json['coverURL'],
        author: json['author'],
        verifiedStatus: json['verifiedStatus']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'coverURL': coverURL,
      'author': author,
      'verifiedStatus': verifiedStatus,
    };
  }

  BookEntity toEntity() {
    return BookEntity(
      bookId: id,
      title: title,
      author: author,
      coverURL: coverURL,
      verifiedStatus: verifiedStatus,
    );
  }

  static StoreApiModel fromEntity(BookEntity entity) {
    return StoreApiModel(
        id: entity.bookId,
        title: entity.title,
        coverURL: entity.coverURL,
        author: entity.author,
        verifiedStatus: entity.verifiedStatus);
  }

  static List<BookEntity> toEntityList(List<StoreApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [id, title, coverURL, author, verifiedStatus];
}
