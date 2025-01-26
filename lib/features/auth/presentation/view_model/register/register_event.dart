part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String email;
  final String password;

  const RegisterUser({
    required this.context,
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
  });
}
