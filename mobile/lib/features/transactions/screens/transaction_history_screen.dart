import 'package:flutter/material.dart';

import '../services/transaction_service.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TransactionService _transactionService = TransactionService();

  bool isLoading = true;

  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();

    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      final data = await _transactionService.getTransactions();

      setState(() {
        transactions = data;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshData() async {
    await loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refreshData,

              child: transactions.isEmpty
                  ? const Center(child: Text("No transactions found"))
                  : ListView.builder(
                      itemCount: transactions.length,

                      itemBuilder: (context, index) {
                        final transaction = transactions[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                transaction["type"].toString().substring(0, 1),
                              ),
                            ),

                            title: Text(
                              transaction["description"] ?? "Transaction",
                            ),

                            subtitle: Text(transaction["reference"]),

                            trailing: Text(
                              "R ${transaction["amount"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
