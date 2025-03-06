part of 'store_bloc.dart';

@immutable
sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

final class LoadBooks extends StoreEvent {}

final class AddToLibrary extends StoreEvent {
  final BuildContext context;
  final String bookId;

  const AddToLibrary({required this.bookId, required this.context});

  @override
  List<Object?> get props => [bookId, context];
}
