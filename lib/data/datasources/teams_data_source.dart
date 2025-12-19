import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

abstract class TeamsDataSource {
  Future<List<Team>> getLeagueTeams();
}
