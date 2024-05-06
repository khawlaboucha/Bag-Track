import 'package:bag_track/configiration/color.dart';
import 'package:bag_track/screen/screnn_track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingStatus = Provider.of<OnboardingStatusNotifier>(context); // Accessing OnboardingStatusNotifier

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryLightColor, AppColor.primaryColor],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 70, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/on_bording_img_last.png"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Update onboarding status when tapped
                      onboardingStatus.completeOnboarding(context);
                    },
                    child: Container(
                      width: 270,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/button_start.png'),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF383A69),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// A class to hold the completion status of onboarding
class OnboardingStatusNotifier extends ChangeNotifier {
  bool _completed = false;

  bool get completed => _completed;

  void completeOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
    // Simulating completing onboarding, replace with your logic
    _completed = true; // Set onboarding as completed
    notifyListeners(); // Notify listeners that the completion status has changed
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenTracking(),
      ),
    );
  }
}