import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod_clean_architecture/data/repositories_impl/auth_repository_impl.dart';

import '../../core/resource/resource.dart';

class LogoutUseCase {
  final AuthRepository _repository;
  
  LogoutUseCase(this._repository);
  
  Future<Resource<void>> execute() {
    return _repository.logout();
  }
}

// Provider
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});
