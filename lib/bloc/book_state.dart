import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'Model/BookDetails.dart';

@immutable
abstract class BookState extends Equatable {
  BookState([List props = const []]) : super(props);
}

class BookInitial extends BookState {}

class BookLoadingDetails extends BookState {}

class BookLoadedDetails extends BookState {
  final BookDetails foundBook;

  BookLoadedDetails(this.foundBook) : super([foundBook]);
}
