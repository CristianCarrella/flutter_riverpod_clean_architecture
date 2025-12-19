import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

import '../../core/error_handling/resource.dart';
import '../../domain/repositories/teams_repository.dart';
import '../datasources/teams_data_source.dart';

class LocalTeamsRepositoryImpl implements TeamsRepository {
  final TeamsDataSource _datasource;

  LocalTeamsRepositoryImpl({required TeamsDataSource datasource})
    : _datasource = datasource;

  @override
  Future<Resource<List<Team>>> getLeagueTeams() async {
    final teams = await _datasource.getLeagueTeams();
    return Success(data: teams);
  }
}
