import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

var mainScreenIconsSize = 40.0;

Decoration cardDecoration() {
  return BoxDecoration(
      //border: Border.all(color: Color(0xE8E8E8)),
      border: Border.all(
          color: Colors.black12, width: 1), // Wi // Will work, width: 1),
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 4), // changes position of shadow
        ),
      ]);
}

EdgeInsetsGeometry cardPaddding() => EdgeInsets.all(20);
EdgeInsetsGeometry cardMargin() =>
    EdgeInsets.symmetric(vertical: 10, horizontal: 20);

var enabledColor = Colors.black;
var disabledColor = Colors.black38;
