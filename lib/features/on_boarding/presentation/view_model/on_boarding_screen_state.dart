part of 'on_boarding_screen_bloc.dart';

class OnBoardingScreenState {
  final bool isLoading;
  final bool isSuccess;

  OnBoardingScreenState({
    required this.isLoading,
    required this.isSuccess,
  });

  OnBoardingScreenState.initial()
      : isLoading = false,
        isSuccess = false;

  OnBoardingScreenState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return OnBoardingScreenState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}
