import 'package:flutter/material.dart';


Widget button(title,current_tab,handler){
  return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: title==current_tab?MaterialStateProperty.all(Colors.blue[400]):MaterialStateProperty.all(Colors.blue[200]),
          ),
          onPressed: (){
            if(current_tab!=title){
              handler(title);
            }
          }, 
          child: Padding(
            padding: const EdgeInsets.only(left:8,right:8,top:4,bottom:4),
            child: Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: title==current_tab?Colors.white:Colors.black,
              ),
            ),
          ),
        );
}