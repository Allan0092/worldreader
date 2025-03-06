part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadLibrary extends LibraryEvent {}
