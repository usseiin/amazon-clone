import 'package:amazon_app/constants/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariable.carouselImages
          .map(
            (value) => Builder(
              builder: (BuildContext context) => Image.network(
                value,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
