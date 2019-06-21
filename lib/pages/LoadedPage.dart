import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import 'package:rapere_librum/bloc/bloc.dart';
import 'package:rapere_librum/components/Stars.dart';

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
      ],
    );
  }

  void goBack() {
    final bloc = BlocProvider.of<BookBloc>(context);

    bloc.dispatch(ClearSelection());
  }
}

class GoogleInfoCard extends StatelessWidget {
  const GoogleInfoCard({
    Key key,
    @required this.details,
  }) : super(key: key);

  final BookDetails details;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          SizedBox(
            child: new Image.network(details.thumbnailUrl),
            width: 128,
            height: 206,
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                "${details.bookName}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "${details.authorName}",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Stars(
                star: details.currentRating,
              )
            ],
          )
        ],
      ),
    );
  }
}
