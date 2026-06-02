import '../../../core/services/api_client.dart';

class TransactionService {
  Future<List<dynamic>> getTransactions() async {
    final response = await ApiClient.dio.get("/transactions/history");

    return response.data["transactions"] ?? [];
  }

  Future<void> testCredit() async {
    await ApiClient.dio.post("/transactions/credit");
  }
}
