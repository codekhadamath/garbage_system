class User {
  final String name;
  final String email;
  final String phone;
  final bool isAdmin;

  User({required this.name, required this.email, required this.phone, this.isAdmin = false});

  User.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            email: json['email']! as String,
            phone: json['phone']! as String,
            isAdmin: json['isAdmin']! as bool,
      );

  Map<String, Object?> toJson() =>
      {
        'name': name,
        'email': email,
        'phone': phone,
        'isAdmin': isAdmin,
      };
}
