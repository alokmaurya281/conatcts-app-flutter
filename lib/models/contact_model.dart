class Contact {
  final String id;
  final String userId;

  final String name;
  final String email;
  final String phone;

  Contact({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['_id'].toString(),
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      userId: json['user_id'],

      // Add other properties here
    );
  }
}
