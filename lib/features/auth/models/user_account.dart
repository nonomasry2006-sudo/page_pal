import 'package:hive/hive.dart';

part 'user_account.g.dart';

@HiveType(typeId: 4)
class UserAccount extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final String? bio;

  UserAccount({
    required this.email,
    required this.password,
    required this.name,
    required this.createdAt,
    this.phone,
    this.bio,
  });

  UserAccount copyWith({
    String? email,
    String? password,
    String? name,
    DateTime? createdAt,
    String? phone,
    String? bio,
  }) {
    return UserAccount(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }
}