/*
now the user model is only responsible for the user data
and using named constructor to validate the data
and all data is required and has to be valid


 */
class UserModel {
  final String name;
  final int age;
  final String email;

  UserModel({
    required this.name,
    required this.age,
    required this.email,
  }) {
    if (age < 0) throw ArgumentError("Age cannot be negative");
    if (!email.contains("@")) throw ArgumentError("Invalid email");
  }

  UserModel copyWith({String? name, int? age, String? email}) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }
}
/*
now it is more flexible and can add more storages type like using api or local storage
and saving now is responsibility of the repository

 */
abstract class UserRepository {
  void save(UserModel user);
}

class FirestoreUserRepository implements UserRepository {
  @override
  void save(UserModel user) {
    print("Saving ${user.name}, ${user.age}, ${user.email} to Firestore");
  }
}
