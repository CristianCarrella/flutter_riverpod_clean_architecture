import 'package:flutter_riverpod_clean_architecture/domain/models/user.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/auth_repository.dart';

import '../../core/error_handling/resource.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Resource<User>> execute({
    required String name,
    required String email,
    required String password,
  }) {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return Future.value(
        Failure(message: 'Name, email, and password cannot be empty'),
      );
    }

    return _repository.register(name: name, email: email, password: password);
  }
}
