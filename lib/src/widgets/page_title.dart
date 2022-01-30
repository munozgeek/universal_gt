import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  List<Widget> _content = [];

  PageTitle(this._content);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 20 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _content,
        ),
      ),
    );
  }
}