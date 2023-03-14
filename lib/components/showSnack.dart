import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(final context, String str){
  
  return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(str),
              duration: Duration(seconds: 1),
            )
          );
}