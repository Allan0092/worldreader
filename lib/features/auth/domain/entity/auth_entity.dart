import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String lName;
  final String? image;
  final String email;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fName,
    required this.lName,
    this.image,
    required this.email,
    required this.password,
  });

  const AuthEntity.empty()
      : userId = "_empty.userId",
        fName = "_empty.fName",
        lName = "_empty.lName",
        image = "_empty.image",
        email = "_empty.email",
        password = "_empty.password";

  @override
  List<Object?> get props => [userId, fName, lName, image, email, password];
}
