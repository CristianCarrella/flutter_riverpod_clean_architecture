import 'package:flutter_riverpod_clean_architecture/core/constants/app_constants.dart';
import 'package:flutter_riverpod_clean_architecture/core/storage/local_storage_service.dart';
import 'package:flutter_riverpod_clean_architecture/core/storage/secure_storage_service.dart';
import 'package:flutter_riverpod_clean_architecture/data/dtos/user_dto.dart';
import 'package:flutter_riverpod_clean_architecture/domain/models/user.dart';
import 'package:flutter_riverpod_clean_architecture/domain/repositories/auth_repository.dart';

import '../../core/resource/resource.dart';
import '../datasources/auth_data_source.dart';
import '../mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _remoteDataSource;
  final LocalStorageService _localStorageService;
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl({
    required AuthDataSource remoteDataSource,
    required LocalStorageService localStorageService,
    required SecureStorageService secureStorageService,
  }) : _remoteDataSource = remoteDataSource,
       _localStorageService = localStorageService,
       _secureStorageService = secureStorageService;

  @override
  Future<Resource<User>> login({
    required String email,
    required String password,
  }) async {
    return Resource.executeAndReturnResource(() async {
      final User user = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      await _localStorageService.setObject(
        AppConstants.userDataKey,
        user.toJson(),
      );
      await _secureStorageService.write(
        key: AppConstants.tokenKey,
        value: user.id,
      );

      return user;
    });
  }

  @override
  Future<Resource<User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return Resource.executeAndReturnResource(() async {
      final user = await _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      await _localStorageService.setObject(
        AppConstants.userDataKey,
        user.toJson(),
      );
      await _secureStorageService.write(
        key: AppConstants.tokenKey,
        value: user.id,
      );

      return user;
    });
  }

  @override
  Future<Resource<void>> logout() async {
    return Resource.executeAndReturnResource(() async {
      await _localStorageService.remove(AppConstants.userDataKey);
      await _secureStorageService.delete(key: AppConstants.tokenKey);
    });
  }

  @override
  Future<Resource<bool>> isAuthenticated() async {
    return Resource.executeAndReturnResource(() async {
      final token = await _secureStorageService.read(
        key: AppConstants.tokenKey,
      );
      return token != null && token.isNotEmpty;
    });
  }

  @override
  Future<Resource<User>> getCurrentUser() async {
    return Resource.executeAndReturnResource(() async {
      final userData = _localStorageService.getObject(AppConstants.userDataKey);
      final user = UserDto.fromJson(userData as Map<String, dynamic>);
      return user.toUser();
    });
  }
}
