import 'package:flutter/material.dart';

double xSmallValue = 4;
double smallValue = 8;
double mediumValue = 12;
double largeValue = 16;
double xLargeValue = 24;
double circleValue = 1000;

EdgeInsets get xSmallPadding => EdgeInsets.all(xSmallValue);

EdgeInsets get smallPadding => EdgeInsets.all(smallValue);

EdgeInsets get mediumPadding => EdgeInsets.all(mediumValue);

EdgeInsets get largePadding => EdgeInsets.all(largeValue);

EdgeInsets get xLargePadding => EdgeInsets.all(xLargeValue);

EdgeInsets get xSmallHorizontalPadding =>
    EdgeInsets.symmetric(horizontal: xSmallValue);

EdgeInsets get smallHorizontalPadding =>
    EdgeInsets.symmetric(horizontal: smallValue);

EdgeInsets get mediumHorizontalPadding =>
    EdgeInsets.symmetric(horizontal: mediumValue);

EdgeInsets get largeHorizontalPadding =>
    EdgeInsets.symmetric(horizontal: largeValue);

EdgeInsets get xLargeHorizontalPadding =>
    EdgeInsets.symmetric(horizontal: xLargeValue);

BorderRadiusGeometry xSmallRadius = BorderRadius.circular(xSmallValue);
BorderRadiusGeometry smallRadius = BorderRadius.circular(smallValue);
BorderRadiusGeometry mediumRadius = BorderRadius.circular(mediumValue);
BorderRadiusGeometry largeRadius = BorderRadius.circular(largeValue);
BorderRadiusGeometry xLargeRadius = BorderRadius.circular(xLargeValue);
BorderRadiusGeometry circleRadius = BorderRadius.circular(circleValue);
