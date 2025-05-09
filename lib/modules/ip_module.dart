import 'dart:io';
import 'package:flutter/services.dart';

abstract class IpModule {
  static String ipAddress(){
    if(appFlavor == 'production'){
      return 'https://kkonrad02.pl:443';
    }else{
      if(Platform.isAndroid){
        return 'http://10.0.2.2:443';
      }else{
        return 'http://localhost:443';
      }
    }
  }
}
