import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/auth/presentation/view/login_view.dart';
import 'package:worldreader/features/auth/presentation/view/register_view.dart';
import 'package:worldreader/features/home/presentation/view/dashboard.dart';
import 'package:worldreader/features/on_boarding/presentation/view_model/on_boarding_screen_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page! < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildPage(
                image: 'assets/images/onboarding1.jpg',
                title: 'Welcome to WorldReader',
                description: 'Read and explore a world of books.',
              ),
              _buildPage(
                image: 'assets/images/onboarding2.jpg',
                title: 'Discover New Books',
                description: 'Find new books and authors to enjoy.',
              ),
              _buildPage(
                image: 'assets/images/onboarding3.jpg',
                title: 'Join the Community',
                description:
                    'Connect with other readers and share your thoughts.',
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Navigator.pushReplacementNamed(context, '/dashboard');
                context.read<OnBoardingScreenBloc>().add(
                    NavigateDashboardScreenEvent(
                        context: context, destination: const Dashboard()));
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.blue),
              onPressed: _previousPage,
            ),
          ),
          Positioned(
            bottom: 110,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.blue),
              onPressed: _nextPage,
            ),
          ),
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/signup');
                  context.read<OnBoardingScreenBloc>().add(
                        NavigateRegisterScreenEvent(
                          context: context,
                          destination: RegisterView(),
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color(0xFF009CDA), // Blue background
                  foregroundColor: Colors.white, // White text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Join us'),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/dashboard');
                  context.read<OnBoardingScreenBloc>().add(
                        NavigateLoginScreenEvent(
                          context: context,
                          destination: LoginView(),
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor:
                      const Color.fromARGB(255, 0, 95, 132), // Blue background
                  foregroundColor: Colors.white, // White text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text('Log in'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String image,
      required String title,
      required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
