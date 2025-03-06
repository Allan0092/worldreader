import 'package:dio/dio.dart';
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/app/di/di.dart';
import 'package:worldreader/app/shared_prefs/token_shared_prefs.dart';
import 'package:worldreader/features/library/domain/entity/library_entity.dart';

class LibraryRemoteDataSource {
  final Dio _dio;

  LibraryRemoteDataSource(this._dio);

  Future<List<LibraryEntity>> getUserLibrary() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUserLibrary,
          options: Options(
              headers: {'Authorization': 'Bearer ${await _getAuthToken()}'}));

      if (response.statusCode == 200) {
        final List<dynamic> booksJson = response.data['library'];
        return booksJson.map((json) => LibraryEntity.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error ${e.toString()}");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> _getAuthToken() async {
    final tokenPrefs = getIt<TokenSharedPrefs>();
    final tokenResult = await tokenPrefs.getToken();
    return tokenResult.fold(
      (failure) => null,
      (token) => token,
    );
  }
}
