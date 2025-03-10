part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String email;
  final String password;
  final String? image;

  const RegisterUser({
    required this.context,
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
    this.image,
  });
}
