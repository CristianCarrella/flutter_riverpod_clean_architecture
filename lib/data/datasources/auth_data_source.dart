import '../../domain/models/user.dart';

abstract class AuthDataSource {
  /// Login a user with email and password
  Future<User> login({required String email, required String password});

  /// Register a new user
  Future<User> register({
    required String name,
    required String email,
    required String password,
  });
}