import '../../domain/models/user.dart';
import '../dtos/user_dto.dart';

extension UserMapper on UserDto {
  User toUser() {
    return User(
      id: id,
      name: name,
      email: email,
      profilePicture: profilePicture,
      phone: phone,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
