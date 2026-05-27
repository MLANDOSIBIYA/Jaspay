import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/storage_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isAuthenticated;
  final String? token;

  const AuthState({required this.isAuthenticated, this.token});

  factory AuthState.unauthenticated() {
    return const AuthState(isAuthenticated: false, token: null);
  }

  factory AuthState.authenticated(String token) {
    return AuthState(isAuthenticated: true, token: token);
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.unauthenticated());

  Future<void> checkLoginStatus() async {
    final token = await StorageService.getToken();

    if (token != null && token.isNotEmpty) {
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
