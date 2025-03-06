import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/library/domain/entity/library_entity.dart';
import 'package:worldreader/features/library/domain/repository/library_repository.dart';

class GetUserLibraryUseCase {
  final ILibraryRepository repository;

  GetUserLibraryUseCase({required this.repository});

  Future<Either<Failure, List<LibraryEntity>>> call() async {
    return await repository.getUserLibrary();
  }
}
