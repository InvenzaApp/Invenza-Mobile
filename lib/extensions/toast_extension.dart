import 'package:flutter/material.dart';

extension ToastExtension on BuildContext{
  void showToast(String message){
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
