import 'package:flutter_riverpod_clean_architecture/domain/repositories/auth_repository.dart';

import '../../core/resource/resource.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Resource<void>> execute() {
    return _repository.logout();
  }
}
