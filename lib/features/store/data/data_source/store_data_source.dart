import 'package:worldreader/features/store/domain/entity/book_entity.dart';

abstract interface class IStoreDataSource {
  Future<List<BookEntity>> getStoreBooks();
  Future<void> addToLibrary(String userId, String bookId);
}
