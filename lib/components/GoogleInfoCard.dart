import 'package:flutter/material.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';

import 'Stars.dart';

class GoogleInfoCard extends StatelessWidget {
  const GoogleInfoCard({
    Key key,
    @required this.details,
  }) : super(key: key);

  final BookDetails details;

  @override
  Widget build(BuildContext context) {
    if (details == null) {
      return Text("Out");
    }
    return Card(
      child: Row(
        children: <Widget>[
          SizedBox(
            child: imageNullChecker(),
            width: 128,
            height: 206,
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                "${details.bookName}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "${details.authorName}",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Stars(
                star: details.currentRating,
              )
            ],
          )
        ],
      ),
    );
  }

  imageNullChecker() {
    if (details == null) {
      return Placeholder();
    } else {
      return Image.network(details.thumbnailUrl);
    }
  }
}
