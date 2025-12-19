import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_riverpod_clean_architecture/core/network/api_client.dart';
import 'package:flutter_riverpod_clean_architecture/core/utils/app_utils.dart';
import 'package:flutter_riverpod_clean_architecture/data/datasources/auth_data_source.dart';
import 'package:flutter_riverpod_clean_architecture/data/dtos/user_dto.dart';
import 'package:flutter_riverpod_clean_architecture/data/mappers/user_mapper.dart';
import 'package:flutter_riverpod_clean_architecture/domain/models/user.dart';

class AuthRemoteDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<User> login({required String email, required String password}) async {
    final hasNetwork = await AppUtils.hasNetworkConnection();
    if (!hasNetwork) {
      throw NetworkException();
    }

    await Future.delayed(const Duration(seconds: 1));

    return UserDto(
      id: 'user-123',
      name: 'John Doe',
      email: email,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ).toUser();
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final hasNetwork = await AppUtils.hasNetworkConnection();
    if (!hasNetwork) {
      throw NetworkException();
    }

    await Future.delayed(const Duration(seconds: 1));

    return UserDto(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ).toUser();
  }
}

final authRemoteDataSourceProvider = Provider<AuthDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(apiClient);
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
