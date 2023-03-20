import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String sku;
  const Review({
    Key? key,
    required this.sku,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _NotReviewed();
  }
}

class _NotReviewed extends StatelessWidget {
  const _NotReviewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.favorite_outline,
        color: Colors.grey[400],
      ),
    );
  }
}

// class _Reviewed extends StatelessWidget {
//   const _Reviewed({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Icon(
//       Icons.favorite,
//       color: Colors.red,
//     );
//   }
// }
