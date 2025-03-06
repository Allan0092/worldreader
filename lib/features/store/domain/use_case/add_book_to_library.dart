import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:worldreader/app/usecase/usecase.dart';
import 'package:worldreader/core/error/failure.dart';
import 'package:worldreader/features/store/domain/repository/store_repository.dart';

class AddBookToLibraryParams extends Equatable {
  final String userId;
  final String bookId;

  const AddBookToLibraryParams({required this.userId, required this.bookId});

  const AddBookToLibraryParams.empty()
      : userId = "_empty.string",
        bookId = "_empty.string";

  @override
  List<Object?> get props => [];
}

class AddBookToLibraryUseCase
    implements UsecaseWithParams<void, AddBookToLibraryParams> {
  final IStoreRepository storeRepository;
  // TODO

  AddBookToLibraryUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, void>> call(AddBookToLibraryParams params) async {
    return await storeRepository.addToLibrary(params.userId, params.bookId);
  }
}
