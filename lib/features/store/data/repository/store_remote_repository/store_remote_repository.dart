import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/store/data/data_source/remote_data_source/store_remote_data_source.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/repository/store_repository.dart';

class StoreRemoteRepository implements IStoreRepository {
  final StoreRemoteDataSource _storeRemoteDataSource;

  StoreRemoteRepository(this._storeRemoteDataSource);

  @override
  Future<Either<Failure, List<BookEntity>>> getStoreBooks() async {
    try {
      final books = await _storeRemoteDataSource.getStoreBooks();
      return Right(books);
    } catch (e) {
      return Left(ApiFailure(message: "Book Fetching Failed: ${e.toString()}"));
    }
  }
}
