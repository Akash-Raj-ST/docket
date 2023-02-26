import 'package:flutter/material.dart';

Widget CustomAddButton({required Null Function() onPressed,required String label}){

  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add),
                  ),
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(label),
                  ),
                ),
  );
}