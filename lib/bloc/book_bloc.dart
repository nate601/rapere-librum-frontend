import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import './bloc.dart';

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
      yield BookLoadedDetails(
        new BookDetails(
          authorName: "test",
          bookName: "test",
          possibleLinks: <String>["test", "test"],
          thumbnailUrl: "test",
        ),
      );
    }
  }
}
