import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_data_source.dart';
import '../../data/datasources/datasources_impl/auth_remote_data_source_impl.dart';
import '../../data/datasources/datasources_impl/teams_data_source_local_impl.dart';
import '../network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authRemoteDataSourceProvider = Provider<AuthDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(apiClient);
});

final teamsDataSourceProvider = Provider<TeamsDataSourceLocalImpl>((ref) {
  return TeamsDataSourceLocalImpl();
});
