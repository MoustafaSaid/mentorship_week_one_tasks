//bad code

abstract class WidgetController {
  void initState();
  void dispose();
  void handleAnimation();
  void handleNetwork();
}

class SimpleButtonController implements WidgetController {
  @override
  void initState() => print('Init button');
  @override
  void dispose() => print('Dispose button');
  @override
  void handleAnimation() =>
      throw UnimplementedError('No animationin simple button');
  @override
  void handleNetwork() => throw UnimplementedError('No network in button ');
}

/*

c is my answer and it was clear violation of  interface segregation principle(ISP)
 is the core one and by fix it using splitiong to smaller
 interfaces will also fix some other violation

 */

//good code

/*
for easy fixing i will separate the interface to smaller interfaces
so i can fix the violation and also fixing single responsibility violation


 */

abstract class WidgetController2 {
  void initState();
  void dispose();
}

abstract class WidgetAnimation {
  void handleAnimation();
}

abstract class WidgetNetwork {
  void handleNetwork();
}

class SimpleButtonController2 implements WidgetController2 {
  @override
  void initState() => print('Init button');
  @override
  void dispose() => print('Dispose button');
}

class AnimatedButtonController implements WidgetController2, WidgetAnimation {
  @override
  void initState() => print('Init animated button');

  @override
  void dispose() => print('Dispose animated button');

  @override
  void handleAnimation() => print('Animating button...');
}

class NetworkButtonController implements WidgetController2, WidgetNetwork {
  @override
  void initState() => print('Init network button');

  @override
  void dispose() => print('Dispose network button');

  @override
  void handleNetwork() => print('Fetching button state...');
}
