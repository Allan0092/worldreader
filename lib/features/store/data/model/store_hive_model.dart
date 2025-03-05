import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:worldreader/app/constants/hive_table_constant.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

part 'store_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.storeTableId)
class StoreHiveModel extends Equatable {
  @HiveField(0)
  final String bookId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String coverURL;
  @HiveField(3)
  final String author;
  @HiveField(4)
  final bool verifiedStatus;

  const StoreHiveModel({
    required this.bookId,
    required this.title,
    required this.coverURL,
    required this.author,
    required this.verifiedStatus,
  });

  const StoreHiveModel.initial()
      : bookId = '',
        title = '',
        coverURL = '',
        author = '',
        verifiedStatus = false;

  factory StoreHiveModel.fromEntity(BookEntity entity) {
    return StoreHiveModel(
      bookId: entity.bookId,
      title: entity.title,
      coverURL: entity.coverURL,
      author: entity.author,
      verifiedStatus: entity.verifiedStatus,
    );
  }

  BookEntity toEntity() {
    return BookEntity(
      bookId: bookId,
      title: title,
      author: author,
      coverURL: coverURL,
      verifiedStatus: verifiedStatus,
    );
  }

  @override
  List<Object?> get props => [bookId, title, coverURL, author, verifiedStatus];
}
