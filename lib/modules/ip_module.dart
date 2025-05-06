import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class IpModule {
  static String ipAddress(){
    if(kReleaseMode){
      return 'https://kkonrad02.pl:443';
    }

    if(Platform.isAndroid){
      return 'http://10.0.2.2:443';
    }else{
      return 'http://localhost:443';
    }
  }
}
