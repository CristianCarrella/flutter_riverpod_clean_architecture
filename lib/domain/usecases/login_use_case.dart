import 'package:flutter_riverpod_clean_architecture/core/error_handling/resource.dart';
import 'package:flutter_riverpod_clean_architecture/domain/models/user.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Resource<User>> execute({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      return Future.value(
        Failure(message: 'Email and password cannot be empty'),
      );
    }

    return _repository.login(email: email, password: password);
  }
}
