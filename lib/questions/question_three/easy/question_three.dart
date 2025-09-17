import 'package:flutter/material.dart';

//bad code
class Screen {
  void navigate() {
    print('Navigating to screen');
  }
}

class HomeScreen extends Screen {
  @override
  void navigate() {
    print('Navigating to home');
  }
}

class SettingsScreen extends Screen {
  @override
  void navigate() {
    throw Exception('Settings don\'t navigate this way!');
  }
}

class NavigationButton extends StatelessWidget {
  final Screen screen;
  const NavigationButton(this.screen, {super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => screen.navigate(),
      child: const Text('Navigate'),
    );
  }
}

/*
explaination:
i was not fully sure about the answer between A & B
there are two main problem here is screen should have the responsibility of navigation 
or it has to be separate class 
 the second problem is about the Liskov Substitution Principle the setting screen can not replace
 the screen navigation correctly
but depending on the role which one system can be tolerant with and which one will cause crash
my answer is B 


*/

//good code

/*
i decide to split screens into:

NavigateableScreen

NonNavigateableScreen

so i can make sure that only NavigateableScreen can be passed to NavigationButton2
and still both are screen and could share some code or behaveior from it
but still there is some aspects to be careful about
like making navigation stand alone to achieve single responsibility


 */
abstract class Screen2 {
//sharable code
}

class NavigateableScreen extends Screen2 {
  void navigate() {
    print('Navigating to screen');
  }
}

class NonNavigateableScreen extends Screen2 {
//another behavior
}

class HomeScreen2 extends NavigateableScreen {
  @override
  void navigate() {
    print('Navigating to home');
  }
}

class SettingsScreen2 extends NonNavigateableScreen {}

class NavigationButton2 extends StatelessWidget {
  final NavigateableScreen screen;
  const NavigationButton2(this.screen, {super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => screen.navigate(),
      child: const Text('Navigate'),
    );
  }
}
