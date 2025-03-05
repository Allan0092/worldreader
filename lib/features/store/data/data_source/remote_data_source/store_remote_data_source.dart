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
        GetAllBooksDTO getAllBooksDTO = GetAllBooksDTO.fromJson(response.data);
        return StoreApiModel.toEntityList(getAllBooksDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error ${e.toString()}");
    } catch (e) {
      throw Exception(e);
    }
  }
}
