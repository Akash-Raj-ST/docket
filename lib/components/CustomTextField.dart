import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomTextField({required TextEditingController controller,required String label}){
  return Padding(
    padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
    child: TextField(
                maxLength: 100,
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    )
                  )
                ),
          ),
  );
}