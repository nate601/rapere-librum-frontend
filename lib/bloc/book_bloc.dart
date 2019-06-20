import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  @override
  BookState get initialState => InitialBookState();

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
