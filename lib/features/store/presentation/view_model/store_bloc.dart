import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/app/shared_prefs/token_shared_prefs.dart';
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
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));

    try {
      // Get the token and handle the Either result
      final tokenResult = await _tokenSharedPrefs.getToken();
      late String token;
      tokenResult.fold(
        (error) =>
            throw Exception('Failed to retrieve token: ${error.message}'),
        (usertoken) {
          if (usertoken.isEmpty) {
            throw Exception('No authentication token found');
          }
          token = usertoken;
        },
      );

      // Decode the token to get userId
      final payload = Jwt.parseJwt(token);
      final userId = payload['id'] as String?;
      if (userId == null) throw Exception('User ID not found in token');

      // Make the API call to add the book to the library
      final response = await _dio.post(
        ApiEndpoints.addToLibrary, // Ensure this matches your endpoint name
        data: {'userId': userId, 'bookId': event.bookId},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(
          isLoading: false,
          successMessage: 'Book added to library successfully',
        ));
      } else {
        throw Exception('Failed to add book: ${response.statusMessage}');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to add book: ${e.toString()}',
      ));
    }
  }
}
