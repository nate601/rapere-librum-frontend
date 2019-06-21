import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import 'package:rapere_librum/bloc/bloc.dart';

import 'InitialPage.dart';
import 'InvalidPage.dart';
import 'LoadedPage.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    Key key,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final bookBloc = BookBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => bookBloc,
      child: Container(
        child: BlocBuilder(
          bloc: bookBloc,
          builder: (BuildContext context, BookState state) {
            if (state is BookInitial) {
              return buildInitial();
            } else if (state is BookLoadingDetails) {
              return buildLoading();
            } else if (state is BookLoadedDetails) {
              return buildLoaded(state.foundBook);
            } else if (state is BookInvalid) {
              return buildInvalid();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitial() {
    return new InitialPage();
  }

  Widget buildInvalid() {
    return new InvalidPage(); // * implement invalid page
  }

  Widget buildLoading() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rapere Librum"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildLoaded(BookDetails details) {
    return new LoadedPage(
      details: details,
    );
  }
}
