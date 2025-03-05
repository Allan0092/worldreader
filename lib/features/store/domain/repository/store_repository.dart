import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

abstract interface class IStoreRepository {
  Future<Either<Failure, List<BookEntity>>> getStoreBooks();
}
