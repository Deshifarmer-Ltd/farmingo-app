// {
// "id": 22,
// "name": "Ahmed Nafiu Noman",
// "email": "nafiunoman@gmail.com",
// "token": "80|D6unV44jyGQioRdNvWN5rs58gOKC5rxrNDG1mByf50ced32c"
// }

class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  // Factory method to create a User object from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}
