import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/use_case/get_all_books_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetAllBooksUseCase _getAllBooksUseCase;

  StoreBloc({
    required GetAllBooksUseCase getAllBooksUseCase,
  })  : _getAllBooksUseCase = getAllBooksUseCase,
        super(StoreState.initial()) {
    on<LoadBooks>(_onLoadBooks);

    add(LoadBooks());
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<StoreState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllBooksUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: true, error: failure.message)),
      (books) => emit(state.copyWith(isLoading: false, books: books)),
    );
  }
}
