part of 'store_bloc.dart';

class StoreState extends Equatable {
  final List<BookEntity> books;
  final bool isLoading;
  final String? error;

  const StoreState({
    required this.books,
    required this.isLoading,
    this.error,
  });

  factory StoreState.initial() {
    return const StoreState(
      books: [],
      isLoading: false,
    );
  }

  StoreState copyWith({
    List<BookEntity>? books,
    bool? isLoading,
    String? error,
  }) {
    return StoreState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [books, isLoading, error];
}
