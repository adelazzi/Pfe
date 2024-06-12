

import 'package:flutter/material.dart';

class Underline_g extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: (5)),
      height: 1,
      decoration: BoxDecoration(color: Colors.grey),
      width: double.infinity,
    );
  }
}

class or_ extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: (5)),
          height: 1,
          decoration: BoxDecoration(color: Colors.grey),
          width: 100,

        ),
        Text("OR"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: (5)),
          height: 1,
          decoration: BoxDecoration(color: Colors.grey),

          width: 100,
        ),
      ],
    );
  }
}