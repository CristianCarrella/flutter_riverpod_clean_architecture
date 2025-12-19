import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

import '../../core/resource/resource.dart';
import '../../data/repositories_impl/teams_repository_impl.dart';
import '../repositories/teams_repository.dart';

class ManageTeamsUseCase {
  final TeamsRepository _repository;

  ManageTeamsUseCase({required TeamsRepository repository}) : _repository = repository;

  Future<Resource<List<Team>>> getLeagueTeams() async {
    return await _repository.getLeagueTeams();
  }
}

final manageTeamsUseCaseProvider = Provider<ManageTeamsUseCase>((ref) {
  final repository = ref.watch(localTeamsRepositoryProvider);
  return ManageTeamsUseCase(repository: repository);
});
