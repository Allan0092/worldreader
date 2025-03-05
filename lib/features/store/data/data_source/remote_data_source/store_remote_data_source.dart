import 'package:dio/dio.dart';
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/features/store/data/data_source/store_data_source.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';

class StoreRemoteDataSource implements IStoreDataSource {
  final Dio _dio;

  StoreRemoteDataSource(this._dio);

  @override
  Future<List<BookEntity>> getStoreBooks() async {
    try {
      Response response = await _dio.post(ApiEndpoints.getAllPublicBooks);

      if (response.statusCode == 200) {
        final books = response.data;
        return books;
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
