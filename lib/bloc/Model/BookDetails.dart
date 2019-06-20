import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BookDetails extends Equatable {
  final String bookName;
  final String authorName;
  final String thumbnailUrl;
  final List<String> possibleLinks;

  BookDetails({
    @required this.bookName,
    @required this.authorName,
    @required this.thumbnailUrl,
    @required this.possibleLinks,
  }) : super([bookName]);
}
