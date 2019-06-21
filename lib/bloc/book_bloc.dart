import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class BookBloc extends Bloc<BookEvent, BookState> {
  @override
  BookState get initialState => BookInitial();

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    if (event is GetBook) {
      yield BookLoadingDetails();
      await Future.delayed(Duration(seconds: 2));
      BookDetails getBookDetails = await getBookDetailsFromServer(event.isbn);
      yield BookLoadedDetails(getBookDetails);
      // yield BookLoadedDetails(new BookDetails(
      //   authorName: "test",
      //   bookName: "test",
      //   possibleLinks: <String>["test", "test"],
      //   thumbnailUrl: "test",
      // ));
    } else if (event is ClearSelection) {
      yield BookInitial();
    }
  }

  Future<BookDetails> getBookDetailsFromServer(String isbn) async {
    var url = "http://localhost:5000";
    var resp = await http.get("$url/api/BookInfoFetch/$isbn");
    Map<String, dynamic> testing = json.decode(resp.body);
  }
}
