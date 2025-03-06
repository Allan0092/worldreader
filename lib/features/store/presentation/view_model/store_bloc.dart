import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/app/shared_prefs/token_shared_prefs.dart';
import 'package:worldreader/core/common/show_bottom_snack_bar.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/domain/use_case/add_book_to_library.dart';
import 'package:worldreader/features/store/domain/use_case/get_all_books_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetAllBooksUseCase _getAllBooksUseCase;
  final AddBookToLibraryUseCase _addBookToLibraryUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;
  final Dio _dio;

  StoreBloc({
    required GetAllBooksUseCase getAllBooksUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
    required AddBookToLibraryUseCase addBookToLibraryUseCase,
    required Dio dio,
  })  : _getAllBooksUseCase = getAllBooksUseCase,
        _addBookToLibraryUseCase = addBookToLibraryUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        _dio = dio,
        super(StoreState.initial()) {
    on<LoadBooks>(_onLoadBooks);
    on<AddToLibrary>(_onAddToLibrary);

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

  Future<void> _onAddToLibrary(
      AddToLibrary event, Emitter<StoreState> emit) async {
    // emit(state.copyWith(isLoading: true));
    try {
      await _tokenSharedPrefs.getToken().then((value) {
        value.fold((error) {
          emit(state.copyWith(
              isLoading: false, error: "error adding to library"));
        }, (token) async {
          if (token == "") throw Exception("No Authentication token found");
          final payload = Jwt.parseJwt(token);
          final userId = payload['id'] as String?;
          if (userId == null) throw Exception("UserId not found in token");

          final response = await _dio.post(
            ApiEndpoints.addToLibrary,
            data: {'userId': userId, 'bookId': event.bookId},
            options: Options(
              headers: {'Authorization': 'Bearer $token'},
            ),
          );

          if (response.statusCode == 200) {
            emit(state.copyWith(isLoading: false));
            showBottomSnackBar(
                context: event.context, message: "Book added success");
          } else {
            throw Exception("Failed to Add book ${response.statusMessage}");
          }
        });
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "error adding to library"));
    }
    // final result = await _addBookToLibraryUseCase()
  }
}
