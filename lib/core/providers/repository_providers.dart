import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/storage_providers.dart';

import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/teams_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/teams_repository.dart';
import 'datasource_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localStorageService: ref.watch(localStorageServiceProvider),
    secureStorageService: ref.watch(secureStorageServiceProvider),
  );
});

final localTeamsRepositoryProvider = Provider<TeamsRepository>((ref) {
  final teamsDataSource = ref.watch(teamsDataSourceProvider);

  return LocalTeamsRepositoryImpl(datasource: teamsDataSource);
});
