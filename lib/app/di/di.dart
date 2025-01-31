import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:worldreader/core/network/api_service.dart';
import 'package:worldreader/core/network/hive_service.dart';
import 'package:worldreader/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:worldreader/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:worldreader/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:worldreader/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:worldreader/features/auth/domain/use_case/login_use_case.dart';
import 'package:worldreader/features/auth/domain/use_case/register_use_case.dart';
import 'package:worldreader/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:worldreader/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:worldreader/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:worldreader/features/on_boarding/presentation/view_model/on_boarding_screen_bloc.dart';
import 'package:worldreader/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();

  // await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();

  await _initOnBoardingScreenDependencies();
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // init remote repository
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(getIt<AuthRemoteRepository>()));

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUseCase: getIt(),
    ),
  );
}

// _initHomeDependencies() async {
//   getIt.registerFactory<HomeCubit>(
//     () => HomeCubit(),
//   );
// }

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      // homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnBoardingScreenBloc>()),
  );
}

_initOnBoardingScreenDependencies() async {
  getIt.registerFactory<OnBoardingScreenBloc>(
    () => OnBoardingScreenBloc(
        loginBloc: getIt<LoginBloc>(), registerBloc: getIt<RegisterBloc>()),
  );

  // getIt.registerFactory<RegisterBloc>(
  //     () => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()));
}
