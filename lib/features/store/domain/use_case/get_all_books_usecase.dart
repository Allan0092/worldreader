import 'package:dartz/dartz.dart';
import 'package:worldreader/app/usecase/usecase.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/repository/store_repository.dart';

class GetAllBooksUseCase implements UsecaseWithoutParams<List<BookEntity>> {
  final IStoreRepository repository;

  GetAllBooksUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BookEntity>>> call() {
    return repository.getStoreBooks();
  }
}
