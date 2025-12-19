import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

import '../../core/resource/resource.dart';

abstract class TeamsRepository {
  Future<Resource<List<Team>>> getLeagueTeams();
}
