import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  final boxDecoration = const BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 1)
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple Gradinet
        Container(decoration: boxDecoration ),

        // Pink box
        Positioned(
          top: -110,
          left: -25,
          child: _PinkBox()
        ),
      ],
    );
  }
}


class _PinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 11,
      child: Container(
        width: 460,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(2, 213, 254, 1),
              Color.fromRGBO(76, 103, 192, 1),
            ]
          )
        ),
      ),
    );
  }
}