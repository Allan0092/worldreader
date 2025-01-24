import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/core/common/show_bottom_snack_bar.dart';
import 'package:worldreader/features/auth/domain/use_case/login_use_case.dart';
import 'package:worldreader/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:worldreader/features/home/presentation/view/dashboard.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final RegisterBloc _registerBloc;

  LoginBloc({
    required LoginUseCase loginUseCase,
    required RegisterBloc registerBloc,
  })  : _loginUseCase = loginUseCase,
        _registerBloc = registerBloc,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [BlocProvider.value(value: _registerBloc)],
            child: event.destination,
          ),
        ),
      );
    });

    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await _loginUseCase(
          LoginParams(email: event.email, password: event.password));

      result.fold((failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showBottomSnackBar(
            context: event.context, message: "Invalid email or password");
      }, (token) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        add(NavigateRegisterScreenEvent(
          context: event.context,
          destination: const Dashboard(),
        ));
      });
    });
  }
}
