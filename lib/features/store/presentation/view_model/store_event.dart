part of 'store_bloc.dart';

@immutable
sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

final class LoadBooks extends StoreEvent {}
