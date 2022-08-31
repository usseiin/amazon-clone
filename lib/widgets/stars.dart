import 'package:amazon_app/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({Key? key, required this.rating}) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 15,
      rating: rating,
      itemBuilder: (context, _) {
        return const Icon(
          Icons.star,
          color: GlobalVariable.secondaryColor,
        );
      },
    );
  }
}
