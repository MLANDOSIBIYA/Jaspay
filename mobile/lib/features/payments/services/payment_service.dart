import '../../../core/services/api_client.dart';

class PaymentService {
  Future<Map<String, dynamic>> createPaymentRequest({
    required double amount,
    required String description,
  }) async {
    final response = await ApiClient.dio.post(
      "/payments/create",

      data: {"amount": amount, "description": description},
    );

    return response.data;
  }
}
