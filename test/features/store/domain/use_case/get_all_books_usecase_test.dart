import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/use_case/get_all_books_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockBookRepository repository;
  late GetAllBooksUseCase useCase;

  setUp(() {
    repository = MockBookRepository();
    useCase = GetAllBooksUseCase(repository: repository);
  });

  const tBook1 = BookEntity(
      bookId: "1",
      title: "A book to read",
      author: "Yukio Mishima",
      coverURL: "coverPage.png",
      verifiedStatus: true);

  const tBook2 = BookEntity(
      bookId: "2",
      title: "Do not Read",
      author: "Robert",
      coverURL: "doCover.png",
      verifiedStatus: false);

  final tBooks = [tBook1, tBook2];

  test("List down all the book", () async {
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(tBooks));

    final result = await useCase();

    expect(result, Right(tBooks));

    verify(() => repository.getStoreBooks()).called(1);
  });
}
