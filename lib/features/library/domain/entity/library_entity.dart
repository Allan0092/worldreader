import 'package:equatable/equatable.dart';

class LibraryEntity extends Equatable {
  final String bookId;
  final String title;
  final String coverURL;
  final String? contentURL;
  final DateTime dateAdded;

  const LibraryEntity({
    required this.bookId,
    required this.title,
    required this.coverURL,
    this.contentURL,
    required this.dateAdded,
  });

  factory LibraryEntity.fromJson(Map<String, dynamic> json) {
    return LibraryEntity(
      bookId: json['_id'] as String,
      title: json['title'] as String,
      coverURL: json['coverURL'] as String,
      contentURL: json['contentURL'] as String?,
      dateAdded: DateTime.parse(json['dateAdded'] as String),
    );
  }

  @override
  List<Object?> get props => [bookId, title, coverURL, contentURL, dateAdded];
}
