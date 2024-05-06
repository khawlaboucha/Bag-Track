import 'package:bag_track/screen/on_bording_screen.dart';
import 'package:flutter/material.dart';
import'package:bag_track/screen/splash_screen.dart';
import 'package:provider/provider.dart';
void main() {

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingStatusNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Ensure SplashScreen is directly under MyApp
      ),
    );
  }
}
