// Auth state
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/resource/resource.dart';

import '../../domain/models/user.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/register_use_case.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({bool? isAuthenticated, bool? isLoading, User? user, String? errorMessage}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required RegisterUseCase registerUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _registerUseCase = registerUseCase,
       super(const AuthState());

  // Check auth status
  Future<void> checkAuthStatus() async {
    /// TODO: if user stay in shared so isAuthenticated = true
    state = state.copyWith(isAuthenticated: false, user: null);
  }

  // Login
  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final Resource<User> result = await _loginUseCase.execute(email: email, password: password);

    result.foldOrNull(
      onFailure:
          (message, _) =>
              state = state.copyWith(
                isLoading: false,
                isAuthenticated: false,
                errorMessage: message,
              ),
      onSuccess:
          (user) =>
              state = state.copyWith(
                isLoading: false,
                isAuthenticated: true,
                user: user,
                errorMessage: null,
              ),
    );
  }

  // Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _registerUseCase.execute(name: name, email: email, password: password);

    result.foldOrNull(
      onFailure:
          (message, _) =>
              state = state.copyWith(
                isLoading: false,
                isAuthenticated: false,
                errorMessage: message,
              ),
      onSuccess:
          (user) =>
              state = state.copyWith(
                isLoading: false,
                isAuthenticated: true,
                user: user,
                errorMessage: null,
              ),
    );
  }

  // Logout
  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _logoutUseCase.execute();

    result.foldOrNull(
      onFailure: (message, _) => state = state.copyWith(isLoading: false, errorMessage: message),
      onSuccess:
          (_) =>
              state = state.copyWith(
                isLoading: false,
                isAuthenticated: false,
                user: null,
                errorMessage: null,
              ),
    );
  }
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);

  return AuthNotifier(
    loginUseCase: loginUseCase,
    logoutUseCase: logoutUseCase,
    registerUseCase: registerUseCase,
  );
});
