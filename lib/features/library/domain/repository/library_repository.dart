// lib/features/library/domain/repository/library_repository.dart
import 'package:dartz/dartz.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/library/domain/entity/library_entity.dart';

abstract interface class ILibraryRepository {
  Future<Either<Failure, List<LibraryEntity>>> getUserLibrary();
}
