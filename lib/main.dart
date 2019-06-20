import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage());
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rapere Librum",
        ),
      ),
      body: Container(
        child: IsbnForm(),
      ),
    );
  }
}

class IsbnForm extends StatefulWidget {
  const IsbnForm({
    Key key,
  }) : super(key: key);

  @override
  _IsbnFormState createState() => _IsbnFormState();
}

class _IsbnFormState extends State<IsbnForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
              validator: (String value) =>
                  value.length == 10 || value.length == 13
                      ? null
                      : "Enter a valid ISBN",
              autovalidate: true,
            ),
          ),
          RaisedButton(
            child: Text("Search"),
            onPressed: isbnFormSubmit,
            padding: EdgeInsets.symmetric(horizontal: 100),
          )
        ],
      ),
    );
  }

  void isbnFormSubmit() {
    if (_formKey.currentState.validate()) {
      print("Isbn");
    } else {
      print("Invalid Isbn");
    }
  }
}
