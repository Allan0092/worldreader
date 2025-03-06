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

  // Existing Test
  test("List down all the books", () async {
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(tBooks));

    final result = await useCase();

    expect(result, Right(tBooks));
    verify(() => repository.getStoreBooks()).called(1);
  });

  // Additional Tests
  test("Return empty book list when repository returns no books", () async {
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right(<BookEntity>[]));

    final result = await useCase();

    expect(result, const Right(<BookEntity>[]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return single book when repository provides one book", () async {
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook1]));

    final result = await useCase();

    expect(result, const Right([tBook1]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books in reverse order when repository provides reversed list",
      () async {
    final reversedBooks = [tBook2, tBook1];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(reversedBooks));

    final result = await useCase();

    expect(result, Right(reversedBooks));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return book with different author", () async {
    const tBook3 = BookEntity(
        bookId: "3",
        title: "New Book",
        author: "Jane Austen",
        coverURL: "newCover.png",
        verifiedStatus: true);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook3]));

    final result = await useCase();

    expect(result, const Right([tBook3]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return book with unverified status", () async {
    const tBook4 = BookEntity(
        bookId: "4",
        title: "Unverified Book",
        author: "Anonymous",
        coverURL: "unverified.png",
        verifiedStatus: false);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook4]));

    final result = await useCase();

    expect(result, const Right([tBook4]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with mixed verified statuses", () async {
    const tBook5 = BookEntity(
        bookId: "5",
        title: "Mixed Book",
        author: "Mixed Author",
        coverURL: "mixed.png",
        verifiedStatus: false);
    final mixedBooks = [tBook1, tBook5];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(mixedBooks));

    final result = await useCase();

    expect(result, Right(mixedBooks));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with unique titles", () async {
    const tBook6 = BookEntity(
        bookId: "6",
        title: "Unique Title",
        author: "Unique Author",
        coverURL: "unique.png",
        verifiedStatus: true);
    final uniqueBooks = [tBook1, tBook6];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(uniqueBooks));

    final result = await useCase();

    expect(result, Right(uniqueBooks));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with same coverURL", () async {
    const tBook7 = BookEntity(
        bookId: "7",
        title: "Same Cover",
        author: "Same Author",
        coverURL: "coverPage.png",
        verifiedStatus: false);
    final sameCoverBooks = [tBook1, tBook7];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(sameCoverBooks));

    final result = await useCase();

    expect(result, Right(sameCoverBooks));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with no coverURL", () async {
    const tBook8 = BookEntity(
        bookId: "8",
        title: "No Cover",
        author: "No Author",
        coverURL: "",
        verifiedStatus: true);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook8]));

    final result = await useCase();

    expect(result, const Right([tBook8]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with long titles", () async {
    const tBook9 = BookEntity(
        bookId: "9",
        title: "This is a very long title that exceeds normal length",
        author: "Long Author",
        coverURL: "longCover.png",
        verifiedStatus: true);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook9]));

    final result = await useCase();

    expect(result, const Right([tBook9]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with special characters in title", () async {
    const tBook10 = BookEntity(
        bookId: "10",
        title: "Spéci@l Ch@r",
        author: "Special Author",
        coverURL: "special.png",
        verifiedStatus: false);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook10]));

    final result = await useCase();

    expect(result, const Right([tBook10]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with numeric author", () async {
    const tBook11 = BookEntity(
        bookId: "11",
        title: "Numeric Book",
        author: "Author123",
        coverURL: "numeric.png",
        verifiedStatus: true);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook11]));

    final result = await useCase();

    expect(result, const Right([tBook11]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with empty author", () async {
    const tBook12 = BookEntity(
        bookId: "12",
        title: "Anonymous Book",
        author: "",
        coverURL: "anonymous.png",
        verifiedStatus: false);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook12]));

    final result = await useCase();

    expect(result, const Right([tBook12]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with maximum fields populated", () async {
    const tBook13 = BookEntity(
        bookId: "13",
        title: "Full Book",
        author: "Full Author",
        coverURL: "fullCover.png",
        verifiedStatus: true);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook13]));

    final result = await useCase();

    expect(result, const Right([tBook13]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with minimum fields populated", () async {
    const tBook14 = BookEntity(
        bookId: "14",
        title: "Minimal Book",
        author: "Min Author",
        coverURL: "",
        verifiedStatus: false);
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => const Right([tBook14]));

    final result = await useCase();

    expect(result, const Right([tBook14]));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with duplicate bookId", () async {
    const tBook15 = BookEntity(
        bookId: "1",
        title: "Duplicate Book",
        author: "Dup Author",
        coverURL: "dupCover.png",
        verifiedStatus: true);
    final duplicateBooks = [tBook1, tBook15];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(duplicateBooks));

    final result = await useCase();

    expect(result, Right(duplicateBooks));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with all verified statuses true", () async {
    const tBook16 = BookEntity(
        bookId: "16",
        title: "Verified Book",
        author: "Verified Author",
        coverURL: "verified.png",
        verifiedStatus: true);
    final allVerified = [tBook1, tBook16];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(allVerified));

    final result = await useCase();

    expect(result, Right(allVerified));
    verify(() => repository.getStoreBooks()).called(1);
  });

  test("Return books with all verified statuses false", () async {
    const tBook17 = BookEntity(
        bookId: "17",
        title: "Unverified Book",
        author: "Unverified Author",
        coverURL: "unverified.png",
        verifiedStatus: false);
    final allUnverified = [tBook2, tBook17];
    when(() => repository.getStoreBooks())
        .thenAnswer((_) async => Right(allUnverified));

    final result = await useCase();

    expect(result, Right(allUnverified));
    verify(() => repository.getStoreBooks()).called(1);
  });
}
