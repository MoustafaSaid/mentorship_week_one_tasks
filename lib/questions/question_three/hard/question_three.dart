import 'package:flutter/material.dart';

/*
now i separate the navigation logic and the screen ui
only screens that need navigation should implement the navigation interface
as it need
and navigation button should accept the navigation interface




 */


abstract class Screen {
  // shared behavior
}

abstract class Navigation {
  void navigate(BuildContext context) {
  }
  //  means this screen can be navigated to
}

class HomeScreen extends Screen implements Navigation {
  @override
  void navigate(  BuildContext context) {
    print('Navigating to home');
  }
}

class SettingsScreen extends Screen {
  // Not navigatable
}

class NavigationButton extends StatelessWidget {
  final Navigation navigation;

  const NavigationButton(this.navigation,  {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => navigation.navigate( context),
      child: const Text('Navigate'),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: NavigationButton(HomeScreen()),
        ),
      ),
    );
  }
}
