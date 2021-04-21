import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  String password;
  String photoUrl;
  String status;
  bool hasStories;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photoUrl,
    this.status = 'unknown',
    this.hasStories = false,
  });

  static final empty = UserModel(
    id: '',
    name: '',
    email: '',
    password: '',
    photoUrl: '',
    hasStories: false,
  );

  UserModel copyWith({
    String id,
    String name,
    String email,
    String password,
    String photoUrl,
    String status,
    bool hasStories,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
      hasStories: hasStories ?? this.hasStories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'status': status,
      'hasStories': hasStories,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      photoUrl: map['photoUrl'],
      status: map['status'],
      hasStories: map['hasStories'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, password: $password, photoUrl: $photoUrl, status: $status, hasStories: $hasStories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.photoUrl == photoUrl &&
        other.status == status &&
        other.hasStories == hasStories;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        photoUrl.hashCode ^
        status.hashCode ^
        hasStories.hashCode;
  }
}
