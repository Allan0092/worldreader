import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/repository/store_repository.dart';

class GetStoreBooksUseCase {
  final IStoreRepository repository;

  GetStoreBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call() async {
    return await repository.getStoreBooks();
  }
}
