import 'package:flutter/material.dart';

Widget heading(String title){
  return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue, 
            ),
          ),
        );
}