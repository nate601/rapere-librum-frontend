import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Stars extends StatelessWidget {
  final int starCount;

  const Stars({Key key, @required this.starCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row retVal = new Row();
    for (var i = 0; i < starCount; i++) {
      retVal.children.add(Icon(Icons.star));
    }
    for (var i = starCount; i < 5; i++) {
      retVal.children.add(Icon(Icons.star_border));
    }
    return retVal;
  }
}
