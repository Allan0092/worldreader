import 'package:worldreader/core/network/hive_service.dart';
import 'package:worldreader/features/store/data/data_source/store_data_source.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

class StoreLocalDataSource implements IStoreDataSource {
  final HiveService _hiveService;

  StoreLocalDataSource(this._hiveService);

  @override
  Future<List<BookEntity>> getStoreBooks() {
    try {
      return _hiveService.getAllBooks().then(
        (value) {
          return value.map((e) => e.toEntity()).toList();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addToLibrary(String userId, String bookId) {
    // TODO: implement addToLibrary
    throw UnimplementedError();
  }
}
