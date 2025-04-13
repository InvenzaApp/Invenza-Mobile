import 'package:app/variables.dart';
import 'package:flutter/material.dart';

BorderRadiusGeometry getInkBorderRadius(int index, int listLength) {
  if (index == 0) {
    return BorderRadius.only(
      topLeft: Radius.circular(largeValue),
      topRight: Radius.circular(largeValue),
    );
  }

  if (index == listLength - 1) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(largeValue),
      bottomRight: Radius.circular(largeValue),
    );
  }

  return BorderRadius.zero;
}

BorderRadius getInkWellBorderRadius(int index, int listLength) {
  if(listLength == 0){
    return BorderRadius.circular(largeValue);
  }
  
  if (index == 0) {
    return BorderRadius.only(
      topLeft: Radius.circular(largeValue),
      topRight: Radius.circular(largeValue),
    );
  }

  if (index == listLength - 1) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(largeValue),
      bottomRight: Radius.circular(largeValue),
    );
  }

  return BorderRadius.zero;
}
