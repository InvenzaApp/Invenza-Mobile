import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class IpModule {
  static String get ipAddress => kReleaseMode
      ? 'http://kkonrad02.pl:8080'
      : Platform.isAndroid
          ? 'http://10.0.2.2:8080'
          : 'http://localhost:8080';
}
