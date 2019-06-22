import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapere_librum/bloc/bloc.dart';
import 'package:rapere_librum/components/IsbnForm.dart';

class InvalidPage extends StatelessWidget {
  const InvalidPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Rapere Librum"),
        ),
        body: BlocListener(
          child: IsbnForm(),
          bloc: BlocProvider.of<BookBloc>(context),
          listener: blocListen,
        ));
  }

  void blocListen(BuildContext context, BookState state) {
    if (state is BookInvalid) {
      print("eror");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(
                  "Please enter a valid ISBN10/13 or check your connection to the server."),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
