import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapere_librum/bloc/bloc.dart';

import '../IsbnForm.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rapere Librum",
        ),
      ),
      body: BlocProvider(
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
                return buildLoaded();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitial() {
    return IsbnForm();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoaded() {
    return Card(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
