import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'BookLinks.dart';

class BookDetails extends Equatable {
  final String bookName;
  final String authorName;
  final String thumbnailUrl;
  final BookLinks possibleLinks;
  final String currentRating;
  final String numberOfReviews;

  BookDetails({
    @required this.bookName,
    @required this.authorName,
    @required this.thumbnailUrl,
    @required this.possibleLinks,
    @required this.currentRating,
    @required this.numberOfReviews,
  }) : super([
          bookName,
          authorName,
          thumbnailUrl,
          possibleLinks,
        ]);
  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
      authorName: json["authorName"],
      bookName: json["bookTitle"],
      thumbnailUrl: json["urlToThumbnail"],
      possibleLinks: null,
      currentRating: json["averageRating"],
      numberOfReviews: json["numberOfRatings"],
    );
  }
}
