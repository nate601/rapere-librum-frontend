import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

import 'Model/BookLinks.dart';

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
    } else if (event is StartCameraRead) {
      yield BookLoadingDetails();
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      await Future.delayed(Duration(seconds: 2));
      yield BookInitial();
    }
  }

  Future<BookDetails> getBookDetailsFromServer(String isbn) async {
    var url = "http://192.168.0.2:5000";
    var googleBooksReponse = await http.get("$url/api/BookInfoFetch/$isbn");
    var retVal = BookDetails.fromJson(json.decode(googleBooksReponse.body));

    var libgenSearchResponse =
        await http.get("$url/api/BookLinksFetch/${retVal.bookName}");
    BookLinks libgenLinks =
        BookLinks.fromJson(json.decode(libgenSearchResponse.body));
    var newRetVal = BookDetails(
      authorName: retVal.authorName,
      bookName: retVal.bookName,
      numberOfReviews: retVal.numberOfReviews,
      currentRating: retVal.currentRating,
      thumbnailUrl: retVal.thumbnailUrl,
      possibleLinks: libgenLinks,
    );
    return newRetVal;
  }
}
