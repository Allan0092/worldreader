import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/app/di/di.dart';
import 'package:worldreader/core/app_theme/app_theme.dart';
import 'package:worldreader/features/splash/presentation/view/splash_view.dart';
import 'package:worldreader/features/splash/presentation/view_model/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorldReader',
      debugShowMaterialGrid: false,
      theme: getApplicationTheme(),
      // home: const OnBoardingScreen(),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashView(),
      ),
    );
  }
}
