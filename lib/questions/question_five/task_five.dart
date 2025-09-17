//bad code

class LocalNotificationService {
  void send(String message) {
    print('Sending local notification: $message');
  }
}

class AppNotifier {
  final LocalNotificationService service = LocalNotificationService();
  void notifyUser(String message) {
    service.send(message);
  }
}

/*
maybe A is so vaild here and fastest choice but
 i think C is the real problem and by fixing it will solce single 
 responsibilty issue i think the real value of each question not just
  find the right solution but to think what is the real problem that 
  hide and what can be accepted and what not
 and define the real problem can lead to solve other by naturly

 */

//good code

/*

now by making notification service abstract
so not only local notification can be send but any notification just have
to implement this interface
AppNotifier now depends on abstraction, not a concrete class

 */

abstract class NotificationService {
  void send(String message);
}

class LocalNotificationService2 implements NotificationService {
  @override
  void send(String message) {
    print('Sending local notification: $message');
  }
}

class AppNotifier2 {
  final NotificationService service;

  AppNotifier2(this.service);

  void notifyUser(String message) {
    service.send(message);
  }
}
