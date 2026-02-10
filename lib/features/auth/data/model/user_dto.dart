import 'package:blog_app/core/common/entities/user.dart';

class UserDto extends User {
  UserDto({required super.id, required super.name, required super.email});
  factory UserDto.fromJson(Map<String, dynamic> map) {
    return UserDto(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
    );
  }

  UserDto copyWith({String? id, String? name, String? email}) {
    return UserDto(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
