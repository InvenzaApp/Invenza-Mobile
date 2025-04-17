import 'package:flutter/material.dart';

double smallValue = 8;
double mediumValue = 12;
double largeValue = 16;
double xLargeValue = 24;

EdgeInsets get smallPadding => EdgeInsets.all(smallValue);
EdgeInsets get mediumPadding => EdgeInsets.all(mediumValue);
EdgeInsets get largePadding => EdgeInsets.all(largeValue);
EdgeInsets get xLargePadding => EdgeInsets.all(xLargeValue);

BorderRadiusGeometry smallRadius = BorderRadius.circular(smallValue);
BorderRadiusGeometry mediumRadius = BorderRadius.circular(mediumValue);
BorderRadiusGeometry largeRadius = BorderRadius.circular(largeValue);
BorderRadiusGeometry xLargeRadius = BorderRadius.circular(xLargeValue);
