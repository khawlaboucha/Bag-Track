import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bag_track/configiration/color.dart';
import 'package:bag_track/screen/on_bording_screen.dart';
import 'package:bag_track/screen/on_bording_screen.dart';
import 'package:bag_track/screen/screnn_track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final onboardingStatus = context.read<OnboardingStatusNotifier>();
        if (onboardingStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ScreenTracking()),
          );
        } else {
          // If onboarding is not completed, navigate to the onboarding screen after a delay
          Future.delayed(Duration(seconds: 2), () {
            _completeOnboarding(context); // Call the onboarding completion function
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to complete onboarding and navigate to the next screen
  void _completeOnboarding(BuildContext context) {
    // Update the onboarding status to completed
    final onboardingStatus = context.read<OnboardingStatusNotifier>();
    onboardingStatus.completeOnboarding(context);

    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, AppColor.primaryColor],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center( // Center the content vertically and horizontally
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo_splach.png"),
                    ),
                  ),
                ),
              ),
              TypewriterAnimatedTextKit(
                text: ['Bag Track'],
                textStyle: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
