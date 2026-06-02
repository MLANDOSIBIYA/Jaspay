import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/storage_service.dart';

/// ===============================
/// AUTH STATE MODEL
/// ===============================
class AuthState {
  final bool isAuthenticated;
  final String? token;

  AuthState({required this.isAuthenticated, this.token});

  factory AuthState.unauthenticated() {
    return AuthState(isAuthenticated: false);
  }

  factory AuthState.authenticated(String token) {
    return AuthState(isAuthenticated: true, token: token);
  }
}

/// ===============================
/// AUTH PROVIDER
/// ===============================
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

/// ===============================
/// AUTH NOTIFIER
/// ===============================
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.unauthenticated());

  Future<void> checkAuthStatus() async {
    final token = await StorageService.getToken();

    final valid = await StorageService.isSessionValid();

    if (token != null && valid) {
      state = AuthState.authenticated(token);
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> login(String token) async {
    await StorageService.saveToken(token);

    state = AuthState.authenticated(token);
  }

  Future<void> logout() async {
    await StorageService.clearToken();

    state = AuthState.unauthenticated();
  }
}
