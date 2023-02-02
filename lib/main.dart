import 'package:docket/tasks/TaskPage.dart';
import 'package:flutter/material.dart';
import './events/EventPage.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            EventPage(),
            TaskPage(),
          ],
        ),
      ),
    );
  }
}