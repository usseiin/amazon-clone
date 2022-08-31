// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:amazon_app/models/product.dart';

class Order {
  final List<Product> products;
  final List<int> quantities;
  final String userId;
  final String id;
  final int orderedTime;
  final double totalPrice;
  final int status;
  final String address;

  Order({
    required this.products,
    required this.quantities,
    required this.userId,
    required this.id,
    required this.orderedTime,
    required this.totalPrice,
    required this.status,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'quantities': quantities,
      'userId': userId,
      '_id': id,
      'orderedTime': orderedTime,
      'totalPrice': totalPrice,
      'status': status,
      'address': address,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products: List<Product>.from(
        map['cartProducts']?.map<Product>(
          (x) => Product.fromMap(x['product'] as Map<String, dynamic>),
        ),
      ),
      quantities: List<int>.from(
        map['cartProducts']?.map((x) => x['quantity'] as int),
      ),
      userId: map['userId'] as String,
      id: map['_id'] as String,
      orderedTime: map['orderedTime'] as int,
      totalPrice: double.parse(map['totalPrice'] ?? '0.0'),
      status: map['status'] as int,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
