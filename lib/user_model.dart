class User {
  final int id;
  final String name;
  final int role;
  final String password;
  User({required this.id, required this.name, required this.role, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      role: json['email'],
      password: json['password'],
    );
  }
}