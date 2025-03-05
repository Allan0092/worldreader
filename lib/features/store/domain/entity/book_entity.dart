import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String author;
  final String coverURL;
  final bool verifiedStatus;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.coverURL,
    required this.verifiedStatus,
  });

  @override
  List<Object?> get props => [id, title, author, coverURL, verifiedStatus];
}
