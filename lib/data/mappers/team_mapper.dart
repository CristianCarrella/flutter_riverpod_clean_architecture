import '../../domain/models/team.dart';
import '../dtos/team_dto.dart';

extension TeamMapper on TeamDto {
  Team toTeam() {
    return Team(name: name, points: points);
  }
}
