import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookState extends Equatable {
  BookState([List props = const []]) : super(props);
}

class InitialBookState extends BookState {}
