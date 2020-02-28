import 'package:flutter/material.dart';

Widget centerCard({@required Widget content}) {
  return centerContainer(
    width: 600,
    height: 400,
    content: Card(
      child: content,
    ),
  );
}

Widget centerContainer({
  @required Widget content,
  double width = double.infinity,
  double height = double.infinity,
}) {
  return Center(
    child: Container(
      width: width,
      height: height,
      child: content,
    ),
  );
}
