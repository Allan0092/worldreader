import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:worldreader/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:worldreader/features/home/presentation/view_model/home_cubit.dart';

part 'on_boarding_screen_event.dart';
part 'on_boarding_screen_state.dart';

class OnBoardingScreenBloc
    extends Bloc<OnBoardingScreenEvent, OnBoardingScreenState> {
  final LoginBloc _loginBloc;
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;

  OnBoardingScreenBloc({
    required LoginBloc loginBloc,
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
  })  : _loginBloc = loginBloc,
        _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        super(OnBoardingScreenState.initial()) {
    on<NavigateLoginScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _loginBloc,
              child: event.destination,
            ),
          ),
        );
      },
    );
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _registerBloc,
              child: event.destination,
            ),
          ),
        );
        // add(NavigateRegisterScreenEvent(
        //     context: event.context, destination: const SignUpView()));
      },
    );

    on<NavigateDashboardScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );
  }
}
