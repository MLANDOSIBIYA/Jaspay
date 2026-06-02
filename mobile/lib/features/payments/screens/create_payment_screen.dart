import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../services/payment_service.dart';

class CreatePaymentScreen extends StatefulWidget {
  const CreatePaymentScreen({super.key});

  @override
  State<CreatePaymentScreen> createState() => _CreatePaymentScreenState();
}

class _CreatePaymentScreenState extends State<CreatePaymentScreen> {
  final amountController = TextEditingController();

  final descriptionController = TextEditingController();

  bool isLoading = false;

  String? qrCode;

  Future<void> createPayment() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result = await PaymentService().createPaymentRequest(
        amount: double.parse(amountController.text),
        description: descriptionController.text,
      );

      setState(() {
        qrCode = result["paymentRequest"]["qrCode"];
      });
    } catch (e) {
      debugPrint(e.toString());

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Payment")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: isLoading ? null : createPayment,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Generate Payment QR"),
              ),
            ),

            const SizedBox(height: 30),

            if (qrCode != null) ...[
              const Text(
                "Customer Scan QR",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              QrImageView(data: qrCode!, version: QrVersions.auto, size: 250),

              const SizedBox(height: 20),

              SelectableText(qrCode!, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
