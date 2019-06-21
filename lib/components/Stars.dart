import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Stars extends StatelessWidget {
  final String star;

  const Stars({Key key, @required this.star}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0),
      child: new Row(
        children: new List.generate(5, buildStar),
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget buildStar(int i) {
    if (i < double.parse(star).round()) {
      return Icon(
        Icons.star,
        size: 16,
      );
    } else {
      return Icon(
        Icons.star_border,
        size: 16,
      );
    }
  }
}
