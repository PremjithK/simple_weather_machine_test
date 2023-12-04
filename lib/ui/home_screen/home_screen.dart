import 'package:flutter/material.dart';
import 'package:simple_weather/config/config.dart';
import 'package:simple_weather/ui/widgets/main_weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Axis pageDirection = Axis.vertical;
  @override
  Widget build(BuildContext context) {
    // This container will hold the background image (as decoration image)
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.snowyBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: pageDirection,
            children: [
              MainWeatherCard(),
            ],
          ),
        ),
      ),
    );
  }
}
