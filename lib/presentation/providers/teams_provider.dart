import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/logger.dart';
import '../../domain/models/team.dart';
import '../../domain/usecases/manage_teams_use_case.dart';

class TeamsState {
  final List<Team> teams;
  final bool isLoading;
  final String? errorMessage;

  TeamsState({
    this.teams = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TeamsState copyWith({
    List<Team>? teams,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TeamsState(
      teams: teams ?? this.teams,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TeamsNotifier extends StateNotifier<TeamsState> {
  final ManageTeamsUseCase _manageTeamsUseCase;
  final Logger _logger;

  TeamsNotifier({
    required ManageTeamsUseCase manageTeamsUseCase,
    required Logger logger,
  }) : _manageTeamsUseCase = manageTeamsUseCase,
       _logger = logger,
       super(TeamsState()) {
    getLeagueTeams();
  }

  Future<void> getLeagueTeams() async {
    _logger.d('Getting league teams...');
    state = state.copyWith(isLoading: true, errorMessage: null);

    final teamsOption = await _manageTeamsUseCase.getLeagueTeams();
    teamsOption.foldOrNull(
      onFailure: (message, _) {
        state = state.copyWith(errorMessage: message, isLoading: false);
      },
      onSuccess: (teams) {
        teams.sort((a, b) => b.points.compareTo(a.points));
        state = state.copyWith(teams: teams, isLoading: false);
      },
    );
  }
}
