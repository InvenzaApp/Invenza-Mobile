import 'dart:convert';

import 'package:crypto/crypto.dart';

extension StringExtension on String{
  String hashString({int textLength = 16}){
    final bites = utf8.encode(this);
    final digest = sha256.convert(bites);
    final hash = digest.toString();

    if (textLength <= 0 || textLength > hash.length) {
      return hash;
    }

    return hash.substring(0, textLength);
  }
}
