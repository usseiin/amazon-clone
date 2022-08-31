// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String id;
  final String token;
  final String address;
  final String type;
  final String password;
  final List<dynamic> cart;

  User(
      {required this.email,
      required this.name,
      required this.id,
      required this.token,
      required this.address,
      required this.type,
      required this.password,
      required this.cart});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      id: map['_id'] ?? '',
      token: map['token'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      password: map['password'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'token': token,
      'address': address,
      'type': type,
      'password': password,
      'cart': cart,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? name,
    String? email,
    String? id,
    String? token,
    String? address,
    String? type,
    String? password,
    List<dynamic>? cart,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
      address: address ?? this.address,
      type: type ?? this.type,
      password: password ?? this.password,
      cart: cart ?? this.cart,
    );
  }
}
