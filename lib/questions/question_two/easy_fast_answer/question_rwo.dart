//bad code
class UserModel {
  String name = '';
  int age = 0;
  String email = '';
  void updateUser(String name, int age, String email) {
    this.name = name;
    this.age = age;
    this.email = email;
  }

  void saveToFirestore() {
    print('Saving $name, $age, $email to Firestore');
  }
}

/*
my answer is c 
this is tricky multiple violation and different approches and alos 
valid explaination but since i have to put my hand on the core violation maybe b
 is strong and vaild but app can still work but c
  is mt choice a lot of crash can happen without
   using c and it also will solve b problem

 */

/*

explaination
i transfered the public variables to private variables and added setter and getter methods
and added validation to the setter methods
the i separate the userModel and the storing into firestore

for more optimization 
i suppse i can make abstract class for data 
so maybe there will be api or local storage alongside with firestore
also insted of using default value i can make the variable required

 */

//good code

class UserModel2 {
  String _name = "default";
  int _age = 0;
  String _email = "example@example.com";
  set setName(String name) {
    _name = name;
  }

  set setAge(int age) {
    if (age < 0) {
      print("age can't be negative");
      return;
    }
    _age = age;
  }

  set setEmail(String email) {
    if (!email.contains("@")) {
      print("email must contain @");
      return;
    }
    _email = email;
  }

  get userName => _name;
  get userAge => _age;
  get userEmail => _email;
  void updateUser(String name, int age, String email) {
    setName = name;
    setAge = age;
    setEmail = email;
  }
}

class Firestore {
  void saveToFirestore() {
    UserModel2 user = UserModel2();
    print(
        'Saving ${user.userName}, ${user.userAge}, ${user.userEmail} to Firestore');
  }
}
