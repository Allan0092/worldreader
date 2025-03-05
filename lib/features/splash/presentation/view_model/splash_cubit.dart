import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:worldreader/features/on_boarding/presentation/view_model/on_boarding_screen_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._onBoardingScreenBloc) : super(null);
  final OnBoardingScreenBloc _onBoardingScreenBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onBoardingScreenBloc,
              child: OnBoardingScreen(),
            ),
          ),
        );
      }
    });
  }
}
