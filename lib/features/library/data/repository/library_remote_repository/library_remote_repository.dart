// lib/features/library/data/repository/library_remote_repository.dart
import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/library/data/data_source/remote_data_source/library_remote_data_source.dart';
import 'package:worldreader/features/library/domain/entity/library_entity.dart';
import 'package:worldreader/features/library/domain/repository/library_repository.dart';

class LibraryRemoteRepository implements ILibraryRepository {
  final LibraryRemoteDataSource _remoteDataSource;

  LibraryRemoteRepository(this._remoteDataSource);

  @override
  Future<Either<Failure, List<LibraryEntity>>> getUserLibrary() async {
    try {
      final books = await _remoteDataSource.getUserLibrary();
      return Right(books);
    } catch (e) {
      return Left(
          ApiFailure(message: "Failed to fetch library: ${e.toString()}"));
    }
  }
}
