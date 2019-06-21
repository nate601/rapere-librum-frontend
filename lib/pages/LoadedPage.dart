import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import 'package:rapere_librum/bloc/bloc.dart';
import 'package:rapere_librum/components/GoogleInfoCard.dart';

class LoadedPage extends StatefulWidget {
  const LoadedPage({
    @required this.details,
    Key key,
  }) : super(key: key);
  final BookDetails details;

  @override
  _LoadedPageState createState() => _LoadedPageState();
}

class _LoadedPageState extends State<LoadedPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Rapere Librum"),
        centerTitle: true,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: goBack,
        ),
      ),
      body: buildBody(widget.details),
    );
  }

  Widget buildBody(BookDetails details) {
    return Column(
      children: <Widget>[
        new GoogleInfoCard(
          details: details,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(),
        ),
        new LibgenInfoCards(details: details)
      ],
    );
  }

  void goBack() {
    final bloc = BlocProvider.of<BookBloc>(context);

    bloc.dispatch(ClearSelection());
  }
}

class LibgenInfoCards extends StatelessWidget {
  final BookDetails details;

  const LibgenInfoCards({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          details.possibleLinks.rows[0].mirrorLinks.length, buildLibgenSubCard),
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  Widget buildLibgenSubCard(int i) {
    return Align(
      alignment: Alignment.topCenter,
      child: RaisedButton(
        child: Text(
            "${getMirrorLinkPrettyName(details.possibleLinks.rows[0].mirrorLinks[i])}"),
        onPressed: () {},
      ),
    );
  }

  String getMirrorLinkPrettyName(String originalName) {
    RegExp prettierRegEx = new RegExp(r"\/\/(.*?)\.");
    return prettierRegEx.firstMatch(originalName).group(1);
  }
}
