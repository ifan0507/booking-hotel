class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? role;
  final String? accessToken;
  final String? tokenType;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.role,
      this.accessToken,
      this.tokenType});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role,
      'accessToken': accessToken,
      'tokenType': tokenType,
    };
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'] ?? "",
        firstName: jsonData['firstName'] ?? "",
        lastName: jsonData['lastName'] ?? "",
        email: jsonData['email'] ?? "",
        role: jsonData['role'] ?? "",
        password: jsonData['password'] ?? "",
        accessToken: jsonData['accessToken'] ?? "",
        tokenType: jsonData['tokenType'] ?? "");
  }
}
