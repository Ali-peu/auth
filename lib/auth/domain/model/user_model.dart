import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String phoneNumber;
  final String name;

  const MyUser({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.name,
  });

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'phoneNumber': phoneNumber,
      'fullName': name,
    };
  }

  static const empty = MyUser(
    userId: '',
    email: '',
    phoneNumber: '',
    name: '',
  );

  static MyUser fromDocument(Map<String, dynamic> doc) {
    return MyUser(
      userId: doc['userId'],
      email: doc['email'],
      phoneNumber: doc['phoneNumber'],
      name: doc['fullName'],
    );
  }

  MyUser copyWith({
    String? userId,
    String? email,
    String? phoneNumber,
    String? name,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        phoneNumber,
        name,
      ];
}
