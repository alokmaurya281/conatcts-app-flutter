class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json['_id'].toString(),
  //     email: json['email'],
  //     username: json['username'],
  //     // Add other properties here
  //   );
  // }
}
