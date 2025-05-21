import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({required this.id, required this.email, required this.name});

  final String? id;
  final String? email;
  final String? name;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User entity) {
    return UserModel(id: entity.id, email: entity.email, name: entity.name);
  }

  User toEntity() {
    return User(id: id ?? '', email: email ?? '', name: name ?? '');
  }
}
