import 'package:dio/dio.dart';
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/features/store/data/data_source/store_data_source.dart';
import 'package:worldreader/features/store/data/dto/get_all_books_dto.dart';
import 'package:worldreader/features/store/data/model/store_api_model.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

class StoreRemoteDataSource implements IStoreDataSource {
  final Dio _dio;

  StoreRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<BookEntity>> getStoreBooks() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllPublicBooks);
      if (response.statusCode == 200) {
        if (response.data is List) {
          List<dynamic> bookList = response.data;
          return bookList
              .map((bookJson) => StoreApiModel.fromJson(bookJson).toEntity())
              .toList();
        } else {
          GetAllBooksDTO allBooksDTO = GetAllBooksDTO.fromJson(response.data);
          return StoreApiModel.toEntityList(allBooksDTO.data);
        }
        // GetAllBooksDTO allBooksDTO = GetAllBooksDTO.fromJson(response.data);
        // return StoreApiModel.toEntityList(allBooksDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error ${e.toString()}");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addToLibrary(String userId, String bookId) async {
    try {
      await _dio.post(ApiEndpoints.addToLibrary, data: {userId, bookId});
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
