import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Response> registerSeller({
    required String tradingName,
    required String legalName,
    required String mobileNumber,
    required String idLastFour,
    required String password,
  }) async {
    return await _dio.post(
      "${ApiConstants.baseUrl}/auth/register",
      data: {
        "tradingName": tradingName,
        "legalName": legalName,
        "mobileNumber": mobileNumber,
        "idLastFour": idLastFour,
        "password": password,
      },
    );
  }

  Future<Response> loginSeller({
    required String mobileNumber,
    required String password,
  }) async {
    return await _dio.post(
      "${ApiConstants.baseUrl}/auth/login",

      data: {"mobileNumber": mobileNumber, "password": password},
    );
  }
}
