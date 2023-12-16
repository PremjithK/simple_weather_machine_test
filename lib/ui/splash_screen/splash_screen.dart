import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather/config/config.dart';
import 'package:simple_weather/domain/geo_locator.dart';
import 'package:simple_weather/ui/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () => loadHomePage(),
    );
  }

  void loadHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAC736A),
      body: Center(
        child: Lottie.asset(
          Assets.cloudLottie,
          fit: BoxFit.contain,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
