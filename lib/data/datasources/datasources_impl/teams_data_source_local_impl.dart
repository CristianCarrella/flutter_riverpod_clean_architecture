import 'package:flutter_riverpod_clean_architecture/domain/models/team.dart';

import '../../dtos/team_dto.dart';
import '../../mappers/team_mapper.dart';
import '../teams_data_source.dart';

class TeamsDataSourceLocalImpl implements TeamsDataSource {
  List<TeamDto> teams = [
    TeamDto(name: 'Napoli', points: 152),
    TeamDto(name: 'Juventus', points: 15),
    TeamDto(name: 'Inter', points: 20),
    TeamDto(name: 'Milan', points: 8),
    TeamDto(name: 'Roma', points: 0),
    TeamDto(name: 'Lazio', points: 38),
    TeamDto(name: 'Atalanta', points: 42),
    TeamDto(name: 'Fiorentina', points: 36),
    TeamDto(name: 'Torino', points: 30),
    TeamDto(name: 'Sassuolo', points: 28),
    TeamDto(name: 'Bologna', points: 26),
    TeamDto(name: 'Sampdoria', points: 24),
    TeamDto(name: 'Udinese', points: 25),
    TeamDto(name: 'Empoli', points: 22),
    TeamDto(name: 'Monza', points: 20),
    TeamDto(name: 'Verona', points: 18),
    TeamDto(name: 'Lecce', points: 16),
    TeamDto(name: 'Salernitana', points: 14),
    TeamDto(name: 'Cremonese', points: 12),
    TeamDto(name: 'Spezia', points: 10),
  ];

  @override
  Future<List<Team>> getLeagueTeams() async {
    await Future.delayed(const Duration(seconds: 2));
    return teams.map((e) => e.toTeam()).toList();
  }
}
