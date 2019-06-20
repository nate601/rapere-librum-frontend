import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookEvent extends Equatable {
  BookEvent([List props = const []]) : super(props);
}

class GetBook extends BookEvent {
  String isbn;

  GetBook(this.isbn) : super([isbn]);
}
