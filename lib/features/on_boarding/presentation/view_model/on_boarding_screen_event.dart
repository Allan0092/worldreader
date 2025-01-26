part of 'on_boarding_screen_bloc.dart';

sealed class OnBoardingScreenEvent extends Equatable {
  const OnBoardingScreenEvent();
  @override
  List<Object?> get props => [];
}

class NavigateLoginScreenEvent extends OnBoardingScreenEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateRegisterScreenEvent extends OnBoardingScreenEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateDashboardScreenEvent extends OnBoardingScreenEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateDashboardScreenEvent({
    required this.context,
    required this.destination,
  });
}
