import '../../../core/services/api_client.dart';

class SellerService {
  Future<Map<String, dynamic>> getProfile() async {
    final response = await ApiClient.dio.get("/seller/profile");

    return response.data;
  }
}
