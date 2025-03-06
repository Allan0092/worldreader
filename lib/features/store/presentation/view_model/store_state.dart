part of 'store_bloc.dart';

class StoreState extends Equatable {
  final List<BookEntity> books;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const StoreState({
    required this.books,
    required this.isLoading,
    this.error,
    this.successMessage,
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
    String? successMessage,
  }) {
    return StoreState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [books, isLoading, error, successMessage];
}
