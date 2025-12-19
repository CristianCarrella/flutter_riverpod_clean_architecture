import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

import '../../core/resource/resource.dart';
import '../repositories/teams_repository.dart';

class ManageTeamsUseCase {
  final TeamsRepository _repository;

  ManageTeamsUseCase({required TeamsRepository repository})
    : _repository = repository;

  Future<Resource<List<Team>>> getLeagueTeams() async {
    return await _repository.getLeagueTeams();
  }
}
