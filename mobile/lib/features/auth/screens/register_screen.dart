import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final tradingNameController = TextEditingController();
  final legalNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final idLastFourController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;

  Future<void> registerSeller() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await _authService.registerSeller(
        tradingName: tradingNameController.text.trim(),
        legalName: legalNameController.text.trim(),
        mobileNumber: mobileNumberController.text.trim(),
        idLastFour: idLastFourController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.data["message"])));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registration failed")));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: tradingNameController,
                decoration: const InputDecoration(labelText: "Trading Name"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: legalNameController,
                decoration: const InputDecoration(labelText: "Legal Name"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: mobileNumberController,
                decoration: const InputDecoration(labelText: "Mobile Number"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: idLastFourController,
                decoration: const InputDecoration(
                  labelText: "ID Last 4 Digits",
                ),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,

                child: ElevatedButton(
                  onPressed: isLoading ? null : registerSeller,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
