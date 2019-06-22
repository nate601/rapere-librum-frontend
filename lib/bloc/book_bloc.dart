import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rapere_librum/GlobalConstants.dart';
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
      BookDetails getBookDetails = await getBookDetailsFromServer(event.isbn);
      if (getBookDetails != null) {
        yield BookLoadedDetails(getBookDetails);
      } else {
        yield BookInvalid();
      }
    } else if (event is ClearSelection) {
      yield BookInitial();
    } else if (event is StartCameraRead) {
      yield BookLoadingDetails();
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
      BarcodeDetector barcodeDetector =
          FirebaseVision.instance.barcodeDetector();

      List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);
      print(barcodes[0].rawValue);
      if (barcodes.length == 1) {
        var foundBook = await getBookDetailsFromServer(barcodes[0].rawValue);
        if (foundBook == null) {
          yield BookInvalid();
        } else {
          yield BookLoadedDetails(foundBook);
        }
      } else {
        yield BookInvalid();
      }
    }
  }

  Future<BookDetails> getBookDetailsFromServer(String isbn) async {
    var url = GlobalConstants.url;
    var googleBooksReponse = await http.get("$url/api/BookInfoFetch/$isbn");
    if (googleBooksReponse.statusCode != 200) {
      return null;
    }
    var retVal = BookDetails.fromJson(json.decode(googleBooksReponse.body));

    var libgenSearchResponse =
        await http.get("$url/api/BookLinksFetch/${retVal.bookName}");
    if (libgenSearchResponse.statusCode == 200) {
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
    return retVal;
  }
}
