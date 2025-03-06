import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:worldreader/app/constants/api_endpoints.dart';
import 'package:worldreader/app/di/di.dart';
import 'package:worldreader/app/shared_prefs/token_shared_prefs.dart';
import 'package:worldreader/features/library/domain/entity/library_entity.dart';

class LibraryRemoteDataSource {
  final Dio _dio;

  LibraryRemoteDataSource(this._dio);

  Future<List<LibraryEntity>> getUserLibrary() async {
    try {
      String token = await _getAuthToken() ?? "";
      final payload = Jwt.parseJwt(token);
      final userId = payload['id'] as String?;
      if (userId == null) throw Exception('User ID not found in token');

      final response = await _dio.get(
        ApiEndpoints.getUserLibrary + userId,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

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
    late String token;
    final tokenResult = await tokenPrefs.getToken();
    tokenResult.fold(
      (failure) => "",
      (usertoken) {
        if (usertoken.isEmpty) throw Exception("No auth token found");
        token = usertoken;
      },
    );
    return token;
  }
}
