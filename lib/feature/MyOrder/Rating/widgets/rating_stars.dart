import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating; 

  RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        double currentStar = index + 1;

        if (rating >= currentStar) {
          return Icon(Icons.star, color: Colors.yellow, size: 25);
        } else if (rating > index && rating < currentStar) {
          return Icon(Icons.star_half, color: Colors.yellow, size: 25);
        } else {
          return Icon(Icons.star_border, color: Colors.grey, size: 25);
        }
      }),
    );
  }
}
