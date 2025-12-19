import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/resource/resource.dart';
import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

import '../../domain/repositories/teams_repository.dart';
import '../datasources/datasources_impl/teams_data_source_local_impl.dart';
import '../datasources/teams_data_source.dart';

class LocalTeamsRepositoryImpl implements TeamsRepository {
  final TeamsDataSource _datasource;

  LocalTeamsRepositoryImpl({required TeamsDataSource datasource}) : _datasource = datasource;

  /// TODO: nel progetto manca la funzione wrapper per mappare
  /// in fallimento o successo
  @override
  Future<Resource<List<Team>>> getLeagueTeams() async {
    final teams = await _datasource.getLeagueTeams();
    return Success(data: teams);
  }
}

final localTeamsRepositoryProvider = Provider<TeamsRepository>((ref) {
  final teamsDataSource = ref.watch(teamsDataSourceProvider);

  return LocalTeamsRepositoryImpl(datasource: teamsDataSource);
});
