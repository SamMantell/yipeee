import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

int particleNumber = 50000;
final player = AudioPlayer();

void main() => runApp(const Yipeee());

class Yipeee extends StatelessWidget {
  const Yipeee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yipeee',
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(microseconds: 1));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(microseconds: 1));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(microseconds: 1));
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);

    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/yipeee-background.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: TextButton(
                style: TextButton.styleFrom(
                  overlayColor: Colors.transparent,
                ),
                onPressed: () {
                  _controllerBottomCenter.play();
                  _controllerCenterRight.play();
                  _controllerCenterLeft.play();
                  player.play(AssetSource('assets/sounds/brainrot_yippee.wav'));
                },
                child: Text('')),
          ),
          //CENTER RIGHT -- Emit left
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              blastDirection: 4.01, // radial value - LEFT
              particleDrag: 0.01, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: particleNumber, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              minimumSize: Size(80, 50),
              maximumSize: Size(90, 60),
              shouldLoop: false,
              colors: const [
                Color.fromRGBO(11, 163, 41, 0.9),
                Color.fromRGBO(224, 81, 35, 0.9),
                Color.fromRGBO(41, 36, 196, 0.9),
                Color.fromRGBO(146, 143, 149, 0.9),
                Color.fromRGBO(175, 127, 163, 0.9),
                Color.fromRGBO(68, 47, 41, 0.9),
              ], // manually specify the colors to be used
            ),
          ),

          //CENTER LEFT - Emit right
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerCenterLeft,
              blastDirection: 5.23, // radial value - RIGHT
              particleDrag: 0.01, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: particleNumber, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              minimumSize: Size(80, 50),
              maximumSize: Size(90, 60),
              shouldLoop: false,
              colors: const [
                Color.fromRGBO(11, 163, 41, 0.9),
                Color.fromRGBO(224, 81, 35, 0.9),
                Color.fromRGBO(41, 36, 196, 0.9),
                Color.fromRGBO(146, 143, 149, 0.9),
                Color.fromRGBO(175, 127, 163, 0.9),
                Color.fromRGBO(68, 47, 41, 0.9),
              ], // manually specify the colors to be used
            ),
          ),
          //BOTTOM CENTER
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              particleDrag: 0.01, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles:
                  particleNumber * 2, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              minimumSize: Size(80, 50),
              maximumSize: Size(90, 60),
              shouldLoop: false,
              colors: const [
                Color.fromRGBO(11, 163, 41, 0.9),
                Color.fromRGBO(224, 81, 35, 0.9),
                Color.fromRGBO(41, 36, 196, 0.9),
                Color.fromRGBO(146, 143, 149, 0.9),
                Color.fromRGBO(175, 127, 163, 0.9),
                Color.fromRGBO(68, 47, 41, 0.9),
              ], // manually specify the colors to be used
            ),
          ),
        ],
      ),
    );
  }
}
