import 'package:flutter_riverpod_clean_architecture/domain/models/user.dart';

import '../../core/error_handling/resource.dart';

abstract class AuthRepository {
  /// Login a user with email and password
  Future<Resource<User>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<Resource<User>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logout the current user
  Future<Resource<void>> logout();

  /// Check if a user is authenticated
  Future<Resource<bool>> isAuthenticated();

  /// Get the current authenticated user
  Future<Resource<User>> getCurrentUser();
}
