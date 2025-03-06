import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/library/domain/entity/library_entity.dart';
import 'package:worldreader/features/library/domain/use_case/get_user_library_usecase.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetUserLibraryUseCase _getUserLibraryUseCase;

  LibraryBloc({required GetUserLibraryUseCase getUserLibraryUseCase})
      : _getUserLibraryUseCase = getUserLibraryUseCase,
        super(LibraryState.initial()) {
    on<LoadLibrary>(_onLoadLibrary);
  }

  Future<void> _onLoadLibrary(
      LoadLibrary event, Emitter<LibraryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _getUserLibraryUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (library) => emit(state.copyWith(isLoading: false, library: library)),
    );
  }
}
