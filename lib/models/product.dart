// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final String? id;
  final List<dynamic> images;
  final List<Rating>? ratings;

  Product({
    this.ratings,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    this.id,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      '_id': id,
      'images': images,
      'ratings': ratings,
    };
  }

  factory Product.fromMap(Map<String, dynamic> mapp) {
    return Product(
      name: mapp['name'] as String,
      description: mapp['description'] as String,
      price: double.parse((mapp['price'] as int).toString()),
      quantity: double.parse((mapp['quantity'] as int).toString()),
      category: mapp['category'] as String,
      id: mapp['_id'] as String,
      images: List<dynamic>.from(
        (mapp['images'] as List<dynamic>),
      ),
      ratings: mapp['ratings'] == null
          ? null
          : List<Rating>.from(
              mapp['ratings'].map(
                (val) => Rating.fromJson(jsonEncode(val)),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
