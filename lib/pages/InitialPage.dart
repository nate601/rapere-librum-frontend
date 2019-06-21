import 'package:flutter/material.dart';
import 'package:rapere_librum/components/IsbnForm.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Rapere Librum",
        ),
      ),
      body: IsbnForm(),
    );
  }
}
