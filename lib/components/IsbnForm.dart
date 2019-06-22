import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapere_librum/bloc/bloc.dart';

class IsbnForm extends StatefulWidget {
  const IsbnForm({
    Key key,
  }) : super(key: key);

  @override
  _IsbnFormState createState() => _IsbnFormState();
}

class _IsbnFormState extends State<IsbnForm> {
  final _formKey = GlobalKey<FormState>();
  final _isbnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "ISBN:",
                      filled: true,
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.book),
                    ),
                    keyboardType: TextInputType.number,
                    validator: isbnValidate,
                    autovalidate: true,
                    controller: _isbnController,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: _searchByCamera,
                    ),
                    RaisedButton(
                      child: Text(
                        "Search",
                      ),
                      onPressed: () {
                        isbnFormSubmit(context);
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String isbnValidate(String value) =>
      value.length == 10 || value.length == 13 ? null : "Enter a valid ISBN";

  void isbnFormSubmit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      print("Isbn: ${_isbnController.text}");
      final bookBloc = BlocProvider.of<BookBloc>(context);
      bookBloc.dispatch(GetBook(_isbnController.text));
    } else {
      print("Invalid Isbn");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please enter a valid ISBN10/13"),
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

  void _searchByCamera() {
    BlocProvider.of<BookBloc>(context).dispatch(StartCameraRead());
  }
}
