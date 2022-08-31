import 'package:amazon_app/widgets/stars.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;
    for (var i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                height: 135,
                width: 135,
                fit: BoxFit.fitHeight,
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Stars(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text('Eligible for free shipping'),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: const Text(
                      'In stock',
                      maxLines: 2,
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
