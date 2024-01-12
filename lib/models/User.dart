class User {
  String? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? imageUrl;

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.imageUrl,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? imageUrl,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}