import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'storage_service.dart';

class ApiClient {
  static final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  static void initialize() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }
}
