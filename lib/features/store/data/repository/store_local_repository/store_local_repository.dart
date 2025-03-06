import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/store/data/data_source/local_data_source/store_local_data_source.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/repository/store_repository.dart';

class StoreLocalRepository implements IStoreRepository {
  final StoreLocalDataSource _storeLocalDataSource;

  StoreLocalRepository({required StoreLocalDataSource storeLocalDataSource})
      : _storeLocalDataSource = storeLocalDataSource;

  @override
  Future<Either<Failure, List<BookEntity>>> getStoreBooks() {
    try {
      return _storeLocalDataSource.getStoreBooks().then((value) {
        return Right(value);
      });
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> addToLibrary(String userId, String bookId) {
    // TODO: implement addToLibrary
    throw UnimplementedError();
  }
}
