import 'package:meta/meta.dart';

class BookLinks {
  final List<BookLinkRow> rows;

  BookLinks({@required this.rows});

  factory BookLinks.fromJson(List<dynamic> json) {
    BookLinks retVal = BookLinks(rows: []);
    for (var item in json) {
      assert(item is Map);
      retVal.rows.add(BookLinkRow.fromJson(item));
    }
    return retVal;
  }
}

class BookLinkRow {
  final String idNumber;
  final String authorName;
  final String bookTitle;
  final List<String> mirrorLinks;

  BookLinkRow({
    @required this.idNumber,
    @required this.authorName,
    @required this.bookTitle,
    @required this.mirrorLinks,
  });

  factory BookLinkRow.fromJson(Map<String, dynamic> json) {
    BookLinkRow retVal = BookLinkRow(
      idNumber: json["idNumber"],
      authorName: json["authorName"],
      bookTitle: json["bookTitle"],
      mirrorLinks: <String>[],
    );
    assert(json["mirrorLinks"] is List);
    for (var item in json["mirrorLinks"]) {
      retVal.mirrorLinks.add(item);
    }
    return retVal;
  }
}
