part of 'library_bloc.dart';

class LibraryState extends Equatable {
  final List<LibraryEntity> library;
  final bool isLoading;
  final String? error;

  const LibraryState({
    required this.library,
    required this.isLoading,
    this.error,
  });

  factory LibraryState.initial() {
    return const LibraryState(
      library: [],
      isLoading: false,
    );
  }

  LibraryState copyWith({
    List<LibraryEntity>? library,
    bool? isLoading,
    String? error,
  }) {
    return LibraryState(
      library: library ?? this.library,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [library, isLoading, error];
}
