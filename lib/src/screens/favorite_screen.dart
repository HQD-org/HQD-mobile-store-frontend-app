import 'package:flutter/material.dart';

class FavoriteScreent extends StatefulWidget {
  FavoriteScreent({Key? key}) : super(key: key);

  @override
  _FavoriteScreentState createState() => _FavoriteScreentState();
}

class _FavoriteScreentState extends State<FavoriteScreent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Favorite product'),
      ),
    );
  }
}
