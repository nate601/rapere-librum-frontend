import 'package:flutter/material.dart';
import 'package:rapere_librum/bloc/Model/BookDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class LibgenInfoCards extends StatelessWidget {
  final BookDetails details;

  const LibgenInfoCards({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (details == null || details.possibleLinks == null) {
      return Text("Out");
    }
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
          onPressed: () {
            _launchUrl(details.possibleLinks.rows[0].mirrorLinks[i]);
          }),
    );
  }

  _launchUrl(String url) async {
    print("launch $url");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  String getMirrorLinkPrettyName(String originalName) {
    RegExp prettierRegEx = new RegExp(r"\/\/(.*?)\.");
    return prettierRegEx.firstMatch(originalName).group(1);
  }
}
